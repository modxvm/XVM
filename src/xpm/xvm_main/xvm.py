""" XVM (c) www.modxvm.com 2013-2016 """

import os
import traceback
import weakref
import simplejson

import BigWorld
import GUI
from CurrentVehicle import g_currentVehicle
from messenger import MessengerEntry
from gui import SystemMessages
from gui.app_loader import g_appLoader
from gui.app_loader.settings import APP_NAME_SPACE, GUI_GLOBAL_SPACE_ID
from gui.battle_control import g_sessionProvider
from gui.battle_control.arena_info.settings import VEHICLE_STATUS
from gui.battle_control.battle_constants import PLAYER_GUI_PROPS
from gui.Scaleform.daapi.settings.views import VIEW_ALIAS

from xfw import *

from constants import *
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
import xmqp
import xmqp_events

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
        self.currentPlayerId = None

    # CONFIG

    def onConfigLoaded(self, e=None):
        trace('onConfigLoaded')

        python_macro.initialize()

        # initialize XVM services in replay
        if isReplay():
            self.initializeXvmServices()

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
        if self.currentPlayerId is not None:
            self.currentPlayerId = None
            config.token = config.XvmServicesToken()


    # LOBBY

    def onStateLobby(self):
        trace('onStateLobby')
        try:
            playerId = getCurrentPlayerId()
            if playerId is not None and self.currentPlayerId != playerId:
                self.currentPlayerId = playerId
                config.token = config.XvmServicesToken({'playerId':playerId})
                config.token.saveLastPlayerId()
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
            self.xmqp_init()
            if config.get('autoReloadConfig', False) == True:
                configwatchdog.startConfigWatchdog()
        except Exception, ex:
            err(traceback.format_exc())

    def onBecomeNonPlayer(self):
        trace('onBecomeNonPlayer')
        try:
            self.xmqp_stop()
        except Exception, ex:
            err(traceback.format_exc())


    # BATTLE

    def onStateBattle(self):
        trace('onStateBattle')
        xmqp_events.onStateBattle()
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

            if cmd == XVM_COMMAND.GET_BATTLE_LEVEL:
                arena = getattr(BigWorld.player(), 'arena', None)
                if arena is not None:
                    return (arena.extraData.get('battleLevel', 0), True)
                return (None, True)

            if cmd == XVM_COMMAND.GET_BATTLE_TYPE:
                arena = getattr(BigWorld.player(), 'arena', None)
                if arena is not None:
                    return (arena.bonusType, True)
                return (None, True)

            if cmd == XVM_COMMAND.GET_MAP_SIZE:
                return (utils.getMapSize(), True)

            if cmd == XVM_COMMAND.GET_MY_VEHCD:
                return (getVehCD(BigWorld.player().playerVehicleID), True)

            # lobby

            if cmd == XVM_COMMAND.REQUEST_DOSSIER:
                dossier.requestDossier(args)
                return (None, True)

            # stat

            if cmd == XVM_COMMAND.LOAD_STAT_BATTLE:
                stats.getBattleStat(args)
                return (None, True)

            if cmd == XVM_COMMAND.LOAD_STAT_BATTLE_RESULTS:
                stats.getBattleResultsStat(args)
                return (None, True)

            if cmd == XVM_COMMAND.LOAD_STAT_USER:
                stats.getUserData(args)
                return (None, True)

        except Exception, ex:
            err(traceback.format_exc())
            return (None, True)

        return (None, False)

    def initializeXvmServices(self):
        if self.xvmServicesInitialized:
            return

        playerId = utils.getPlayerId()
        if playerId is None and not isReplay():
            return

        self.xvmServicesInitialized = True

        config.token = config.XvmServicesToken.restore()
        config.token.updateTokenFromApi()

        if config.networkServicesSettings.servicesActive and config.networkServicesSettings.statBattle:
            data = xvmapi.getVersion()
            topclans.clear()
        else:
            data = xvmapi.getVersionWithLimit(config.networkServicesSettings.topClansCount)
            topclans.update(data)
        config.verinfo = config.XvmVersionInfo(data)

        if g_appLoader.getSpaceID() == GUI_GLOBAL_SPACE_ID.LOBBY:
            svcmsg.tokenUpdated()

    def extendVehicleMarkerArgs(self, handle, function, args):
        try:
            if function == 'init':
                if len(args) > 5:
                    #debug('extendVehicleMarkerArgs: %i %s' % (handle, function))
                    v = utils.getVehicleByName(args[5])
                    if hasattr(v, 'publicInfo'):
                        vInfo = utils.getVehicleInfo(v.id)
                        vStats = utils.getVehicleStats(v.id)
                        squadIndex = vInfo.squadIndex
                        arenaDP = g_sessionProvider.getArenaDP()
                        if arenaDP.isSquadMan(v.id):
                            squadIndex += 10
                        args.extend([
                            vInfo.player.accountDBID,
                            vInfo.vehicleType.compactDescr,
                            v.publicInfo.marksOnGun,
                            vInfo.vehicleStatus,
                            vStats.frags,
                            squadIndex,
                        ])
            elif function not in ['showExInfo']:
                # debug('extendVehicleMarkerArgs: %i %s %s' % (handle, function, str(args)))
                pass
        except Exception, ex:
            err('extendVehicleMarkerArgs(): ' + traceback.format_exc())
        return args

    def onKeyEvent(self, event):
        try:
            key = event.key
            isDown = event.isKeyDown()
            isRepeated = event.isRepeatedEvent()
            if not isRepeated:
                # debug("key=" + str(key) + ' ' + ('down' if isDown else 'up'))
                battle = getBattleApp()
                if battle:
                    if self.checkKeyEventBattle(key, isDown):
                        as_xfw_cmd(XVM_COMMAND.AS_ON_KEY_EVENT, key, isDown)
        except Exception, ex:
            err('onKeyEvent(): ' + traceback.format_exc())
        return True

    def checkKeyEventBattle(self, key, isDown):
        # do not handle keys when chat is active
        if MessengerEntry.g_instance.gui.isFocused():
            return False

        c = config.get('hotkeys')

        if c['minimapZoom']['enabled'] is True and c['minimapZoom']['keyCode'] == key:
            return True
        if c['minimapAltMode']['enabled'] is True and c['minimapAltMode']['keyCode'] == key:
            return True
        if c['playersPanelAltMode']['enabled'] is True and c['playersPanelAltMode']['keyCode'] == key:
            return True
        if c['battleLabelsHotKeys'] is True:
            return True

        return False

    def onViewLoaded(self, view=None):
        debug('> onViewLoaded: {}'.format('(None)' if not view else view.uniqueName))
        if not view:
            return
        if view.uniqueName == VIEW_ALIAS.LOBBY_HANGAR:
            self.hangarInit()

    def xmqp_init(self):
        #debug('xmqp_init')
        if isReplay() and xmqp.XMQP_DEVELOPMENT:
            config.token = config.XvmServicesToken.restore()
        if config.networkServicesSettings.xmqp or (isReplay() and xmqp.XMQP_DEVELOPMENT):
            if not isReplay() or xmqp.XMQP_DEVELOPMENT:
                token = config.token.token
                if token is not None and token != '':
                    players = []
                    player = BigWorld.player()
                    player_team = player.team if hasattr(player, 'team') else 0
                    for (vehicleID, vData) in player.arena.vehicles.iteritems():
                        # ally team only
                        if vData['team'] == player_team:
                            players.append(vData['accountDBID'])
                    if xmqp.XMQP_DEVELOPMENT:
                        currentPlayerId = utils.getPlayerId()
                        if currentPlayerId not in players:
                            players.append(currentPlayerId)
                    xmqp.start(players)

    def xmqp_stop(self):
        xmqp.stop()

g_xvm = Xvm()
