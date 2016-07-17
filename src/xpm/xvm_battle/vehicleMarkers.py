""" XVM (c) www.modxvm.com 2013-2016 """

#####################################################################
# imports

import traceback
import weakref

import BigWorld
import constants
import game
from gui.shared import g_eventBus, events
from gui.app_loader.settings import GUI_GLOBAL_SPACE_ID
from gui.battle_control import g_sessionProvider
from gui.Scaleform.daapi.view.battle.shared.markers2d.manager import MarkersManager

from xfw import *
from xvm_main.python.consts import *
from xvm_main.python.logger import *
import xvm_main.python.config as config
import xvm_main.python.python_macro as python_macro
import xvm_main.python.stats as stats
import xvm_main.python.utils as utils
import xvm_main.python.vehinfo as vehinfo

from commands import *
from battle import g_battle

#####################################################################
# initialization/finalization

def onConfigLoaded(self, e=None):
    g_markers.enabled = config.get('markers/enabled', True)
    g_markers.respondConfig()

g_eventBus.addListener(XVM_EVENT.CONFIG_LOADED, onConfigLoaded)

@registerEvent(game, 'fini')
def fini():
    g_eventBus.removeListener(XVM_EVENT.CONFIG_LOADED, onConfigLoaded)


#####################################################################
# handlers

# VMM

@overrideMethod(MarkersManager, '__init__')
def _MarkersManager__init__(base, self, parentUI):
    base(self, parentUI)
    g_markers.init(self)

@overrideMethod(MarkersManager, 'beforeDelete')
def _MarkersManager_beforeDelete(base, self):
    g_markers.destroy()

@overrideMethod(MarkersManager, 'createMarker')
def _MarkersManager_createMarker(base, self, mProv, symbol, active = True):
    if g_markers.active:
        symbol = 'com.xvm.vehiclemarkers.ui::XvmVehicleMarker'
    #debug('createMarker: ' + str(symbol))
    handle = base(self, mProv, symbol, active)
    return handle

_exInfo = False
@overrideMethod(MarkersManager, 'as_setShowExInfoFlagS')
def _MarkersManager_as_setShowExInfoFlagS(base, self, flag):
    if config.get('hotkeys/markersAltMode/enabled'):
        global _exInfo
        if config.get('hotkeys/markersAltMode/onHold'):
            _exInfo = flag
        elif flag:
            _exInfo = not _exInfo
        base(self, _exInfo)
    else:
        base(self, _exInfo)

def as_xvm_cmdS(self, *args):
    if self._isDAAPIInited():
        return self.flashObject.as_xvm_cmd(*args)
MarkersManager.as_xvm_cmdS = as_xvm_cmdS

#####################################################################
# VehicleMarkers

class VehicleMarkers(object):

    enabled = True
    initialized = False
    guiType = 0
    managerRef = None

    @property
    def active(self):
        return self.enabled and self.initialized and (self.guiType != constants.ARENA_GUI_TYPE.TUTORIAL)

    @property
    def manager(self):
        return self.managerRef() if self.managerRef else None

    @property
    def plugins(self):
        return self.manager._MarkersManager__plugins if self.manager else None

    def init(self, manager):
        self.managerRef = weakref.ref(manager)
        manager.addExternalCallback('xvm.cmd', self.onVMCommand)

    def destroy(self):
        self.initialized = False
        self.managerRef = None

    #####################################################################
    # onVMCommand

    # returns: (result, status)
    def onVMCommand(self, cmd, *args):
        try:
            if cmd == XVM_VM_COMMAND.LOG:
                log(*args)
            elif cmd == XVM_VM_COMMAND.INITIALIZED:
                self.initialized = True
                self.guiType = BigWorld.player().arena.guiType
                log('[VM]    initialized')
            elif cmd == XVM_COMMAND.REQUEST_CONFIG:
                self.respondConfig()
            elif cmd == XVM_COMMAND.PYTHON_MACRO:
                return python_macro.process_python_macro(args[0])
            #elif cmd == XVM_COMMAND.GET_PLAYER_NAME:
            #    return (BigWorld.player().name, True)
            elif cmd == XVM_COMMAND.GET_BATTLE_LEVEL:
                arena = getattr(BigWorld.player(), 'arena', None)
                return arena.extraData.get('battleLevel', 0) if arena else None
            elif cmd == XVM_COMMAND.GET_BATTLE_TYPE:
                arena = getattr(BigWorld.player(), 'arena', None)
                return arena.bonusType if arena else None
            elif cmd == XVM_COMMAND.GET_MAP_SIZE:
                return utils.getMapSize()
            elif cmd == XVM_COMMAND.GET_CLAN_ICON:
                return stats.getClanIcon(args[0])
            elif cmd == XVM_COMMAND.GET_MY_VEHCD:
                return getVehCD(BigWorld.player().playerVehicleID)
            elif cmd == XVM_COMMAND.LOAD_STAT_BATTLE:
                stats.getBattleStat(args, self.call, GUI_GLOBAL_SPACE_ID.BATTLE)
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
            if self.manager and self.initialized:
                self.manager.as_xvm_cmdS(*args)
        except Exception, ex:
            err(traceback.format_exc())

    def respondConfig(self):
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
                        {'markers':{'enabled':False}},
                        {'locale':{}},
                        None,
                        None,
                        IS_DEVELOPMENT)
                self.recreateMarkers()
        except Exception, ex:
            err(traceback.format_exc())

    def recreateMarkers(self):
        try:
            if self.plugins:
                plugin = self.plugins.getPlugin('vehicles')
                if plugin:
                    arenaDP = g_sessionProvider.getArenaDP()
                    for vInfo in arenaDP.getVehiclesInfoIterator():
                        plugin._destroyVehicleMarker(vInfo.vehicleID)
                        plugin.addVehicleInfo(vInfo, arenaDP)
        except Exception, ex:
            err(traceback.format_exc())

g_markers = VehicleMarkers()

## TODO:0.9.15.1
##@overrideMethod(MarkersManager, 'invokeMarker')
#def MarkersManager_invokeMarker(base, self, handle, function, args=None):
#    # debug("> invokeMarker: %i, %s, %s" % (handle, function, str(args)))
#    base(self, handle, function, g_xvm.extendVehicleMarkerArgs(handle, function, args))
#
#    def extendVehicleMarkerArgs(self, handle, function, args):
#        try:
#            if function == 'init':
#                if len(args) > 5:
#                    #debug('extendVehicleMarkerArgs: %i %s' % (handle, function))
#                    v = utils.getVehicleByName(args[5])
#                    if hasattr(v, 'publicInfo'):
#                        vInfo = utils.getVehicleInfo(v.id)
#                        vStats = utils.getVehicleStats(v.id)
#                        squadIndex = vInfo.squadIndex
#                        arenaDP = g_sessionProvider.getArenaDP()
#                        if arenaDP.isSquadMan(v.id):
#                            squadIndex += 10
#                        args.extend([
#                            vInfo.player.accountDBID,
#                            vInfo.vehicleType.compactDescr,
#                            v.publicInfo.marksOnGun,
#                            vInfo.vehicleStatus,
#                            vStats.frags,
#                            squadIndex,
#                        ])
#            elif function not in ['showExInfo']:
#                # debug('extendVehicleMarkerArgs: %i %s %s' % (handle, function, str(args)))
#                pass
#        except Exception, ex:
#            err('extendVehicleMarkerArgs(): ' + traceback.format_exc())
#        return args
#
#    def updateMarker(self, vehicleID, targets):
#        #trace('updateMarker: {0} {1}'.format(targets, vehicleID))
#
#        battle = getBattleApp()
#        if not battle:
#            return
#
#        markersManager = battle.markersManager
#        if vehicleID not in markersManager._MarkersManager__markers:
#            return
#        marker = markersManager._MarkersManager__markers[vehicleID]
#
#        player = BigWorld.player()
#        arena = player.arena
#        arenaVehicle = arena.vehicles.get(vehicleID, None)
#        if arenaVehicle is None:
#            return
#
#        stat = arena.statistics.get(vehicleID, None)
#        if stat is None:
#            return
#
#        isAlive = arenaVehicle['isAlive']
#        isAvatarReady = arenaVehicle['isAvatarReady']
#        status = VEHICLE_STATUS.NOT_AVAILABLE
#        if isAlive is not None and isAvatarReady is not None:
#            if isAlive:
#                status |= VEHICLE_STATUS.IS_ALIVE
#            if isAvatarReady:
#                status |= VEHICLE_STATUS.IS_READY
#
#        frags = stat['frags']
#
#        my_frags = 0
#        stat = arena.statistics.get(player.playerVehicleID, None)
#        if stat is not None:
#            my_frags = stat['frags']
#
#        vInfo = utils.getVehicleInfo(vehicleID)
#        squadIndex = vInfo.squadIndex
#        arenaDP = g_sessionProvider.getArenaDP()
#        if arenaDP.isSquadMan(vehicleID):
#            squadIndex += 10
#            markersManager.invokeMarker(marker.id, 'setEntityName', [PLAYER_GUI_PROPS.squadman.name()])
#
#        #debug('updateMarker: {0} st={1} fr={2} sq={3}'.format(vehicleID, status, frags, squadIndex))
#        markersManager.invokeMarker(marker.id, 'as_xvm_setMarkerState', [targets, status, frags, my_frags, squadIndex])
#
#    def updateMinimapEntry(self, vehicleID, targets):
#        #trace('updateMinimapEntry: {0} {1}'.format(targets, vehicleID))
#
#        battle = getBattleApp()
#        if not battle:
#            return
#
#        minimap = battle.minimap
#
#        if targets & INV.MINIMAP_SQUAD:
#            arenaDP = g_sessionProvider.getArenaDP()
#            if vehicleID != BigWorld.player().playerVehicleID and arenaDP.isSquadMan(vehicleID):
#                minimap._Minimap__callEntryFlash(vehicleID, 'setEntryName', [PLAYER_GUI_PROPS.squadman.name()])
#                g_xvm.invalidate(vehicleID, INV.BATTLE_SQUAD)
#            else:
#                minimap._Minimap__callEntryFlash(vehicleID, 'update')
#    def updateMarker(self, vehicleID, targets):
#        #trace('updateMarker: {0} {1}'.format(targets, vehicleID))
#
#        battle = getBattleApp()
#        if not battle:
#            return
#
#        markersManager = battle.markersManager
#        if vehicleID not in markersManager._MarkersManager__markers:
#            return
#        marker = markersManager._MarkersManager__markers[vehicleID]
#
#        player = BigWorld.player()
#        arena = player.arena
#        arenaVehicle = arena.vehicles.get(vehicleID, None)
#        if arenaVehicle is None:
#            return
#
#        stat = arena.statistics.get(vehicleID, None)
#        if stat is None:
#            return
#
#        isAlive = arenaVehicle['isAlive']
#        isAvatarReady = arenaVehicle['isAvatarReady']
#        status = VEHICLE_STATUS.NOT_AVAILABLE
#        if isAlive is not None and isAvatarReady is not None:
#            if isAlive:
#                status |= VEHICLE_STATUS.IS_ALIVE
#            if isAvatarReady:
#                status |= VEHICLE_STATUS.IS_READY
#
#        frags = stat['frags']
#
#        my_frags = 0
#        stat = arena.statistics.get(player.playerVehicleID, None)
#        if stat is not None:
#            my_frags = stat['frags']
#
#        vInfo = utils.getVehicleInfo(vehicleID)
#        squadIndex = vInfo.squadIndex
#        arenaDP = g_sessionProvider.getArenaDP()
#        if arenaDP.isSquadMan(vehicleID):
#            squadIndex += 10
#            markersManager.invokeMarker(marker.id, 'setEntityName', [PLAYER_GUI_PROPS.squadman.name()])
#
#        #debug('updateMarker: {0} st={1} fr={2} sq={3}'.format(vehicleID, status, frags, squadIndex))
#        markersManager.invokeMarker(marker.id, 'as_xvm_setMarkerState', [targets, status, frags, my_frags, squadIndex])
#
