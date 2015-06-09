""" XVM (c) www.modxvm.com 2013-2015 """

import os
import traceback

import simplejson

import BigWorld
import GUI
from gui import SystemMessages
from gui.shared.utils import decorators

from xfw import *

from constants import *
from logger import *
import config
import configwatchdog
import stats
import vehinfo
import vehstate
import token
import utils
import userprefs
import dossier
from websock import g_websock
import minimap_circles
import test
import wgutils

_LOG_COMMANDS = (
    XVM_COMMAND.LOAD_STAT_BATTLE,
    XVM_COMMAND.LOAD_STAT_BATTLE_RESULTS,
    XVM_COMMAND.LOAD_STAT_USER,
    XVM_COMMAND.RUN_TEST,
    AS2COMMAND.LOAD_BATTLE_STAT,
    AS2COMMAND.LOGSTAT,
)


def l10n(value):
    return as_xfw_cmd(XVM_COMMAND.AS_L10N, value)


class Xvm(object):

    def __init__(self):
        self.currentPlayerId = None
        self.lobbyFlashObject = None
        self.battleFlashObject = None
        self.vmmFlashObject = None
        self._invalidateTimerId = dict()
        self._invalidateTargets = dict()


    # CONFIG

    def onConfigLoaded(self, e=None):
        #log('onConfigLoaded: {}'.format(e))
        self.respondConfig()
        wgutils.reloadHangar()


    def respondConfig(self):
        as_xfw_cmd(XVM_COMMAND.AS_SET_CONFIG,
                   config.config_str,
                   config.lang_str,
                   vehinfo.getVehicleInfoDataStr())

    # System Message

    def onSystemMessage(self, e=None, cnt=0):
        #log('onSystemMessage')
        is_svcmsg = 'swf_file_name' in xfw_mods_info.info.get('xvm_svcmsg', {})
        if cnt < 50 and is_svcmsg and not 'xvm_svcmsg_ui.swf' in xfw_mods_info.loaded_swfs:
            BigWorld.callback(0.1, lambda:self.onSystemMessage(e, cnt+1))
            return

        msg = e.ctx.get('msg', '')
        type = e.ctx.get('type', SystemMessages.SM_TYPE.Information)
        SystemMessages.pushMessage(msg, type)


    # LOGIN

    def onShowLogin(self, e=None):
        if self.currentPlayerId is not None:
            self.currentPlayerId = None
            g_websock.send('id')
            token.clearToken()


    # LOBBY

    def onShowLobby(self, e=None):
        playerId = getCurrentPlayerId()
        if playerId is not None and self.currentPlayerId != playerId:
            self.currentPlayerId = playerId
            token.checkVersion()
            token.initializeXvmToken()
            g_websock.send('id/%d' % playerId)
        if self.lobbyFlashObject is not None:
            self.lobbyFlashObject.loaderManager.onViewLoaded += self.onViewLoaded

        # TODO
        """
            var message:String = Locale.get("XVM config loaded");
            var type:String = "Information";
            if (Config.__stateInfo.warning != null)
            {
                message = Locale.get("Config file xvm.xc was not found, using the built-in config");
                type = "Warning";
            }
            else if (Config.__stateInfo.error != null)
            {
                message = Locale.get("Error loading XVM config") + ":\n" + XfwUtils.encodeHtmlEntities(Config.__stateInfo.error);
                type = "Error";
            }
            Xfw.cmd(XfwConst.XFW_COMMAND_SYSMESSAGE, message, type);
        """


    def initLobbySwf(self, flashObject):
        self.lobbyFlashObject = flashObject


    def deleteLobbySwf(self):
        self.hangarDispose()
        if self.lobbyFlashObject is not None:
            if self.lobbyFlashObject.loaderManager is not None:
                self.lobbyFlashObject.loaderManager.onViewLoaded -= self.onViewLoaded
            self.lobbyFlashObject = None


    # HANGAR

    def hangarInit(self):
        from CurrentVehicle import g_currentVehicle
        g_currentVehicle.onChanged += self.updateTankParams
        BigWorld.callback(0, self.updateTankParams)

        as_xfw_cmd(XVM_COMMAND.AS_SET_SVC_SETTINGS, token.networkServicesSettings)


    def hangarDispose(self):
        from CurrentVehicle import g_currentVehicle
        g_currentVehicle.onChanged -= self.updateTankParams


    def updateTankParams(self):
        try:
            minimap_circles.updateCurrentVehicle()
            if self.lobbyFlashObject is not None:
                data = simplejson.dumps(minimap_circles.getMinimapCirclesData())
                as_xfw_cmd(XVM_COMMAND.AS_UPDATE_CURRENT_VEHICLE, data)
        except Exception, ex:
            err(traceback.format_exc())


    # PREBATTLE

    def onArenaCreated(self):
        minimap_circles.updateCurrentVehicle()


    # BATTLE

    def onAvatarBecomePlayer(self):
        # check version if game restarted after crash or in replay
        if not token.versionChecked:
            token.checkVersion()
            token.initializeXvmToken()
        if config.get('autoReloadConfig', False) == True:
            configwatchdog.startConfigWatchdog()


    def initBattleSwf(self, flashObject):
        # debug('> initBattleSwf()')
        try:
            self.battleFlashObject = flashObject

            # Save/restore arena data
            player = BigWorld.player()

            fileName = 'arenas_data/{0}'.format(player.arenaUniqueID)

            mcdata = minimap_circles.getMinimapCirclesData()
            vehId = player.vehicleTypeDescriptor.type.compactDescr
            if vehId and mcdata is not None and vehId == mcdata.get('vehId', None):
                # Normal battle start. Update data and save to userprefs cache
                userprefs.set(fileName, {
                    'ver': '1.0',
                    'minimap_circles': minimap_circles.getMinimapCirclesData(),
                })
            else:
                # Replay, training or restarted battle after crash. Try to restore data.
                arena_data = userprefs.get(fileName)
                if arena_data is None:
                    # Set default vehicle data if it is not available.in the cache.
                    minimap_circles.updateMinimapCirclesData(player.vehicleTypeDescriptor)
                else:
                    # Apply restored data.
                    minimap_circles.setMinimapCirclesData(arena_data['minimap_circles'])

        except Exception, ex:
            err(traceback.format_exc())

        self.sendConfig(self.battleFlashObject)

        BigWorld.callback(0, self.invalidateAll)


    def deleteBattleSwf(self):
        # debug('> deleteBattleSwf()')
        self.battleFlashObject = None


    def initVmmSwf(self, flashObject):
        self.vmmFlashObject = flashObject
        self.sendConfig(self.vmmFlashObject)


    def deleteVmmSwf(self):
        self.vmmFlashObject = None


    def invalidateAll(self):
        #debug('invalidateAll')
        self._invalidateTargets.clear()
        for (vID, vData) in BigWorld.player().arena.vehicles.iteritems():
            self.invalidate(vID, INV.ALL)


    def sendConfig(self, flashObject):
        if flashObject is None:
            return
        # debug('sendConfig')
        try:
            movie = flashObject.movie
            if movie is not None:
                from gui.battle_control import arena_info
                arena = BigWorld.player().arena
                movie.invoke((AS2RESPOND.CONFIG, [
                    config.config_str,
                    config.lang_str,
                    arena.extraData.get('battleLevel', 0),
                    arena.bonusType,
                    'fallout' if arena_info.isEventBattle() else 'normal',
                    vehinfo.getVehicleInfoDataStr(),
                    simplejson.dumps(token.networkServicesSettings),
                    simplejson.dumps(minimap_circles.getMinimapCirclesData()),
                    IS_DEVELOPMENT,
                ]))
        except Exception, ex:
            err('sendConfig(): ' + traceback.format_exc())


    def onEnterWorld(self):
        # debug('onEnterWorld: ' + str(BigWorld.player().arena))
        try:
            arena = BigWorld.player().arena
            if arena:
                arena.onVehicleKilled += self._onVehicleKilled
                arena.onAvatarReady += self._onAvatarReady
                arena.onVehicleStatisticsUpdate += self._onVehicleStatisticsUpdate
        except Exception, ex:
            err(traceback.format_exc())


    def onLeaveWorld(self):
        # debug('onLeaveWorld')
        try:
            arena = BigWorld.player().arena
            if arena:
                arena.onVehicleKilled -= self._onVehicleKilled
                arena.onAvatarReady -= self._onAvatarReady
                arena.onVehicleStatisticsUpdate -= self._onVehicleStatisticsUpdate
        except Exception, ex:
            err(traceback.format_exc())

        vehstate.cleanupBattleData()


    def _onVehicleKilled(self, victimID, killerID, reason):
        self.invalidate(victimID, INV.BATTLE_STATE | INV.MARKER_STATUS)


    def _onAvatarReady(self, vID):
        self.invalidate(vID, INV.MARKER_STATUS)


    def _onVehicleStatisticsUpdate(self, vID):
        self.invalidate(vID, INV.MARKER_FRAGS)


    def invalidate(self, vID, inv):
        self._invalidateTargets[vID] = self._invalidateTargets.get(vID, INV.NONE) | inv
        if self._invalidateTimerId.get(vID, None) is None:
            self._invalidateTimerId[vID] = BigWorld.callback(0.3, lambda: self.invalidateCallback(vID))


    def invalidateCallback(self, vID):
        #debug('invalidateCallback: {0}'.format(vID))
        try:
            targets = self._invalidateTargets.get(vID, INV.NONE)
            if targets & INV.BATTLE_ALL:
                self.updateBattle(vID, targets)
            if targets & INV.MARKER_ALL:
                self.updateMarker(vID, targets)
        except Exception, ex:
            err(traceback.format_exc())
        self._invalidateTargets[vID] = INV.NONE
        self._invalidateTimerId[vID] = None


    def updateBattle(self, vID, targets):
        #debug('updateBattle: {0} {1}'.format(targets, vID))

        if self.battleFlashObject is None:
            return

        player = BigWorld.player()
        if player is None or not hasattr(player, 'arena') or player.arena is None:
            return

        state = vehstate.getVehicleStateData(vID)
        if state is None:
            return

        movie = self.battleFlashObject.movie
        if movie is None:
            return

        #debug('updateBattle: {0} {1}'.format(vID, set(state.iteritems())))
        movie.invoke((AS2RESPOND.BATTLE_STATE,
                      targets,
                      state['playerName'],
                      state['playerId'],
                      state['vId'],
                      state['dead'],
                      state['curHealth'],
                      state['maxHealth'],
                      state['marksOnGun'],
                      state['spotted'],
        ))


    def updateMarker(self, vID, targets):
        #debug('updateMarker: {0} {1}'.format(targets, vID))

        if self.vmmFlashObject is None:
            return

        player = BigWorld.player()
        arena = player.arena
        arenaVehicle = arena.vehicles.get(vID, None)
        if arenaVehicle is None:
            return

        stat = arena.statistics.get(vID, None)
        if stat is None:
            return

        vehicle = BigWorld.entity(vID)
        if vehicle is None or not hasattr(vehicle, 'marker'):
            return

        from gui.battle_control.arena_info.settings import VEHICLE_STATUS
        isAlive = arenaVehicle['isAlive']
        isAvatarReady = arenaVehicle['isAvatarReady']
        status = VEHICLE_STATUS.NOT_AVAILABLE
        if isAlive is not None and isAvatarReady is not None:
            if isAlive:
                status |= VEHICLE_STATUS.IS_ALIVE
            if isAvatarReady:
                status |= VEHICLE_STATUS.IS_READY

        frags = stat['frags']

        my_frags = 0
        stat = arena.statistics.get(player.playerVehicleID, None)
        if stat is not None:
            my_frags = stat['frags']

        vInfo = utils.getVehicleInfo(vID)
        squadIndex = vInfo.squadIndex
        from gui.battle_control import g_sessionProvider
        arenaDP = g_sessionProvider.getCtx().getArenaDP()
        squadIndex = vInfo.squadIndex
        if arenaDP.isSquadMan(vID):
            squadIndex += 10

        #debug('updateMarker: {0} st={1} fr={2} sq={3}'.format(vID, status, frags, squadIndex))
        self.vmmFlashObject.invokeMarker(vehicle.marker, 'setMarkerStateXvm', [targets, status, frags, my_frags, squadIndex])


    # PRIVATE

    # returns: (result, status)
    def onXfwCommand(self, cmd, *args):
        try:
            if IS_DEVELOPMENT and cmd in _LOG_COMMANDS:
                debug("cmd=" + str(cmd) + " args=" + simplejson.dumps(args))

            if cmd == XVM_COMMAND.REQUEST_CONFIG:
                self.respondConfig()
                return (None, True)

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

            if cmd == XVM_COMMAND.REQUEST_DOSSIER:
                dossier.requestDossier(args)
                return (None, True)

            if cmd == XVM_COMMAND.GET_SVC_SETTINGS:
                token.getToken()
                return (token.networkServicesSettings, True)

            if cmd == XVM_COMMAND.LOAD_SETTINGS:
                default = None if len(args) < 2 else args[1]
                return (userprefs.get(args[0], default), True)

            if cmd == XVM_COMMAND.LOAD_STAT_BATTLE:
                stats.getBattleStat(args)
                return (None, True)

            if cmd == XVM_COMMAND.LOAD_STAT_BATTLE_RESULTS:
                stats.getBattleResultsStat(args)
                return (None, True)

            if cmd == XVM_COMMAND.LOAD_STAT_USER:
                stats.getUserData(args)
                return (None, True)

            if cmd == XVM_COMMAND.OPEN_URL:
                if len(args[0]):
                    utils.openWebBrowser(args[0], False)
                return (None, True)

            if cmd == XVM_COMMAND.SAVE_SETTINGS:
                userprefs.set(args[0], args[1])
                return (None, True)

            if cmd == XVM_COMMAND.RUN_TEST:
                test.runTest(args)
                return (None, True)

        except Exception, ex:
            err(traceback.format_exc())
            return (None, True)

        return (None, False)


    def onXvmCommand(self, proxy, id, cmd, *args):
        try:
            # debug("id=" + str(id) + " cmd=" + str(cmd) + " args=" + simplejson.dumps(args))
            if IS_DEVELOPMENT and cmd in _LOG_COMMANDS:
                debug("cmd=" + str(cmd) + " args=" + simplejson.dumps(args))
            res = None
            if cmd == AS2COMMAND.LOG:
                log(*args)
            elif cmd == AS2COMMAND.GET_SCREEN_SIZE:
                # return
                res = simplejson.dumps(list(GUI.screenResolution()))
            elif cmd == AS2COMMAND.LOAD_BATTLE_STAT:
                stats.getBattleStat(args, proxy)
            elif cmd == AS2COMMAND.LOAD_SETTINGS:
                res = userprefs.get(args[0])
            elif cmd == AS2COMMAND.SAVE_SETTINGS:
                userprefs.set(args[0], args[1])
            elif cmd == AS2COMMAND.CAPTURE_BAR_GET_BASE_NUM:
                n = int(args[0])
                from gui.shared.utils.functions import getBattleSubTypeBaseNumder
                res = getBattleSubTypeBaseNumder(BigWorld.player().arenaTypeID, n & 0x3, n >> 2)
            else:
                return
            proxy.movie.invoke(('xvm.respond',
                                [id] + res if isinstance(res, list) else [id, res]))
        except Exception, ex:
            err(traceback.format_exc())


    #def extendInvokeArgs(self, swf, methodName, args):
    #    #debug('overrideMovieInvoke: %s %s %s' % (swf, methodName, str(args)))
    #    return args


    def extendVehicleMarkerArgs(self, handle, function, args):
        try:
            if function == 'init':
                if len(args) > 5:
                    #debug('extendVehicleMarkerArgs: %i %s' % (handle, function))
                    v = utils.getVehicleByName(args[5])
                    if hasattr(v, 'publicInfo'):
                        vInfo = utils.getVehicleInfo(v.id)
                        vStats = utils.getVehicleStats(v.id)
                        args.extend([
                            vInfo.player.accountDBID,
                            vInfo.vehicleType.compactDescr,
                            v.publicInfo.marksOnGun,
                            vInfo.vehicleStatus,
                            vStats.frags,
                            vInfo.squadIndex,
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
                # g_websock.send("%s/%i" % ('down' if isDown else 'up', key))
                if self.battleFlashObject is not None:
                    if self.checkKeyEventBattle(key, isDown):
                        movie = self.battleFlashObject.movie
                        if movie is not None:
                            movie.invoke((AS2RESPOND.KEY_EVENT, key, isDown))
        except Exception, ex:
            err('onKeyEvent(): ' + traceback.format_exc())
        return True


    def checkKeyEventBattle(self, key, isDown):
        # do not handle keys when chat is active
        from messenger import MessengerEntry
        if MessengerEntry.g_instance.gui.isFocused():
            return False

        c = config.get('hotkeys')

        if (c['minimapZoom']['enabled'] is True and c['minimapZoom']['keyCode'] == key):
            return True
        if (c['minimapAltMode']['enabled'] is True and c['minimapAltMode']['keyCode'] == key):
            return True
        if (c['playersPanelAltMode']['enabled'] is True and c['playersPanelAltMode']['keyCode'] == key):
            return True

        return False


    def on_websock_message(self, message):
        try:
            pass
            # type = SystemMessages.SM_TYPE.Information
            # msg += message
            # msg += '</textformat>'
            # SystemMessages.pushMessage(msg, type)
        except Exception:
            debug(traceback.format_exc())


    def on_websock_error(self, error):
        try:
            type = SystemMessages.SM_TYPE.Error
            msg = token.getXvmMessageHeader()
            msg += 'WebSocket error: %s' % str(error)
            msg += '</textformat>'
            SystemMessages.pushMessage(msg, type)
        except Exception:
            pass


    def onViewLoaded(self, e=None):
        if e is None:
            return
        if e.uniqueName == 'hangar':
            self.hangarInit()


g_xvm = Xvm()
