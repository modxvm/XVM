"""
SPDX-License-Identifier: GPL-3.0-or-later
Copyright (c) 2013-2024 XVM Contributors
"""

import traceback
import simplejson

import BigWorld
from CurrentVehicle import g_currentVehicle
from messenger import MessengerEntry
from gui import SystemMessages
from gui.app_loader.settings import APP_NAME_SPACE
from gui.shared import g_eventBus, events
from gui.Scaleform.daapi.settings.views import VIEW_ALIAS
from helpers import dependency
from skeletons.gui.app_loader import IAppLoader, GuiGlobalSpaceID

from xfw import *
import xfw_loader.python as xfw_loader
from xfw_actionscript.python import *

from consts import *
from logger import *
import config
import stats
import svcmsg
import vehinfo
import utils
import userprefs
import disabled_servers
import dossier
import minimap_circles
import pymacro
import reserve
import topclans
import wgutils
import xvmapi
import xvm_debug

_LOG_COMMANDS = (
    XVM_COMMAND.LOAD_STAT_BATTLE,
    XVM_COMMAND.LOAD_STAT_BATTLE_RESULTS,
    XVM_COMMAND.LOAD_STAT_USER,
)


# performs translations and fixes image path
def l10n(text):

    if text is None:
        return None

    lang_data = config.lang_data.get('locale', {})

    if text in lang_data:
        text = lang_data[text]
        if text is None:
            return None

    while True:
        localizedMacroStart = text.find('{{l10n:')
        if localizedMacroStart == -1:
            break
        localizedMacroEnd = text.find('}}', localizedMacroStart)
        if localizedMacroEnd == -1:
            break

        macro = text[localizedMacroStart + 7:localizedMacroEnd]

        parts = macro.split(':')
        macro = lang_data.get(parts[0], parts[0])
        parts = parts[1:]
        if len(parts) > 0:
            try:
                macro = macro.format(*parts)
            except Exception as ex:
                err('macro:  {}'.format(macro))
                err('params: {}'.format(parts))
                err(traceback.format_exc())

        text = text[:localizedMacroStart] + macro + text[localizedMacroEnd + 2:]
        #log(text)

    return utils.fixImgTag(lang_data.get(text, text))

class Xvm(object):
    _initialized_apps = {}

    appLoader = dependency.descriptor(IAppLoader)

    # INIT

    def __init__(self):
        trace('xvm_main.python.xvm::XVM::__init__()')

        self.xvmServicesInitialized = False
        self.xvmLobbyMessageShown = False
        self.xvmServerMessageLastInfo = None
        self.currentAccountDBID = None

    def initialize(self):
        trace('xvm_main.python.xvm::XVM::initialize()')

        disabled_servers.initialize()
        vehinfo.initialize()

    # CONFIG

    def onConfigLoaded(self, e=None):
        trace('xvm_main.python.xvm::XVM::onConfigLoaded()')

        disabled_servers.initialize()

        if not e or not e.ctx.get('fromInitStage', False):
            self.respondConfig()
            wgutils.reloadHangar()

    def respondConfig(self):
        trace('xvm_main.python.xvm::XVM::respondConfig()')

        as_xfw_cmd(XVM_COMMAND.AS_SET_CONFIG,
                   config.config_data,
                   config.lang_data,
                   vehinfo.getVehicleInfoDataArray(),
                   config.networkServicesSettings.__dict__,
                   IS_DEVELOPMENT)

    # System Message

    def onSystemMessage(self, e=None, cnt=0):
        #trace('onSystemMessage')
        msg = e.ctx.get('msg', '')
        type = e.ctx.get('type', SystemMessages.SM_TYPE.Information)
        if type not in [SystemMessages.SM_TYPE.Information, SystemMessages.SM_TYPE.GameGreeting]:
            log('SystemMessage: [{}] {}'.format(type, utils.hide_guid(msg)))
        SystemMessages.pushMessage(msg, type)

    # Check Activation

    def onCheckActivation(self, e=None):
        # log('xvm.onCheckActivation')
        status = config.token.status
        if status == 'active':
            svcmsg.tokenUpdated()
        else:
            self.xvmServicesInitialized = False
            self.initializeXvmServices()
            status = config.token.status
            if status == 'badToken' or status == 'inactive':
                svcmsg.sendXvmSystemMessage(SystemMessages.SM_TYPE.Warning, '{{l10n:token/services_not_activated}}')
            else:
                g_eventBus.handleEvent(events.HasCtxEvent(XVM_EVENT.CONFIG_LOADED))
                svcmsg.tokenUpdated()
                self.showXvmServicesLobbyMessage()

    # state handler

    def onAppInitialized(self, event):
        if self._initialized_apps.get(event.ctx.ns, None) is not None:
            return
        self._initialized_apps[event.ctx.ns] = True

        trace('onAppInitialized: {}'.format(event.ctx.ns))

        app = self.appLoader.getApp(event.ctx.ns)
        if app is not None and app.loaderManager is not None:
            app.loaderManager.onViewLoaded += self.onViewLoaded
        # initialize XVM services if game restarted after crash or in replay
        if event.ctx.ns == APP_NAME_SPACE.SF_BATTLE:
            self.initializeXvmServices()

    def onAppDestroyed(self, event):
        trace('onAppDestroyed: {}'.format(event.ctx.ns))
        if event.ctx.ns in self._initialized_apps:
            del self._initialized_apps[event.ctx.ns]
        if event.ctx.ns == APP_NAME_SPACE.SF_LOBBY:
            self.hangarDispose()
        app = self.appLoader.getApp(event.ctx.ns)
        if app is not None and app.loaderManager is not None:
            app.loaderManager.onViewLoaded -= self.onViewLoaded

    def onGUISpaceEntered(self, spaceID):
        #trace('onGUISpaceEntered: {}'.format(spaceID))
        if spaceID == GuiGlobalSpaceID.LOGIN:
            self.onStateLogin()
        elif spaceID == GuiGlobalSpaceID.LOBBY:
            self.onStateLobby()
        elif spaceID == GuiGlobalSpaceID.BATTLE_LOADING:
            self.onStateBattleLoading()
        elif spaceID == GuiGlobalSpaceID.BATTLE:
            self.onStateBattle()

    # LOGIN

    def onStateLogin(self):
        trace('onStateLogin')
        if self.currentAccountDBID is not None:
            self.currentAccountDBID = None
            config.token = config.XvmServicesToken()
        reserve.init(None)


    # LOBBY

    def onStateLobby(self):
        trace('onStateLobby')
        try:
            accountDBID = getCurrentAccountDBID()
            if accountDBID is not None and self.currentAccountDBID != accountDBID:
                self.currentAccountDBID = accountDBID
                config.token = config.XvmServicesToken({'accountDBID': accountDBID})
                config.token.saveLastAccountDBID()
                self.xvmServicesInitialized = False
                self.initializeXvmServices()
                svcmsg.tokenUpdated()

            reserve.init(self.currentAccountDBID)

            self.showXvmServicesLobbyMessage()

        except Exception, ex:
            err(traceback.format_exc())


    # HANGAR

    def hangarInit(self):
        trace('hangarInit')
        g_currentVehicle.onChanged += self.updateTankParams
        BigWorld.callback(0, self.updateTankParams)

        if IS_DEVELOPMENT:
            xvm_debug.onHangarInit()

    def hangarDispose(self):
        trace('hangarDispose')
        g_currentVehicle.onChanged -= self.updateTankParams

    def updateTankParams(self):
        try:
            minimap_circles.updateCurrentVehicle()
            lobby = getLobbyApp()
            if lobby is not None:
                as_xfw_cmd(XVM_COMMAND.AS_UPDATE_CURRENT_VEHICLE,
                           g_currentVehicle.item.intCD,
                           minimap_circles.getMinimapCirclesData())
        except Exception, ex:
            err(traceback.format_exc())


    # PREBATTLE

    def onStateBattleLoading(self):
        trace('onStateBattleLoading')

    def onArenaCreated(self):
        trace('onArenaCreated')
        minimap_circles.updateCurrentVehicle()


    # PRE-BATTLE

    def onBecomePlayer(self):
        trace('onBecomePlayer')
        try:
            pass
        except Exception, ex:
            err(traceback.format_exc())

    def onBecomeNonPlayer(self):
        trace('onBecomeNonPlayer')
        try:
            pass
        except Exception, ex:
            err(traceback.format_exc())


    # BATTLE

    def onStateBattle(self):
        trace('onStateBattle')


    # PRIVATE

    # returns: (result, status)
    def onXfwCommand(self, cmd, *args):
        try:
            if IS_DEVELOPMENT and cmd in _LOG_COMMANDS:
                debug("cmd=" + str(cmd) + " args=" + simplejson.dumps(args))

            # common

            if cmd == XVM_COMMAND.REQUEST_CONFIG:
                self.respondConfig()
                return (None, True)

            if cmd == XVM_COMMAND.PYTHON_MACRO:
                return (pymacro.process_python_macro(args[0]), True)

            if cmd == XVM_COMMAND.GET_PLAYER_ID:
                return (getCurrentAccountDBID(), True)

            if cmd == XVM_COMMAND.GET_PLAYER_NAME:
                return (utils.getAccountPlayerName(), True)

            if cmd == XVM_COMMAND.GET_PLAYER_CLAN_ID:
                return (utils.getClanDBID(), True)

            if cmd == XVM_COMMAND.GET_PLAYER_CLAN_NAME:
                return (utils.getClanAbbrev(), True)

            if cmd == XVM_COMMAND.GET_PLAYER_DOSSIER_VALUE:
                return (dossier.getAccountDossierValue(args[0]), True)

            if cmd == XVM_COMMAND.GET_CURRENT_VEH_CD:
                return (g_currentVehicle.item.intCD if g_currentVehicle.item else 0, True)

            if cmd == XVM_COMMAND.GET_SVC_SETTINGS:
                return (config.networkServicesSettings.__dict__, True)

            if cmd == XVM_COMMAND.LOAD_SETTINGS:
                default = None if len(args) < 2 else args[1]
                return (userprefs.get(args[0], default), True)

            if cmd == XVM_COMMAND.SAVE_SETTINGS:
                userprefs.set(args[0], args[1])
                return (None, True)

            if cmd == XVM_COMMAND.OPEN_WEB_BROWSER:
                BigWorld.wg_openWebBrowser(args[0])
                return (None, True)

            # battle

            if cmd == XVM_COMMAND.GET_CLAN_ICON:
                return (stats.getClanIcon(int(args[0])), True)

            # lobby

            if cmd == XVM_COMMAND.REQUEST_DOSSIER:
                dossier.requestDossier(args)
                return (None, True)

            # stat

            if cmd == XVM_COMMAND.LOAD_STAT_BATTLE:
                stats.getBattleStat(args, as_xfw_cmd)
                return (None, True)

            if cmd == XVM_COMMAND.LOAD_STAT_BATTLE_RESULTS:
                stats.getBattleResultsStat(args, as_xfw_cmd)
                return (None, True)

            if cmd == XVM_COMMAND.LOAD_STAT_USER:
                stats.getUserData(args, as_xfw_cmd)
                return (None, True)

            # profiler

            if cmd in (XVM_PROFILER_COMMAND.BEGIN, XVM_PROFILER_COMMAND.END):
                g_eventBus.handleEvent(events.HasCtxEvent(cmd, args[0]))
                return (None, True)

        except Exception, ex:
            err(traceback.format_exc())
            return (None, True)

        return (None, False)

    def showXvmServicesLobbyMessage(self):
        if config.networkServicesSettings.statBattle:
            data = xvmapi.getServerMessage()
            if data:
                msg = data.get('msg', None)
                if msg:
                    svcmsg.sendXvmSystemMessage(SystemMessages.SM_TYPE.Warning, msg)
                elif self.xvmLobbyMessageShown:
                    msg = data.get('info', None)
                    if msg != self.xvmServerMessageLastInfo:
                        self.xvmServerMessageLastInfo = msg
                        if msg:
                            svcmsg.sendXvmSystemMessage(SystemMessages.SM_TYPE.Information, msg)

        self.xvmLobbyMessageShown = True

    def initializeXvmServices(self):
        if self.xvmServicesInitialized:
            return

        accountDBID = utils.getAccountDBID()
        if accountDBID is None and not isReplay():
            return

        self.xvmServicesInitialized = True
        self.xvmLobbyMessageShown = False
        self.xvmServerMessageLastInfo = None

        config.token = config.XvmServicesToken.restore()
        config.token.updateTokenFromApi()

        data = xvmapi.getVersion(config.networkServicesSettings.topClansCountWgm, config.networkServicesSettings.topClansCountWsh)
        topclans.update(data)
        config.verinfo = config.XvmVersionInfo(data)

        g_eventBus.handleEvent(events.HasCtxEvent(XVM_EVENT.XVM_SERVICES_INITIALIZED))

    def onKeyEvent(self, event):
        try:
            if not event.isRepeatedEvent():
                # debug("key=" + str(event.key) + ' ' + ('down' if event.isKeyDown() else 'up'))
                spaceID = self.appLoader.getSpaceID()
                if spaceID == GuiGlobalSpaceID.BATTLE:
                    app = getBattleApp()
                    if app and not MessengerEntry.g_instance.gui.isFocused():
                        as_xfw_cmd(XVM_COMMAND.AS_ON_KEY_EVENT, event.key, event.isKeyDown())
                elif spaceID == GuiGlobalSpaceID.LOBBY:
                    app = getLobbyApp()
                    if app:
                        as_xfw_cmd(XVM_COMMAND.AS_ON_KEY_EVENT, event.key, event.isKeyDown())
        except Exception, ex:
            err('onKeyEvent(): ' + traceback.format_exc())

    def onUpdateStage(self):
        try:
            as_xfw_cmd(XVM_COMMAND.AS_ON_UPDATE_STAGE)
        except Exception, ex:
            err('onUpdateStage(): ' + traceback.format_exc())

    def onViewLoaded(self, view, loadParams):
        trace('onViewLoaded: {}'.format('(None)' if not view else view.uniqueName))
        if not view:
            return
        if view.uniqueName == VIEW_ALIAS.LOBBY_HANGAR:
            self.hangarInit()

g_xvm = Xvm()
