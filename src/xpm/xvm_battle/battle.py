""" XVM (c) www.modxvm.com 2013-2016 """

#####################################################################
# imports

import traceback
import weakref

import BigWorld
import game
import constants
from Avatar import PlayerAvatar
from Vehicle import Vehicle
from gui.app_loader import g_appLoader
from gui.app_loader.settings import APP_NAME_SPACE
from gui.shared import g_eventBus, events
from gui.shared.utils.functions import getBattleSubTypeBaseNumder
from gui.battle_control import g_sessionProvider
from gui.battle_control.battle_constants import FEEDBACK_EVENT_ID
from gui.battle_control.battle_arena_ctrl import BattleArenaController
from gui.Scaleform.genConsts.BATTLE_VIEW_ALIASES import BATTLE_VIEW_ALIASES
from gui.Scaleform.daapi.settings.views import VIEW_ALIAS

from xfw import *
from xvm_main.python.logger import *
import xvm_main.python.minimap_circles as minimap_circles
import xvm_main.python.utils as utils
import xvm_main.python.vehinfo_xtdb as vehinfo_xtdb
import xvm_main.python.xmqp_events as xmqp_events

from commands import *


#####################################################################
# constants

# Invalidation targets

class INV(object):
    NONE                = 0x00000000
    VEHICLE_STATUS      = 0x00000001 # ready, alive, not_available, stop_respawn
    #PLAYER_STATUS       = 0x00000002 # isActionDisabled, isSelected, isSquadMan, isSquadPersonal, isTeamKiller, isVoipDisabled
    SQUAD_INDEX         = 0x00000008
    CUR_HEALTH          = 0x00000010
    MAX_HEALTH          = 0x00000020
    MARKS_ON_GUN        = 0x00000040
    SPOTTED_STATUS      = 0x00000080
    FRAGS               = 0x00000100
    ALL_VINFO           = VEHICLE_STATUS | SQUAD_INDEX | FRAGS # | PLAYER_STATUS
    ALL_VSTATS          = FRAGS
    ALL_ENTITY          = CUR_HEALTH | MAX_HEALTH | MARKS_ON_GUN
    ALL                 = 0xFFFFFFFF

class SPOTTED_STATUS(object):
    NEVER_SEEN = 'neverSeen'
    SPOTTED = 'spotted'
    LOST = 'lost'
    DEAD = 'dead'


#####################################################################
# initialization/finalization

def start():
    g_eventBus.addListener(XFWCOMMAND.XFW_CMD, _g_battle.onXfwCommand)
    g_eventBus.addListener(events.AppLifeCycleEvent.INITIALIZED, _g_battle.onAppInitialized)
    g_eventBus.addListener(events.AppLifeCycleEvent.DESTROYED, _g_battle.onAppDestroyed)

BigWorld.callback(0, start)

@registerEvent(game, 'fini')
def fini():
    g_eventBus.removeListener(XFWCOMMAND.XFW_CMD, _g_battle.onXfwCommand)
    g_eventBus.removeListener(events.AppLifeCycleEvent.INITIALIZED, _g_battle.onAppInitialized)
    g_eventBus.removeListener(events.AppLifeCycleEvent.DESTROYED, _g_battle.onAppDestroyed)


#####################################################################
# handlers

# PRE-BATTLE

@overrideMethod(PlayerAvatar, 'onBecomePlayer')
def _PlayerAvatar_onBecomePlayer(base, self):
    base(self)
    try:
        player = BigWorld.player()
        if player is not None and hasattr(player, 'arena'):
            arena = BigWorld.player().arena
            if arena:
                arena.onVehicleKilled += _g_battle.onVehicleKilled
                arena.onAvatarReady += _g_battle.onAvatarReady
                arena.onVehicleStatisticsUpdate += _g_battle.onVehicleStatisticsUpdate
            ctrl = g_sessionProvider.shared.feedback
            if ctrl:
                ctrl.onMinimapVehicleAdded += _g_battle.onMinimapVehicleAdded
                ctrl.onMinimapVehicleRemoved += _g_battle.onMinimapVehicleRemoved
                ctrl.onVehicleFeedbackReceived += _g_battle.onVehicleFeedbackReceived
        _g_battle.onStartBattle()
    except Exception, ex:
        err(traceback.format_exc())

@overrideMethod(PlayerAvatar, 'onBecomeNonPlayer')
def _PlayerAvatar_onBecomeNonPlayer(base, self):
    try:
        player = BigWorld.player()
        if player is not None and hasattr(player, 'arena'):
            arena = BigWorld.player().arena
            if arena:
                arena.onVehicleKilled -= _g_battle.onVehicleKilled
                arena.onAvatarReady -= _g_battle.onAvatarReady
                arena.onVehicleStatisticsUpdate -= _g_battle.onVehicleStatisticsUpdate
            ctrl = g_sessionProvider.shared.feedback
            if ctrl:
                ctrl.onMinimapVehicleAdded -= _g_battle.onMinimapVehicleAdded
                ctrl.onMinimapVehicleRemoved -= _g_battle.onMinimapVehicleRemoved
                ctrl.onVehicleFeedbackReceived -= _g_battle.onVehicleFeedbackReceived
    except Exception, ex:
        err(traceback.format_exc())
    base(self)


# BATTLE

# on current player enters world
@registerEvent(PlayerAvatar, 'onEnterWorld')
def _PlayerAvatar_onEnterWorld(self, prereqs):
    pass

# on current player leaves world
@registerEvent(PlayerAvatar, 'onLeaveWorld')
def _PlayerAvatar_onLeaveWorld(self):
    pass

# on any player marker appear
@registerEvent(PlayerAvatar, 'vehicle_onEnterWorld')
def _PlayerAvatar_vehicle_onEnterWorld(self, vehicle):
    # debug("> _PlayerAvatar_vehicle_onEnterWorld: hp=%i" % vehicle.health)
    _g_battle.updatePlayerState(vehicle.id, INV.ALL)

# on any player marker lost
@registerEvent(PlayerAvatar, 'vehicle_onLeaveWorld')
def _PlayerAvatar_vehicle_onLeaveWorld(self, vehicle):
    # debug("> _PlayerAvatar_vehicle_onLeaveWorld: hp=%i" % vehicle.health)
    pass

@registerEvent(PlayerAvatar, 'updateVehicleHealth')
def _PlayerAvatar_setVehicleNewHealth(self, vehicleID, health, *args, **kwargs):
    _g_battle.updatePlayerState(self.id, INV.CUR_HEALTH)

# on any vehicle hit received
@registerEvent(Vehicle, 'onHealthChanged')
def _Vehicle_onHealthChanged(self, newHealth, attackerID, attackReasonID):
    # debug("> _Vehicle_onHealthChanged: %i, %i, %i" % (newHealth, attackerID, attackReasonID))
    _g_battle.updatePlayerState(self.id, INV.CUR_HEALTH)
    if attackerID == BigWorld.player().playerVehicleID:
        as_xfw_cmd(XVM_BATTLE_COMMAND.AS_UPDATE_HITLOG_DATA, self.id, attackReasonID, newHealth)

# on vehicle info updated
@registerEvent(BattleArenaController, 'updateVehiclesInfo')
def _BattleArenaController_updateVehiclesInfo(self, updated, arenaDP):
    # debug("> _BattleArenaController_updateVehiclesInfo")
    try:
        # is dynamic squad created
        if BigWorld.player().arena.guiType == constants.ARENA_GUI_TYPE.RANDOM:
            for flags, vo in updated:
                if flags & INVALIDATE_OP.PREBATTLE_CHANGED and vo.squadIndex > 0:
                    for index, (vInfoVO, vStatsVO, viStatsVO) in enumerate(arenaDP.getTeamIterator(vo.team)):
                        if vInfoVO.squadIndex > 0:
                            _g_battle.updatePlayerState(vehicleID, INV.SQUAD_INDEX) # | INV.PLAYER_STATUS
    except Exception, ex:
        err(traceback.format_exc())


#####################################################################
# Battle

class Battle(object):

    battle_page = None

    def onAppInitialized(self, event):
        app = g_appLoader.getApp(event.ns)
        if app is not None and app.loaderManager is not None:
            app.loaderManager.onViewLoaded += self.onViewLoaded

    def onAppDestroyed(self, event):
        if event.ns == APP_NAME_SPACE.SF_BATTLE:
            self.battle_page = None
        app = g_appLoader.getApp(event.ns)
        if app is not None and app.loaderManager is not None:
            app.loaderManager.onViewLoaded -= self.onViewLoaded

    def onViewLoaded(self, view=None):
        if not view:
            return
        if view.uniqueName == VIEW_ALIAS.CLASSIC_BATTLE_PAGE:
            self.battle_page = weakref.proxy(view)

    def onStartBattle(self):
        self._spotted_cache = {}

    def getSpottedStatus(self, vehicleID):
        return self._spotted_cache.get(vehicleID, SPOTTED_STATUS.NEVER_SEEN)

    def onVehicleKilled(self, victimID, *args):
        self._spotted_cache[victimID] = SPOTTED_STATUS.DEAD
        self.updatePlayerState(victimID, INV.VEHICLE_STATUS | INV.CUR_HEALTH | INV.SPOTTED_STATUS)

    def onAvatarReady(self, vehicleID):
        self.updatePlayerState(vehicleID, INV.VEHICLE_STATUS)

    def onVehicleStatisticsUpdate(self, vehicleID):
        self.updatePlayerState(vehicleID, INV.FRAGS)

    def onMinimapVehicleAdded(self, vProxy, vInfo, guiProps):
        self._spotted_cache[vInfo.vehicleID] = SPOTTED_STATUS.SPOTTED
        self.updatePlayerState(vInfo.vehicleID, INV.SPOTTED_STATUS)

    def onMinimapVehicleRemoved(self, vehicleID):
        self._spotted_cache[vehicleID] = SPOTTED_STATUS.LOST
        self.updatePlayerState(vehicleID, INV.SPOTTED_STATUS)

    def onVehicleFeedbackReceived(self, eventID, vehicleID, value):
        if eventID == FEEDBACK_EVENT_ID.VEHICLE_HEALTH:
          self.updatePlayerState(vehicleID, INV.CUR_HEALTH)

    def updatePlayerState(self, vehicleID, targets):
        try:
            if targets & (INV.ALL_VINFO | INV.ALL_VSTATS):
                arenaDP = g_sessionProvider.getArenaDP()
                if targets & INV.ALL_VINFO:
                    vInfoVO = arenaDP.getVehicleInfo(vehicleID)
                if targets & INV.ALL_VSTATS:
                    vStatsVO = arenaDP.getVehicleStats(vehicleID)

            if targets & INV.ALL_ENTITY:
                entity = BigWorld.entity(vehicleID)

            data = {}
            if targets & INV.VEHICLE_STATUS:
                data['vehicleStatus'] = vInfoVO.vehicleStatus
            # why vInfoVO.playerStatus == 0?
            #if targets & INV.PLAYER_STATUS:
            #    data['playerStatus'] = vInfoVO.playerStatus
            if targets & INV.SQUAD_INDEX:
                data['squadIndex'] = vInfoVO.squadIndex
            if targets & INV.CUR_HEALTH:
                if entity and hasattr(entity, 'health'):
                    data['curHealth'] = entity.health
            if targets & INV.MAX_HEALTH:
                if entity and hasattr(entity, 'typeDescriptor'):
                    data['maxHealth'] = entity.typeDescriptor.maxHealth
            if targets & INV.MARKS_ON_GUN:
                if entity and hasattr(entity, 'publicInfo'):
                    data['marksOnGun'] = entity.publicInfo.marksOnGun
            if targets & INV.SPOTTED_STATUS:
                data['spottedStatus'] = self.getSpottedStatus(vehicleID)
            if targets & INV.FRAGS:
                data['frags'] = vStatsVO.frags
            as_xfw_cmd(XVM_BATTLE_COMMAND.AS_UPDATE_PLAYER_STATE, vehicleID, data)
        except Exception, ex:
            err(traceback.format_exc())


    #####################################################################
    # onXfwCommand

    # returns: (result, status)
    def onXfwCommand(self, cmd, *args):
        try:
            if cmd == XVM_BATTLE_COMMAND.REQUEST_BATTLE_GLOBAL_DATA:
                player = BigWorld.player()
                vehicleID = player.playerVehicleID
                arena = player.arena
                arenaVehicle = arena.vehicles.get(vehicleID)
                vehCD = getVehCD(vehicleID)
                as_xfw_cmd(XVM_BATTLE_COMMAND.AS_RESPONSE_BATTLE_GLOBAL_DATA,
                    vehicleID,                                  # playerVehicleID
                    arenaVehicle['name'],                       # playerName
                    vehCD,                                      # playerVehCD
                    arena.extraData.get('battleLevel', 0),      # battleLevel
                    arena.bonusType,                            # battleType
                    arena.guiType,                              # arenaGuiType
                    utils.getMapSize(),                         # mapSize
                    minimap_circles.getMinimapCirclesData(),    # minimapCirclesData
                    vehinfo_xtdb.vehArrayXTDB(vehCD))           # xtdb_data
                return (None, True)

            elif cmd == XVM_BATTLE_COMMAND.BATTLE_CTRL_SET_VEHICLE_DATA:
                if self.battle_page:
                    ctrl = self.battle_page.getComponent(BATTLE_VIEW_ALIASES.BATTLE_STATISTIC_DATA_CONTROLLER)
                    if ctrl:
                        ctrl.invalidateArenaInfo()
                    # update vehicles data
                    for (vehicleID, vData) in BigWorld.player().arena.vehicles.iteritems():
                        self.updatePlayerState(vehicleID, INV.ALL)

                return (None, True)

            elif cmd == XVM_BATTLE_COMMAND.CAPTURE_BAR_GET_BASE_NUM_TEXT:
                n = int(args[0])
                res = getBattleSubTypeBaseNumder(BigWorld.player().arenaTypeID, n & 0x3F, n >> 6)
                return (res, True)

            elif cmd == XVM_BATTLE_COMMAND.MINIMAP_CLICK:
                return (xmqp_events.send_minimap_click(args[0]), True)

        except Exception, ex:
            err(traceback.format_exc())
            return (None, True)

        return (None, False)

_g_battle = Battle()

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
