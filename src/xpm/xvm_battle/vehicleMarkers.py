""" XVM (c) https://modxvm.com 2013-2021 """

#####################################################################
# imports

import traceback
import time

import BigWorld
import constants
import game
from Avatar import PlayerAvatar
from Vehicle import Vehicle
from messenger import MessengerEntry
from helpers import dependency
from BattleReplay import g_replayCtrl
from skeletons.gui.battle_session import IBattleSessionProvider
from gui.battle_control import avatar_getter
from gui.shared import g_eventBus, events
from gui.Scaleform.daapi.view.battle.shared.markers2d.manager import MarkersManager
from gui.Scaleform.daapi.view.battle.shared.markers2d.vehicle_plugins import VehicleMarkerPlugin

from xfw import *
from xvm_main.python.consts import *
from xvm_main.python.logger import *
import xvm_main.python.config as config
import xvm_main.python.pymacro as pymacro
import xvm_main.python.stats as stats
import xvm_main.python.vehinfo as vehinfo

from consts import *
import shared


#####################################################################
# initialization/finalization

def onConfigLoaded(e=None):
    g_markers.enabled = config.get('markers/enabled', True)
    g_markers.respondConfig()

g_eventBus.addListener(XVM_EVENT.CONFIG_LOADED, onConfigLoaded)

@registerEvent(game, 'fini')
def fini():
    g_eventBus.removeListener(XVM_EVENT.CONFIG_LOADED, onConfigLoaded)

@registerEvent(game, 'handleKeyEvent')
def game_handleKeyEvent(event):
    g_markers.onKeyEvent(event)

@overrideMethod(PlayerAvatar, 'onBecomePlayer')
def _PlayerAvatar_onBecomePlayer(base, self):
    base(self)
    try:
        arena = avatar_getter.getArena()
        if arena:
            arena.onVehicleStatisticsUpdate += g_markers.onVehicleStatisticsUpdate
    except Exception, ex:
        err(traceback.format_exc())

@overrideMethod(PlayerAvatar, 'onBecomeNonPlayer')
def _PlayerAvatar_onBecomeNonPlayer(base, self):
    try:
        arena = avatar_getter.getArena()
        if arena:
            arena.onVehicleStatisticsUpdate -= g_markers.onVehicleStatisticsUpdate
    except Exception, ex:
        err(traceback.format_exc())
    base(self)

# on any player marker appear
@registerEvent(PlayerAvatar, 'vehicle_onAppearanceReady')
def _PlayerAvatar_vehicle_onAppearanceReady(self, vehicle):
    g_markers.updatePlayerState(vehicle.id, INV.ALL)

@registerEvent(Vehicle, 'set_isCrewActive')
def set_isCrewActive(self, _=None):
    g_markers.updatePlayerState(self.id, INV.CREW_ACTIVE)

#####################################################################
# handlers

# VMM

@overrideMethod(MarkersManager, '__init__')
def _MarkersManager__init__(base, self):
    #debug('markers: __init__ ' + str(self))
    base(self)
    g_markers.init(self)

#@overrideMethod(MarkersManager, 'startPlugins')
#def _MarkersManager_startPlugins(base, self):
#    debug('markers: startPlugins ' + str(self))
#    for id in list(self._MarkersManager__ids):
#        self.destroyMarker(id)
#    base(self)

@overrideMethod(MarkersManager, '_populate')
def _MarkersManager_populate(base, self):
    #debug('markers: populate')
    g_markers.populate()
    base(self)

@overrideMethod(MarkersManager, '_dispose')
def _MarkersManager_dispose(base, self):
    #debug('markers: dispose')
#    for id in list(self._MarkersManager__ids):
#        self.destroyMarker(id)
    g_markers.destroy()
    base(self)

@overrideMethod(MarkersManager, 'createMarker')
def _MarkersManager_createMarker(base, self, symbol, matrixProvider = None, active = True):
    if g_markers.active:
        if symbol == 'VehicleMarker':
            symbol = 'com.xvm.vehiclemarkers.ui::XvmVehicleMarker'
    #log(traceback.format_stack())
    markerID = base(self, symbol, matrixProvider, active)
    #debug('createMarker: ' + str(symbol) + ' markerID=' + str(markerID))
    return markerID

@overrideMethod(MarkersManager, 'destroyMarker')
def destroyMarker(base, self, markerID):
    #debug('destroyMarker:  markerID=' + str(markerID))
    base(self, markerID)

_exInfo = False
@overrideMethod(MarkersManager, 'as_setShowExInfoFlagS')
def _MarkersManager_as_setShowExInfoFlagS(base, self, flag):
    if g_markers.active:
        if config.get('hotkeys/markersAltMode/enabled'):
            global _exInfo
            if config.get('hotkeys/markersAltMode/onHold'):
                _exInfo = flag
            elif flag:
                _exInfo = not _exInfo
            base(self, _exInfo)
    else:
        base(self, flag)

# add attackerID if XVM markers are active
@overrideMethod(VehicleMarkerPlugin, '_VehicleMarkerPlugin__updateVehicleHealth')
def _VehicleMarkerPlugin__updateVehicleHealth(base, self, vehicleID, handle, newHealth, aInfo, attackReasonID):
    if g_markers.active:
        if not (g_replayCtrl.isPlaying and g_replayCtrl.isTimeWarpInProgress):
            attackerID = aInfo.vehicleID if aInfo else 0
            self._invokeMarker(handle,
                               'updateHealth',
                               newHealth,
                               self._VehicleMarkerPlugin__getVehicleDamageType(aInfo),
                               '{},{}'.format(constants.ATTACK_REASONS[attackReasonID], str(attackerID)))
            return
    base(self, vehicleID, handle, newHealth, aInfo, attackReasonID)

def as_xvm_cmdS(self, *args):
    if self._isDAAPIInited():
        return self.flashObject.as_xvm_cmd(*args)

MarkersManager.as_xvm_cmdS = as_xvm_cmdS


#####################################################################
# VehicleMarkers

class VehicleMarkers(object):

    enabled = True
    initialized = False
    populated = False
    guiType = None
    battleType = None
    playerVehicleID = 0
    manager = None
    sessionProvider = dependency.descriptor(IBattleSessionProvider)
    pending_commands = []

    @property
    def active(self):
        return self.enabled and \
               self.initialized and \
               (self.guiType != constants.ARENA_GUI_TYPE.TUTORIAL) and \
               (self.battleType != constants.ARENA_BONUS_TYPE.TUTORIAL) and \
               (self.guiType != constants.ARENA_GUI_TYPE.EVENT_BATTLES) and \
               (self.guiType != constants.ARENA_GUI_TYPE.RTS) and \
               (self.guiType != constants.ARENA_GUI_TYPE.RTS_TRAINING) and \
               (self.guiType != constants.ARENA_GUI_TYPE.RTS_BOOTCAMP) and \
               (self.battleType != constants.ARENA_BONUS_TYPE.EVENT_BATTLES)

    @property
    def plugins(self):
        return self.manager._MarkersManager__plugins if self.manager else None

    def init(self, manager):
        self.manager = manager
        self.manager.addExternalCallback('xvm.cmd', self.onVMCommand)
        self.playerVehicleID = self.sessionProvider.getArenaDP().getPlayerVehicleID()

    def populate(self):
        self.populated = True
        self.respondConfig()
        self.process_pending_commands()
        self.updatePlayerStates()

    def destroy(self):
        self.pending_commands = []
        self.initialized = False
        self.populated = False
        self.guiType = None
        self.battleType = None
        self.playerVehicleID = 0
        self.manager.removeExternalCallback('xvm.cmd')
        self.manager = None

    #####################################################################
    # event handlers

    # FIXIT: is required? It seems that updateVehiclesStat is called anyway
    def onVehicleStatisticsUpdate(self, vehicleID):
        self.updatePlayerState(vehicleID, INV.FRAGS)


    #####################################################################
    # onVMCommand

    # returns: (result, status)
    def onVMCommand(self, cmd, *args):
        try:
            if cmd == XVM_VM_COMMAND.LOG:
                log(*args)
            elif cmd == XVM_VM_COMMAND.INITIALIZED:
                self.initialized = True
                arena = avatar_getter.getArena()
                self.guiType = arena.guiType
                self.battleType = arena.bonusType
                log('[VM]    initialized')
            elif cmd == XVM_COMMAND.REQUEST_CONFIG:
                #self.respondConfig()
                pass # vehicle markers config loading controlled by python
            elif cmd == XVM_BATTLE_COMMAND.REQUEST_BATTLE_GLOBAL_DATA:
                self.respondGlobalBattleData()
            elif cmd == XVM_COMMAND.PYTHON_MACRO:
                self.call(XVM_VM_COMMAND.AS_CMD_RESPONSE, pymacro.process_python_macro(args[0]))
            elif cmd == XVM_COMMAND.GET_CLAN_ICON:
                self.call(XVM_VM_COMMAND.AS_CMD_RESPONSE, stats.getClanIcon(int(args[0])))
            elif cmd == XVM_COMMAND.LOAD_STAT_BATTLE:
                stats.getBattleStat(args, self.call)
            # profiler
            elif cmd in (XVM_PROFILER_COMMAND.BEGIN, XVM_PROFILER_COMMAND.END):
                g_eventBus.handleEvent(events.HasCtxEvent(cmd, args[0]))
            else:
                warn('Unknown command: {}'.format(cmd))
        except Exception, ex:
            err(traceback.format_exc())
        return None

    def call(self, *args):
        try:
            if self.manager and self.populated:
                #debug('as_xvm_cmdS: ' + str(args))
                self.manager.as_xvm_cmdS(*args)
            elif self.enabled:
                #debug('pending: ' + str(args))
                self.pending_commands.append(args)
        except Exception, ex:
            err(traceback.format_exc())

    def respondConfig(self):
        #debug('vm:respondConfig')
        #s = time.clock()
        try:
            if self.initialized:
                if self.active:
                    self.call(
                        XVM_COMMAND.AS_SET_CONFIG,
                        config.config_data,
                        config.lang_data,
                        vehinfo.getVehicleInfoDataArray(),
                        config.networkServicesSettings.__dict__,
                        IS_DEVELOPMENT)
                else:
                    self.call(
                        XVM_COMMAND.AS_SET_CONFIG,
                        {'markers': {'enabled': False}},
                        {'locale': {}},
                        None,
                        None,
                        IS_DEVELOPMENT)
                self.recreateMarkers()
        except Exception, ex:
            err(traceback.format_exc())
        #debug('vm:respondConfig: {:>8.3f} s'.format(time.clock() - s))

    def respondGlobalBattleData(self):
        #s = time.clock()
        try:
            if self.active:
                self.call(XVM_BATTLE_COMMAND.AS_RESPONSE_BATTLE_GLOBAL_DATA, *shared.getGlobalBattleData())
        except Exception, ex:
            err(traceback.format_exc())
        #debug('vm:respondGlobalBattleData: {:>8.3f} s'.format(time.clock() - s))

    def process_pending_commands(self):
        for args in self.pending_commands:
            #debug('pending_command: ' + str(args))
            self.call(*args)
        self.pending_commands = []

    def onKeyEvent(self, event):
        try:
            if not event.isRepeatedEvent():
                if self.active and not MessengerEntry.g_instance.gui.isFocused():
                    self.call(XVM_COMMAND.AS_ON_KEY_EVENT, event.key, event.isKeyDown())
        except Exception, ex:
            err(traceback.format_exc())

    def updatePlayerStates(self):
        for vehicleID, vData in avatar_getter.getArena().vehicles.iteritems():
            g_markers.updatePlayerState(vehicleID, INV.ALL)

    def updatePlayerState(self, vehicleID, targets, userData=None):
        try:
            if self.active:
                data = {}

                if targets & INV.ALL_ENTITY:
                    entity = BigWorld.entity(vehicleID)

                    if targets & INV.MARKS_ON_GUN:
                        if entity and hasattr(entity, 'publicInfo'):
                            data['marksOnGun'] = entity.publicInfo.marksOnGun

                    if targets & INV.TURRET:
                        if entity and hasattr(entity, 'typeDescriptor'):
                            data['turretCD'] = entity.typeDescriptor.turret.compactDescr

                    if targets & INV.CREW_ACTIVE:
                        if entity and hasattr(entity, 'isCrewActive'):
                            data['isCrewActive'] = bool(entity.isCrewActive)

                if targets & (INV.ALL_VINFO | INV.ALL_VSTATS):
                    arenaDP = self.sessionProvider.getArenaDP()
                    if targets & INV.ALL_VSTATS:
                        vStatsVO = arenaDP.getVehicleStats(vehicleID)

                        if targets & INV.FRAGS:
                            data['frags'] = vStatsVO.frags

                if data:
                    self.call(XVM_BATTLE_COMMAND.AS_UPDATE_PLAYER_STATE, vehicleID, data)
        except Exception, ex:
            err(traceback.format_exc())

    def recreateMarkers(self):
        #s = time.clock()
        try:
            if self.plugins:
                plugin = self.plugins.getPlugin('vehicles')
                if plugin:
                    arenaDP = self.sessionProvider.getArenaDP()
                    for vInfo in arenaDP.getVehiclesInfoIterator():
                        vehicleID = vInfo.vehicleID
                        if vehicleID == self.playerVehicleID or vInfo.isObserver():
                            continue
                        plugin._destroyVehicleMarker(vInfo.vehicleID)
                        plugin.addVehicleInfo(vInfo, arenaDP)
        except Exception, ex:
            err(traceback.format_exc())
        #debug('vm:recreateMarkers: {:>8.3f} s'.format(time.clock() - s))

g_markers = VehicleMarkers()
