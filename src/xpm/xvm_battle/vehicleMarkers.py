""" XVM (c) www.modxvm.com 2013-2016 """

#####################################################################
# imports

import traceback

import BigWorld
import game
from gui.shared import g_eventBus
#from gui.battle_control import g_sessionProvider
from gui.Scaleform.daapi.view.battle.shared.markers2d.manager import MarkersManager

from xfw import *
from xvm_main.python.consts import *
from xvm_main.python.logger import *
import xvm_main.python.config as config

from commands import *


#####################################################################
# initialization/finalization

def onConfigLoaded(self, e=None):
    _g_markers.enabled = config.get('markers/enabled', True)

g_eventBus.addListener(XVM_EVENT.CONFIG_LOADED, onConfigLoaded)

@registerEvent(game, 'fini')
def fini():
    g_eventBus.removeListener(XVM_EVENT.CONFIG_LOADED, onConfigLoaded)


#####################################################################
# handlers

# VMM

@overrideMethod(MarkersManager, '__init__')
def __init__(base, self, parentUI):
    base(self, parentUI)
    self.addExternalCallback('xvm.cmd', _g_markers.onVMCommand)

@overrideMethod(MarkersManager, 'createMarker')
def _MarkersManager_createMarker(base, self, mProv, symbol, active = True):
    if _g_markers.active:
        symbol = 'xvm.vehiclemarkers_ui::XvmVehicleMarker'
    #symbol = 'xvm.vehiclemarkers_ui::XvmVehicleMarker'
    #debug('createMarker: ' + str(symbol))
    return base(self, mProv, symbol, active)

#####################################################################
# VehicleMarkers

class VehicleMarkers(object):

    enabled = True
    initialized = False

    @property
    def active(self):
        return self.enabled and self.initialized

    #####################################################################
    # onVMCommand

    # returns: (result, status)
    def onVMCommand(self, cmd, *args):
        try:
            if cmd == XVM_VM_COMMAND.LOG:
                log(*args)
            elif cmd == XVM_VM_COMMAND.INITIALIZED:
                self.initialized = True
                log('[VM] initialized')
            else:
                warn('Unknown command: {}'.format(cmd))
        except Exception, ex:
            err(traceback.format_exc())
        return None

_g_markers = VehicleMarkers()

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
