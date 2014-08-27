""" XVM (c) www.modxvm.com 2013-2014 """

import os
import glob
import traceback

import simplejson

import BigWorld
import GUI
from gui.shared.utils import decorators
from gui import SystemMessages

from xpm import *

from constants import *
from logger import *
from gameregion import *
from pinger import *
#from pinger_wg import *
from stats import getBattleStat, getBattleResultsStat, getUserData
from dossier import getDossier
from vehinfo import getVehicleInfoDataStr
from vehstate import getVehicleStateData
from wn8 import getWN8ExpectedData
from token import getXvmStatTokenData
from test import runTest
import utils
from websock import g_websock
from minimap_circles import g_minimap_circles
#from config.default import g_default_config

_LOG_COMMANDS = (
  COMMAND_LOADBATTLESTAT,
  COMMAND_LOADBATTLERESULTSSTAT,
  COMMAND_LOGSTAT,
  COMMAND_LOAD_SETTINGS,
  COMMAND_SAVE_SETTINGS,
  COMMAND_TEST,
  )

class Xvm(object):
    def __init__(self):
        self.currentPlayerId = None
        self.config_str = None
        self.config = None
        self.lang_str = None
        self.lang_data = None
        self.app = None
        self.battleFlashObject = None
        self.vmmFlashObject = None
        self._battleStateTimersId = dict()
        self._battleStateData = dict()

    def onXvmCommand(self, proxy, id, cmd, *args):
        try:
            #debug("id=" + str(id) + " cmd=" + str(cmd) + " args=" + simplejson.dumps(args))
            if (cmd in _LOG_COMMANDS):
                debug("cmd=" + str(cmd) + " args=" + simplejson.dumps(args))
            res = None
            if cmd == COMMAND_LOG:
                log(*args)
            elif cmd == COMMAND_LOAD_FILE:
                fn = os.path.join(XVM_DIR, args[0])
                res = load_file(fn) if os.path.exists(fn) else None
            elif cmd == COMMAND_SET_CONFIG:
                #debug('setConfig')
                self.config_str = args[0]
                self.config = simplejson.loads(self.config_str)
                if len(args) >= 2:
                    self.lang_str = args[1]
                    self.lang_data = simplejson.loads(self.lang_str)
                self.sendConfig(self.battleFlashObject)
                self.sendConfig(self.vmmFlashObject)
            elif cmd == COMMAND_PING:
                #return
                ping(proxy)
            elif cmd == COMMAND_GETMODS:
                #return
                res = self.getMods()
            elif cmd == COMMAND_GETSCREENSIZE:
                #return
                res = simplejson.dumps(list(GUI.screenResolution()))
            elif cmd == COMMAND_GETGAMEREGION:
                #return
                res = region
            elif cmd == COMMAND_GETLANGUAGE:
                #return
                res = language
            elif cmd == COMMAND_GETVEHICLEINFODATA:
                #return
                res = getVehicleInfoDataStr()
            elif cmd == COMMAND_GETWN8EXPECTEDDATA:
                res = getWN8ExpectedData()
            elif cmd == COMMAND_GETXVMSTATTOKENDATA:
                res = simplejson.dumps(getXvmStatTokenData())
            elif cmd == COMMAND_LOADBATTLESTAT:
                getBattleStat(proxy, args)
            elif cmd == COMMAND_LOADBATTLERESULTSSTAT:
                getBattleResultsStat(proxy, args)
            elif cmd == COMMAND_LOADUSERDATA:
                getUserData(proxy, args)
            elif cmd == COMMAND_GETDOSSIER:
                getDossier(proxy, args)
            elif cmd == COMMAND_OPEN_URL:
                if len(args[0]):
                    utils.openWebBrowser(args[0], False)
            elif cmd == COMMAND_RETURN_CREW:
                self.__processReturnCrew()
            elif cmd == COMMAND_LOAD_SETTINGS:
                pass # TODO
            elif cmd == COMMAND_SAVE_SETTINGS:
                pass # TODO
            elif cmd == COMMAND_TEST:
                runTest(args)
            else:
                err("unknown command: " + str(cmd))
            proxy.movie.invoke(('xvm.respond', [id, res]))
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
                    args.extend([
                        v.publicInfo.marksOnGun,
                        utils.getVehicleInfo(v.id).vehicleStatus,
                        utils.getVehicleStats(v.id).frags,
                    ])
            elif function not in ['showExInfo']:
                #debug('extendVehicleMarkerArgs: %i %s %s' % (handle, function, str(args)))
                pass
            return args
        except Exception, ex:
            err('extendVehicleMarkerArgs(): ' + traceback.format_exc())

    def onKeyEvent(self, event):
        try:
            key = event.key
            isDown = event.isKeyDown()
            isRepeated = event.isRepeatedEvent()
            if not isRepeated:
                #debug("key=" + str(key) + ' ' + ('down' if isDown else 'up'))
                if self.config is not None:
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

        c = self.config['hotkeys']

        if (c['minimapZoom']['enabled'] == True and c['minimapZoom']['keyCode'] == key):
            return True
        if (c['minimapAltMode']['enabled'] == True and c['minimapAltMode']['keyCode'] == key):
            return True
        if (c['playersPanelAltMode']['enabled'] == True and c['playersPanelAltMode']['keyCode'] == key):
            return True

        return False

    def getMods(self):
        mods_dir = XVM_MODS_DIR
        if not os.path.isdir(mods_dir):
            return None
        mods = []
        for m in glob.iglob(mods_dir + "/*.swf"):
            m = m.replace('\\', '/')
            if not m.lower().endswith("/xvm.swf"):
                mods.append(m)
        return simplejson.dumps(mods) if mods else None

    def initApplication(self):
        pass

    def deleteApplication(self):
        self.hangarDispose()
        if self.app is not None and self.app.loaderManager is not None:
           self.app.loaderManager.onViewLoaded -= self.onViewLoaded

    def initBattle(self):
        g_minimap_circles.updateConfig(BigWorld.player().vehicleTypeDescriptor, self.config)
        self.config_str = simplejson.dumps(self.config)
        self.sendConfig(self.battleFlashObject)
        BigWorld.callback(0, self.invalidateBattleStates)

    def initVmm(self):
        self.sendConfig(self.vmmFlashObject)

    def onShowLogin(self, e=None):
        if self.currentPlayerId is not None:
            self.currentPlayerId = None
            g_websock.send('id')

    def onShowLobby(self, e=None):
        playerId = getCurrentPlayerId()
        if playerId is not None and self.currentPlayerId != playerId:
            self.currentPlayerId = playerId
            g_websock.send('id/%d' % playerId)
        if self.app is not None:
           self.app.loaderManager.onViewLoaded += self.onViewLoaded

    def onViewLoaded(self, e=None):
        if e.uniqueName == 'hangar':
            self.hangarInit()

    def hangarInit(self):
        from CurrentVehicle import g_currentVehicle
        g_currentVehicle.onChanged += self.updateTankParams
        BigWorld.callback(0, self.updateTankParams)

    def hangarDispose(self):
        from CurrentVehicle import g_currentVehicle
        g_currentVehicle.onChanged -= self.updateTankParams

    def updateTankParams(self):
        try:
            self.updateCurrentVehicle()
            if self.app is not None:
                data = simplejson.dumps(self.config['minimap']['circles']['_internal'])
                self.app.movie.invoke((RESPOND_UPDATECURRENTVEHICLE, [data]))
        except Exception, ex:
            err('updateTankParams(): ' + traceback.format_exc())

    def updateCurrentVehicle(self):
        g_minimap_circles.updateCurrentVehicle(self.config)

    def invalidateBattleStates(self):
        import Vehicle
        for v in BigWorld.entities.values():
            if isinstance(v, Vehicle.Vehicle) and v.isStarted:
                self.invalidateBattleState(v)

    def invalidateBattleState(self, vehicle):
        #log("invalidateBattleState: " + str(vehicle.id))
        if self.config is None:
            return

        if self.config['battle']['allowGunMarksInPanelsAndMinimap'] and \
            not self.config['battle']['allowHpInPanelsAndMinimap']:
                if self.battleFlashObject is not None:
                    movie = self.battleFlashObject.movie
                    if movie is not None:
                        movie.invoke((RESPOND_MARKSONGUN,
                            vehicle.publicInfo.name,
                            vehicle.publicInfo.marksOnGun))

        if self.config['battle']['allowHpInPanelsAndMinimap']:
            player = BigWorld.player()
            if player is None or not hasattr(player, 'arena') or player.arena is None:
                return

            vehId = vehicle.id
            playerId = player.arena.vehicles[vehId]['accountDBID']
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
        if self.config is None or flashObject is None:
            return
        #debug('sendConfig')
        try:
            movie = flashObject.movie
            if movie is not None:
                movie.invoke((RESPOND_CONFIG, [
                    self.config_str,
                    self.lang_str,
                    getVehicleInfoDataStr()]))
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
