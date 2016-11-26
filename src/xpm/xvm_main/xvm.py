""" XVM (c) www.modxvm.com 2013-2016 """

import traceback
import simplejson

import BigWorld
from CurrentVehicle import g_currentVehicle
from messenger import MessengerEntry
from gui import SystemMessages
from gui.app_loader import g_appLoader
from gui.app_loader.settings import APP_NAME_SPACE, GUI_GLOBAL_SPACE_ID
from gui.shared import g_eventBus, events
from gui.Scaleform.daapi.settings.views import VIEW_ALIAS

from xfw import *

from consts import *
from logger import *
import config
import configwatchdog
import stats
import svcmsg
import vehinfo
import utils
import userprefs
import dossier
import minimap_circles
import python_macro
import test
import topclans
import wgutils
import xvmapi
import vehinfo_xtdb

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

    def __init__(self):
        self.xvmServicesInitialized = False
        self.currentAccountDBID = None

    # CONFIG

    def onConfigLoaded(self, e=None):
        trace('onConfigLoaded')

        python_macro.initialize()

        # initialize XVM services in replay
        if isReplay():
            self.initializeXvmServices()

        if not e or not e.ctx.get('fromInitStage', False):
            self.respondConfig()
            wgutils.reloadHangar()


    def respondConfig(self):
        trace('respondConfig')
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
        SystemMessages.pushMessage(msg, type)

    # state handler

    def onAppInitialized(self, event):
        trace('onAppInitialized: {}'.format(event.ns))
        app = g_appLoader.getApp(event.ns)
        if app is not None and app.loaderManager is not None:
            app.loaderManager.onViewLoaded += self.onViewLoaded

    def onAppDestroyed(self, event):
        trace('onAppDestroyed: {}'.format(event.ns))
        if event.ns == APP_NAME_SPACE.SF_LOBBY:
            self.hangarDispose()
        app = g_appLoader.getApp(event.ns)
        if app is not None and app.loaderManager is not None:
            app.loaderManager.onViewLoaded -= self.onViewLoaded

    def onGUISpaceEntered(self, spaceID):
        #trace('onGUISpaceEntered: {}'.format(spaceID))
        if spaceID == GUI_GLOBAL_SPACE_ID.LOGIN:
            self.onStateLogin()
        elif spaceID == GUI_GLOBAL_SPACE_ID.LOBBY:
            self.onStateLobby()
        elif spaceID == GUI_GLOBAL_SPACE_ID.BATTLE_LOADING:
            self.onStateBattleLoading()
        elif spaceID == GUI_GLOBAL_SPACE_ID.BATTLE:
            self.onStateBattle()

    # LOGIN

    def onStateLogin(self):
        trace('onStateLogin')
        if self.currentAccountDBID is not None:
            self.currentAccountDBID = None
            config.token = config.XvmServicesToken()


    # LOBBY

    def onStateLobby(self):
        trace('onStateLobby')
        try:
            accountDBID = getCurrentAccountDBID()
            if accountDBID is not None and self.currentAccountDBID != accountDBID:
                self.currentAccountDBID = accountDBID
                config.token = config.XvmServicesToken({'accountDBID':accountDBID})
                config.token.saveLastAccountDBID()
                self.xvmServicesInitialized = False
                self.initializeXvmServices()

        except Exception, ex:
            err(traceback.format_exc())


    # HANGAR

    def hangarInit(self):
        trace('hangarInit')
        g_currentVehicle.onChanged += self.updateTankParams
        BigWorld.callback(0, self.updateTankParams)

        if IS_DEVELOPMENT:
            test.onHangarInit()

    def hangarDispose(self):
        trace('hangarDispose')
        g_currentVehicle.onChanged -= self.updateTankParams

    def updateTankParams(self):
        try:
            minimap_circles.updateCurrentVehicle()
            lobby = getLobbyApp()
            if lobby is not None:
                as_xfw_cmd(XVM_COMMAND.AS_UPDATE_CURRENT_VEHICLE, minimap_circles.getMinimapCirclesData())
        except Exception, ex:
            err(traceback.format_exc())


    # PREBATTLE

    def onStateBattleLoading(self):
        trace('onStateBattleLoading')
        # initialize XVM services if game restarted after crash
        self.initializeXvmServices()

    def onArenaCreated(self):
        trace('onArenaCreated')
        minimap_circles.updateCurrentVehicle()


    # PRE-BATTLE

    def onBecomePlayer(self):
        trace('onBecomePlayer')
        try:
            if config.get('autoReloadConfig', False) == True:
                configwatchdog.startConfigWatchdog()
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
        minimap_circles.save_or_restore()


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
                return (python_macro.process_python_macro(args[0]), True)

            if cmd == XVM_COMMAND.GET_PLAYER_NAME:
                return (BigWorld.player().name, True)

            if cmd == XVM_COMMAND.GET_SVC_SETTINGS:
                return (config.networkServicesSettings.__dict__, True)

            if cmd == XVM_COMMAND.LOAD_SETTINGS:
                default = None if len(args) < 2 else args[1]
                return (userprefs.get(args[0], default), True)

            if cmd == XVM_COMMAND.SAVE_SETTINGS:
                userprefs.set(args[0], args[1])
                return (None, True)

            # battleloading, battle

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
                stats.getBattleResultsStat(args)
                return (None, True)

            if cmd == XVM_COMMAND.LOAD_STAT_USER:
                stats.getUserData(args)
                return (None, True)

            # profiler

            if cmd in (XVM_PROFILER_COMMAND.BEGIN, XVM_PROFILER_COMMAND.END):
                g_eventBus.handleEvent(events.HasCtxEvent(cmd, args[0]))
                return (None, True)

        except Exception, ex:
            err(traceback.format_exc())
            return (None, True)

        return (None, False)

    def initializeXvmServices(self):
        if self.xvmServicesInitialized:
            return

        accountDBID = utils.getAccountDBID()
        if accountDBID is None and not isReplay():
            return

        self.xvmServicesInitialized = True

        config.token = config.XvmServicesToken.restore()
        config.token.updateTokenFromApi()

        if config.networkServicesSettings.servicesActive and config.networkServicesSettings.statBattle:
            #data = xvmapi.getVersion()
            #topclans.clear()
            data = xvmapi.getVersionWithLimit(config.networkServicesSettings.topClansCount)
            topclans.update(data)
        else:
            data = xvmapi.getVersionWithLimit(config.networkServicesSettings.topClansCount)
            topclans.update(data)
        config.verinfo = config.XvmVersionInfo(data)

        if g_appLoader.getSpaceID() == GUI_GLOBAL_SPACE_ID.LOBBY:
            svcmsg.tokenUpdated()

    def onKeyEvent(self, event):
        try:
            if not event.isRepeatedEvent():
                # debug("key=" + str(event.key) + ' ' + ('down' if event.isKeyDown() else 'up'))
                battle = getBattleApp()
                if battle and not MessengerEntry.g_instance.gui.isFocused():
                    as_xfw_cmd(XVM_COMMAND.AS_ON_KEY_EVENT, event.key, event.isKeyDown())
        except Exception, ex:
            err('onKeyEvent(): ' + traceback.format_exc())

    def onUpdateStage(self):
        try:
            as_xfw_cmd(XVM_COMMAND.AS_ON_UPDATE_STAGE)
        except Exception, ex:
            err('onUpdateStage(): ' + traceback.format_exc())

    def onViewLoaded(self, view=None):
        trace('onViewLoaded: {}'.format('(None)' if not view else view.uniqueName))
        if not view:
            return
        if view.uniqueName == VIEW_ALIAS.LOBBY_HANGAR:
            self.hangarInit()

g_xvm = Xvm()
