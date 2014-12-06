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
from vehstate import getVehicleStateData
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
  XVM_COMMAND_UNLOAD_TANKMAN,
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

    # returns: (result, status)
    def onXpmCommand(self, cmd, *args):
        try:
            if (cmd in _LOG_COMMANDS):
                debug("cmd=" + str(cmd) + " args=" + simplejson.dumps(args))
            if cmd == XVM_COMMAND_GET_SVC_SETTINGS:
                token.getToken()
                return (token.networkServicesSettings, True)
            if cmd == XVM_COMMAND_UNLOAD_TANKMAN:
                wgcompat.g_instance.unloadTankman(args[0])
                return (None, True)
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
                self.__processReturnCrew()
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
        g_minimap_circles.updateConfig(BigWorld.player().vehicleTypeDescriptor)
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
            self.updateCurrentVehicle()
            if self.app is not None:
                data = simplejson.dumps(config.config['minimap']['circles']['_internal'])
                self.app.movie.invoke((RESPOND_UPDATECURRENTVEHICLE, [data]))
        except Exception, ex:
            err('updateTankParams(): ' + traceback.format_exc())

    def updateCurrentVehicle(self):
        g_minimap_circles.updateCurrentVehicle()

    def invalidateBattleStates(self):
        import Vehicle
        for v in BigWorld.entities.values():
            if isinstance(v, Vehicle.Vehicle) and v.isStarted:
                self.invalidateBattleState(v)

    def invalidateBattleState(self, vehicle):
        #log("invalidateBattleState: " + str(vehicle.id))
        if config.config is None:
            return

        if config.config['battle']['allowMarksOnGunInPanelsAndMinimap'] and \
            not config.config['battle']['allowHpInPanelsAndMinimap']:
                if self.battleFlashObject is not None:
                    movie = self.battleFlashObject.movie
                    if movie is not None:
                        movie.invoke((RESPOND_MARKSONGUN,
                            vehicle.publicInfo.name,
                            vehicle.publicInfo.marksOnGun))

        if config.config['battle']['allowHpInPanelsAndMinimap']:
            player = BigWorld.player()
            if player is None or not hasattr(player, 'arena') or player.arena is None:
                return

            vehId = vehicle.id
            arenaVehicle = player.arena.vehicles.get(vehId, None)
            if arenaVehicle is None:
                return
            playerId = arenaVehicle['accountDBID']
            self._battleStateData[vehId] = getVehicleStateData(vehicle, playerId)
            if self._battleStateTimersId.get(vehId, None) == None:
                self._battleStateTimersId[vehId] = \
                    BigWorld.callback(0.3, lambda: self.updateBattleState(vehId))

    def updateBattleState(self, vehId):
        try:
            #log("updateBattleState: " + str(vehId))
            self._battleStateTimersId[vehId] = None
            if self.battleFlashObject is not None:
                vdata = self._battleStateData.get(vehId, None)
                if vdata is not None:
                    movie = self.battleFlashObject.movie
                    if movie is not None:
                        movie.invoke((RESPOND_BATTLESTATE,
                            vdata['playerName'],
                            vdata['playerId'],
                            vdata['vehId'],
                            vdata['dead'],
                            vdata['curHealth'],
                            vdata['maxHealth'],
                            vdata['marksOnGun'],
                        ))
        except Exception, ex:
            err('updateBattleState(): ' + traceback.format_exc())

    def updateVehicleStatus(self, vo):
        try:
            if self.vmmFlashObject is not None:
                vehicle = BigWorld.entity(vo.vehicleID)
                if vehicle is not None and hasattr(vehicle, 'marker'):
                    self.vmmFlashObject.invokeMarker(vehicle.marker, 'setStatus', [vo.vehicleStatus])
        except Exception, ex:
            err('updateVehicleStatus(): ' + traceback.format_exc())

    def updateVehicleStats(self, vo):
        try:
            if self.vmmFlashObject is not None:
                vehicle = BigWorld.entity(vo.vehicleID)
                if vehicle is not None and hasattr(vehicle, 'marker'):
                    self.vmmFlashObject.invokeMarker(vehicle.marker, 'setFrags', [vo.frags])
        except Exception, ex:
            err('updateVehicleStats(): ' + traceback.format_exc())

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
                    getVehicleInfoDataStr(),
                    simplejson.dumps(token.networkServicesSettings),
                    comments.getXvmUserComments(not isReplay())]))
        except Exception, ex:
            err('sendConfig(): ' + traceback.format_exc())

    # taken from gui.Scaleform.daapi.view.lobby.crewOperations.CrewOperationsPopOver
    @decorators.process('crewReturning')
    def __processReturnCrew(self):
        from gui.shared.gui_items.processors.tankman import TankmanReturn
        from CurrentVehicle import g_currentVehicle
        result = yield TankmanReturn(g_currentVehicle.item).request()
        if len(result.userMsg):
            SystemMessages.g_instance.pushI18nMessage(result.userMsg, type = result.sysMsgType)

g_xvm = Xvm()


from . import XPM_MOD_VERSION, XPM_MOD_URL, XPM_GAME_VERSIONS
log("xvm %s (%s) for WoT %s" % (XPM_MOD_VERSION, XPM_MOD_URL, ", ".join(XPM_GAME_VERSIONS)))
try:
    from __version__ import __branch__, __revision__
    log("Branch: %s, Revision: %s" % (__branch__, __revision__))
except Exception, ex:
    err(traceback.format_exc())
