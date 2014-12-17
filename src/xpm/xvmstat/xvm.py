""" XVM (c) www.modxvm.com 2013-2014 """

import os
import traceback

import simplejson

import BigWorld
import GUI
from gui.shared.utils import decorators
from gui import SystemMessages

from xpm import *

import config
from constants import *
from logger import *
from pinger import *
#from pinger_wg import *
from stats import getBattleStat, getBattleResultsStat, getUserData
from dossier import getDossier
from vehinfo import getVehicleInfoDataStr
import vehstate
import token
import comments
import utils
import userprefs
from websock import g_websock
from minimap_circles import g_minimap_circles
import wgcompat
from test import runTest

_LOG_COMMANDS = (
  COMMAND_LOADBATTLESTAT,
  COMMAND_LOADBATTLERESULTSSTAT,
  COMMAND_LOGSTAT,
  COMMAND_TEST,
  )

class Xvm(object):
    def __init__(self):
        self.currentPlayerId = None
        config.config = None
        self.config_str = None
        self.lang_str = None
        self.lang_data = None
        self.app = None
        self.battleFlashObject = None
        self.vmmFlashObject = None
        self._battleStateTimersId = dict()
        self._battleStateData = dict()
        self._battleStateLast = dict()
        self._vehicleStatusLast = dict()
        self._vehicleStatsLast = dict()

    # returns: (result, status)
    def onXpmCommand(self, cmd, *args):
        try:
            if (cmd in _LOG_COMMANDS):
                debug("cmd=" + str(cmd) + " args=" + simplejson.dumps(args))
            if cmd == XVM_COMMAND_GET_SVC_SETTINGS:
                token.getToken()
                return (token.networkServicesSettings, True)
            elif cmd == XVM_COMMAND_UNLOAD_TANKMAN:
                wgcompat.g_instance.unloadTankman(args[0])
                return (None, True)
            elif cmd == XVM_COMMAND_GET_BATTLE_LEVEL:
                arena = getattr(BigWorld.player(), 'arena', None)
                if arena is not None:
                    return (arena.extraData.get('battleLevel'), True)
                return (0, True)

        except Exception, ex:
            err(traceback.format_exc())

        return (None, False)

    def onXvmCommand(self, proxy, id, cmd, *args):
        try:
            #debug("id=" + str(id) + " cmd=" + str(cmd) + " args=" + simplejson.dumps(args))
            if (cmd in _LOG_COMMANDS):
                debug("cmd=" + str(cmd) + " args=" + simplejson.dumps(args))
            res = None
            if cmd == COMMAND_LOG:
                log(*args)
            elif cmd == COMMAND_SET_CONFIG:
                #debug('setConfig')
                self.config_str = args[0]
                config.config = simplejson.loads(self.config_str)
                if len(args) >= 2:
                    self.lang_str = args[1]
                    self.lang_data = simplejson.loads(self.lang_str)
                self.sendConfig(self.battleFlashObject)
                self.sendConfig(self.vmmFlashObject)
            elif cmd == COMMAND_PING:
                #return
                ping(proxy)
            elif cmd == COMMAND_GETSCREENSIZE:
                #return
                res = simplejson.dumps(list(GUI.screenResolution()))
            elif cmd == COMMAND_GETVEHICLEINFODATA:
                #return
                res = getVehicleInfoDataStr()
            elif cmd == COMMAND_LOADBATTLESTAT:
                getBattleStat(proxy, args)
            elif cmd == COMMAND_LOADBATTLERESULTSSTAT:
                getBattleResultsStat(proxy, args)
            elif cmd == COMMAND_LOADUSERDATA:
                getUserData(proxy, args)
            elif cmd == COMMAND_GETDOSSIER:
                getDossier(proxy, args)
            elif cmd == COMMAND_RETURN_CREW:
                wgcompat.g_instance.processReturnCrew()
            elif cmd == COMMAND_OPEN_URL:
                if len(args[0]):
                    utils.openWebBrowser(args[0], False)
            elif cmd == COMMAND_LOAD_SETTINGS:
                res = userprefs.get(args[0])
            elif cmd == COMMAND_SAVE_SETTINGS:
                userprefs.set(args[0], args[1])
            elif cmd == COMMAND_GETCOMMENTS:
                res = comments.getXvmUserComments(args[0])
            elif cmd == COMMAND_SETCOMMENTS:
                res = comments.setXvmUserComments(args[0])
            elif cmd == COMMAND_CAPTUREBARGETBASENUM:
                n = int(args[0])
                from gui.shared.utils.functions import getBattleSubTypeBaseNumder
                res = getBattleSubTypeBaseNumder(BigWorld.player().arenaTypeID, n & 0x3, n >> 2)
            elif cmd == COMMAND_TEST:
                runTest(args)
            else:
                err("unknown command: " + str(cmd))
            proxy.movie.invoke(('xvm.respond',
                [id] + res if isinstance(res, list) else [id, res]))
        except Exception, ex:
            err(traceback.format_exc())

    def extendInvokeArgs(self, swf, methodName, args):
        #debug('overrideMovieInvoke: %s %s %s' % (swf, methodName, str(args)))
        return args

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
                            v.publicInfo.marksOnGun,
                            vInfo.vehicleStatus,
                            vStats.frags,
                        ])
            elif function not in ['showExInfo']:
                #debug('extendVehicleMarkerArgs: %i %s %s' % (handle, function, str(args)))
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
                #debug("key=" + str(key) + ' ' + ('down' if isDown else 'up'))
                #g_websock.send("%s/%i" % ('down' if isDown else 'up', key))
                if config.config is not None:
                    if self.battleFlashObject is not None:
                        if self.checkKeyEventBattle(key, isDown):
                            movie = self.battleFlashObject.movie
                            if movie is not None:
                                movie.invoke((RESPOND_KEY_EVENT, key, isDown))
        except Exception, ex:
            err('onKeyEvent(): ' + traceback.format_exc())
        return True

    def checkKeyEventBattle(self, key, isDown):
        # do not handle keys when chat is active
        from messenger import MessengerEntry
        if MessengerEntry.g_instance.gui.isFocused():
            return False

        c = config.config['hotkeys']

        if (c['minimapZoom']['enabled'] == True and c['minimapZoom']['keyCode'] == key):
            return True
        if (c['minimapAltMode']['enabled'] == True and c['minimapAltMode']['keyCode'] == key):
            return True
        if (c['playersPanelAltMode']['enabled'] == True and c['playersPanelAltMode']['keyCode'] == key):
            return True

        return False

    def initApplication(self):
        pass

    def deleteApplication(self):
        self.hangarDispose()
        if self.app is not None and self.app.loaderManager is not None:
           self.app.loaderManager.onViewLoaded -= self.onViewLoaded

    def initBattle(self):
        debug('> initBattle()')
        try:
            # Save/restore arena data
            player = BigWorld.player()

            fileName = 'arenas_data/{0}.dat'.format(player.arenaUniqueID)

            cfg = config.config['minimap']['circles']
            vehId = player.vehicleTypeDescriptor.type.compactDescr
            if vehId and vehId == cfg.get('_internal', {}).get('vehId', None):
                # Normal battle start. Update data and save to userprefs cache
                userprefs.set(fileName, {
                  'ver': '1.0',
                  'minimap_circles': cfg['_internal'],
                })
            else:
                # Replay, training or restarted battle after crash. Try to restore data.
                arena_data = userprefs.get(fileName)
                if arena_data is None:
                    # Set default vehicle data if it is not available.in the cache.
                    g_minimap_circles.updateConfig(player.vehicleTypeDescriptor)
                else:
                    # Apply restored data.
                    cfg['_internal'] = arena_data['minimap_circles']

        except Exception, ex:
            err(traceback.format_exc())

        self.config_str = simplejson.dumps(config.config)
        self.sendConfig(self.battleFlashObject)
        BigWorld.callback(0, self.invalidateBattleStates)

    def initVmm(self):
        self.sendConfig(self.vmmFlashObject)

    def on_websock_message(self, message):
        try:
            pass
            #type = SystemMessages.SM_TYPE.Information
            #msg += message
            #msg += '</textformat>'
            #SystemMessages.pushMessage(msg, type)
        except:
            debug(traceback.format_exc())

    def on_websock_error(self, error):
        try:
            type = SystemMessages.SM_TYPE.Error
            msg = token.getXvmMessageHeader()
            msg += 'WebSocket error: %s' % str(error)
            msg += '</textformat>'
            SystemMessages.pushMessage(msg, type)
        except:
            pass

    def onShowLogin(self, e=None):
        if self.currentPlayerId is not None:
            self.currentPlayerId = None
            g_websock.send('id')
            token.clearToken()

    def onShowLobby(self, e=None):
        playerId = getCurrentPlayerId()
        if playerId is not None and self.currentPlayerId != playerId:
            self.currentPlayerId = playerId
            token.checkVersion()
            token.initializeXvmToken()
            g_websock.send('id/%d' % playerId)
        if self.app is not None:
           self.app.loaderManager.onViewLoaded += self.onViewLoaded

    def onViewLoaded(self, e=None):
        if e is None:
            return
        if e.uniqueName == 'hangar':
            self.hangarInit()

    # HANGAR

    def hangarInit(self):
        from CurrentVehicle import g_currentVehicle
        g_currentVehicle.onChanged += self.updateTankParams
        BigWorld.callback(0, self.updateTankParams)

        from xpm import g_xvmView
        g_xvmView.as_xvm_cmdS(XVM_AS_COMMAND_SET_SVC_SETTINGS, token.networkServicesSettings)

    def hangarDispose(self):
        from CurrentVehicle import g_currentVehicle
        g_currentVehicle.onChanged -= self.updateTankParams

    def updateTankParams(self):
        try:
            g_minimap_circles.updateCurrentVehicle()
            if self.app is not None:
                data = simplejson.dumps(config.config['minimap']['circles']['_internal'])
                self.app.movie.invoke((RESPOND_UPDATECURRENTVEHICLE, [data]))
        except Exception, ex:
            err(traceback.format_exc())

    # PREBATTLE

    def onArenaCreated(self):
        g_minimap_circles.updateCurrentVehicle()


    # BATTLE

    def onAvatarBecomePlayer(self):
        pass


    def onEnterWorld(self):
        #debug('onEnterWorld: ' + str(BigWorld.player().arena))

        try:
            arena = BigWorld.player().arena
            if arena:
                arena.onVehicleKilled += self._onVehicleKilled
                arena.onAvatarReady += self._onAvatarReady
                arena.onVehicleStatisticsUpdate += self.updateVehicleStats
        except Exception, ex:
            err(traceback.format_exc())

    def onLeaveWorld(self):
        #debug('onLeaveWorld')

        try:
            arena = BigWorld.player().arena
            if arena:
                arena.onVehicleKilled -= self._onVehicleKilled
                arena.onAvatarReady -= self._onAvatarReady
                arena.onVehicleStatisticsUpdate -= self.updateVehicleStats
        except Exception, ex:
            err(traceback.format_exc())

        self.cleanupBattleData()


    def _onVehicleKilled(self, victimID, killerID, reason):
        self.invalidateBattleState(victimID)

    def _onAvatarReady(self, vID):
        self.invalidateBattleState(vID)


    def invalidateBattleStates(self):
        #debug('invalidateBattleStates')
        self._battleStateLast.clear()
        self._vehicleStatusLast.clear()
        self._vehicleStatsLast.clear()

        for (vID, vData) in BigWorld.player().arena.vehicles.iteritems():
            self.invalidateBattleState(vID)

    def invalidateBattleState(self, vID):
        #debug('invalidateBattleState: {0}'.format(vID))

        if config.config is None:
            return

        cfgAllowHp = config.config['battle']['allowHpInPanelsAndMinimap']
        cfgMarksOnGun = config.config['battle']['allowMarksOnGunInPanelsAndMinimap']

        if cfgAllowHp:
            player = BigWorld.player()
            if player is None or not hasattr(player, 'arena') or player.arena is None:
                return

            state = vehstate.getVehicleStateData(vID)
            if state is None:
                return

            self._battleStateData[vID] = state

            if self._battleStateTimersId.get(vID, None) is None:
                self._battleStateTimersId[vID] = \
                    BigWorld.callback(0.3, lambda:self.updateBattleState(vID))
        else:
            if cfgMarksOnGun and self.battleFlashObject is not None:
                vehicle = BigWorld.entity(vID)
                if vehicle is not None:
                    movie = self.battleFlashObject.movie
                    if movie is not None:
                        movie.invoke((RESPOND_MARKSONGUN,
                            vehicle.publicInfo.name,
                            vehicle.publicInfo.marksOnGun))


    def invalidateSpottedStatus(self, vID, spotted):
        #debug('invalidateSpottedStatus: {0} {1}'.format(vID, spotted))

        player = BigWorld.player()
        if player is None or not hasattr(player, 'arena') or player.arena is None:
            return

        prev = vehstate.getSpottedStatus(vID)
        vehstate.updateSpottedStatus(vID, spotted)
        if prev == vehstate.getSpottedStatus(vID):
            return

        state = vehstate.getVehicleStateData(vID)
        if state is None:
            return
        self._battleStateData[vID] = state

        if self._battleStateTimersId.get(vID, None) is None:
            self._battleStateTimersId[vID] = \
                BigWorld.callback(0.3, lambda:self.updateBattleState(vID))

    def updateBattleState(self, vID):
        try:
            #debug('updateBattleState: {0}'.format(vID))
            if self.battleFlashObject is not None:
                last = self._battleStateLast.get(vID, None)
                state = self._battleStateData.get(vID, None)
                #debug(state)
                if state is not None and state != last:
                    self._battleStateLast[vID] = state
                    movie = self.battleFlashObject.movie
                    if movie is not None:
                        #debug('updateBattleState: {0} {1}'.format(vID, set(state.items())^set((last if last else {}).items())))
                        movie.invoke((RESPOND_BATTLESTATE,
                            state['playerName'],
                            state['playerId'],
                            state['vId'],
                            state['dead'],
                            state['curHealth'],
                            state['maxHealth'],
                            state['marksOnGun'],
                            state['spotted'],
                        ))

            if self.vmmFlashObject is not None:
                arenaVehicle = BigWorld.player().arena.vehicles.get(vID, None)
                vehicle = BigWorld.entity(vID)
                if arenaVehicle is not None and vehicle is not None and hasattr(vehicle, 'marker'):
                    from gui.battle_control import g_sessionProvider
                    last = self._vehicleStatusLast.get(vID, None)
                    status = g_sessionProvider.getArenaDP().getVehicleInfo(vID).vehicleStatus
                    if status != last:
                        self._vehicleStatusLast[vID] = status
                        #debug('updateBattleState: {0} {1}->{2}'.format(vID, last, status))
                        self.vmmFlashObject.invokeMarker(vehicle.marker, 'setStatus', [status])

        except Exception, ex:
            err(traceback.format_exc())

        self._battleStateTimersId[vID] = None


    def updateVehicleStats(self, vID):
        try:
            #debug('updateVehicleStats: {0}'.format(vID))
            if self.vmmFlashObject is not None:
                vehicle = BigWorld.entity(vID)
                if vehicle is not None and hasattr(vehicle, 'marker'):
                    stat = BigWorld.player().arena.statistics.get(vID, None)
                    if stat is not None:
                        frags = stat['frags']
                        last = self._vehicleStatsLast.get(vID, None)
                        if frags != last:
                            self._vehicleStatsLast[vID] = frags
                            #debug('updateVehicleStats: {0} {1}->{2}'.format(vID, last, frags))
                            self.vmmFlashObject.invokeMarker(vehicle.marker, 'setFrags', [stat['frags']])
        except Exception, ex:
            err(traceback.format_exc())


    # on battle only
    def sendConfig(self, flashObject):
        if config.config is None or flashObject is None:
            return
        #debug('sendConfig')
        try:
            movie = flashObject.movie
            if movie is not None:
                movie.invoke((RESPOND_CONFIG, [
                    self.config_str,
                    self.lang_str,
                    BigWorld.player().arena.extraData['battleLevel'] + 1,
                    getVehicleInfoDataStr(),
                    simplejson.dumps(token.networkServicesSettings),
                    comments.getXvmUserComments(not isReplay())]))
        except Exception, ex:
            err('sendConfig(): ' + traceback.format_exc())


    def cleanupBattleData(self):
        vehstate.cleanupBattleData()
        self._battleStateLast.clear()
        self._vehicleStatusLast.clear()
        self._vehicleStatsLast.clear()

g_xvm = Xvm()
