""" XVM (c) www.modxvm.com 2013-2017 """

#####################################################################
# imports

import traceback
import weakref

import BigWorld
import game
import constants
from Avatar import PlayerAvatar
from Vehicle import Vehicle
from helpers import dependency
from skeletons.gui.battle_session import IBattleSessionProvider
from gui.app_loader import g_appLoader
from gui.app_loader.settings import APP_NAME_SPACE, GUI_GLOBAL_SPACE_ID
from gui.shared import g_eventBus, events
from gui.shared.utils.functions import getBattleSubTypeBaseNumder
from gui.battle_control import avatar_getter
from gui.battle_control.arena_info.settings import INVALIDATE_OP
from gui.battle_control.battle_constants import FEEDBACK_EVENT_ID
from gui.battle_control.battle_constants import VEHICLE_VIEW_STATE
from gui.battle_control.controllers.dyn_squad_functional import DynSquadFunctional
from gui.Scaleform.genConsts.BATTLE_VIEW_ALIASES import BATTLE_VIEW_ALIASES
from gui.Scaleform.daapi.settings.views import VIEW_ALIAS
from gui.Scaleform.daapi.view.battle.shared import battle_loading
from gui.Scaleform.daapi.view.battle.shared.damage_panel import DamagePanel
from gui.Scaleform.daapi.view.battle.shared.markers2d import settings as markers2d_settings
from gui.Scaleform.daapi.view.battle.shared.minimap import settings as minimap_settings
from gui.Scaleform.daapi.view.battle.shared.minimap.plugins import ArenaVehiclesPlugin
from gui.Scaleform.daapi.view.battle.shared.page import SharedPage

from xfw import *
import xvm_main.python.config as config
from xvm_main.python.logger import *

from consts import *
import shared
import xmqp
import xmqp_events


#####################################################################
# initialization/finalization

def start():
    g_eventBus.addListener(XFWCOMMAND.XFW_CMD, g_battle.onXfwCommand)
    g_eventBus.addListener(XVM_BATTLE_EVENT.VM_INVALIDATE_ARENA_INFO, g_battle.onVMInvalidateArenaInfo)
    g_eventBus.addListener(events.AppLifeCycleEvent.INITIALIZED, g_battle.onAppInitialized)
    g_eventBus.addListener(events.AppLifeCycleEvent.DESTROYED, g_battle.onAppDestroyed)

BigWorld.callback(0, start)

g_eventBus.addListener(XVM_BATTLE_EVENT.XMQP_CONNECTED, xmqp_events.onXmqpConnected)
g_eventBus.addListener(XVM_BATTLE_EVENT.XMQP_MESSAGE, xmqp_events.onXmqpMessage)

@registerEvent(game, 'fini')
def fini():
    g_eventBus.removeListener(XFWCOMMAND.XFW_CMD, g_battle.onXfwCommand)
    g_eventBus.removeListener(XVM_BATTLE_EVENT.VM_INVALIDATE_ARENA_INFO, g_battle.onVMInvalidateArenaInfo)
    g_eventBus.removeListener(events.AppLifeCycleEvent.INITIALIZED, g_battle.onAppInitialized)
    g_eventBus.removeListener(events.AppLifeCycleEvent.DESTROYED, g_battle.onAppDestroyed)
    g_eventBus.removeListener(XVM_BATTLE_EVENT.XMQP_CONNECTED, xmqp_events.onXmqpConnected)
    g_eventBus.removeListener(XVM_BATTLE_EVENT.XMQP_MESSAGE, xmqp_events.onXmqpMessage)


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
                arena.onVehicleKilled += g_battle.onVehicleKilled
                arena.onAvatarReady += g_battle.onAvatarReady
                arena.onVehicleStatisticsUpdate += g_battle.onVehicleStatisticsUpdate
                arena.onNewVehicleListReceived += xmqp.start
        sessionProvider = dependency.instance(IBattleSessionProvider)
        ctrl = sessionProvider.shared.feedback
        if ctrl:
            ctrl.onVehicleFeedbackReceived += g_battle.onVehicleFeedbackReceived
        ctrl = sessionProvider.shared.vehicleState
        if ctrl:
            ctrl.onVehicleStateUpdated += g_battle.onVehicleStateUpdated
        ctrl = sessionProvider.shared.optionalDevices
        if ctrl:
            ctrl.onOptionalDeviceAdded += g_battle.onOptionalDeviceAdded
            ctrl.onOptionalDeviceUpdated += g_battle.onOptionalDeviceUpdated
        g_battle.onStartBattle()
    except Exception, ex:
        err(traceback.format_exc())

@overrideMethod(PlayerAvatar, 'onBecomeNonPlayer')
def _PlayerAvatar_onBecomeNonPlayer(base, self):
    try:
        player = BigWorld.player()
        if player is not None and hasattr(player, 'arena'):
            arena = BigWorld.player().arena
            if arena:
                arena.onVehicleKilled -= g_battle.onVehicleKilled
                arena.onAvatarReady -= g_battle.onAvatarReady
                arena.onVehicleStatisticsUpdate -= g_battle.onVehicleStatisticsUpdate
                arena.onNewVehicleListReceived -= xmqp.start
        sessionProvider = dependency.instance(IBattleSessionProvider)
        ctrl = sessionProvider.shared.feedback
        if ctrl:
            ctrl.onVehicleFeedbackReceived -= g_battle.onVehicleFeedbackReceived
        ctrl = sessionProvider.shared.vehicleState
        if ctrl:
            ctrl.onVehicleStateUpdated -= g_battle.onVehicleStateUpdated
        ctrl = sessionProvider.shared.optionalDevices
        if ctrl:
            ctrl.onOptionalDeviceAdded -= g_battle.onOptionalDeviceAdded
            ctrl.onOptionalDeviceUpdated -= g_battle.onOptionalDeviceUpdated
        xmqp.stop()
    except Exception, ex:
        err(traceback.format_exc())
    base(self)


# BATTLE

# on current player enters world
#@registerEvent(PlayerAvatar, 'onEnterWorld')
#def _PlayerAvatar_onEnterWorld(self, prereqs):
#    pass

# on current player leaves world
#@registerEvent(PlayerAvatar, 'onLeaveWorld')
#def _PlayerAvatar_onLeaveWorld(self):
#    pass

# on any player marker appear
@registerEvent(PlayerAvatar, 'vehicle_onEnterWorld')
def _PlayerAvatar_vehicle_onEnterWorld(self, vehicle):
    # debug("> _PlayerAvatar_vehicle_onEnterWorld: hp=%i" % vehicle.health)
    g_battle.updatePlayerState(vehicle.id, INV.ALL)

# on any player marker lost
#@registerEvent(PlayerAvatar, 'vehicle_onLeaveWorld')
#def _PlayerAvatar_vehicle_onLeaveWorld(self, vehicle):
#    # debug("> _PlayerAvatar_vehicle_onLeaveWorld: hp=%i" % vehicle.health)
#    pass

# any vehicle health changed
@registerEvent(Vehicle, 'onHealthChanged')
def onHealthChanged(self, newHealth, attackerID, attackReasonID):
    # update only for player vehicle, others handled on vehicle feedback event
    if self.isPlayerVehicle:
        g_battle.onVehicleHealthChanged(self.id, newHealth, attackerID, attackReasonID)

# on vehicle info updated
@registerEvent(DynSquadFunctional, 'updateVehiclesInfo')
def _DynSquadFunctional_updateVehiclesInfo(self, updated, arenaDP):
    # debug("> _DynSquadFunctional_updateVehiclesInfo")
    try:
        # is dynamic squad created
        if BigWorld.player().arena.guiType == constants.ARENA_GUI_TYPE.RANDOM:
            for flags, vo in updated:
                if flags & INVALIDATE_OP.PREBATTLE_CHANGED and vo.squadIndex > 0:
                    for vInfoVO in arenaDP.getVehiclesInfoIterator():
                        if vInfoVO.team == vo.team and vInfoVO.squadIndex == vo.squadIndex:
                            g_battle.updatePlayerState(vInfoVO.vehicleID, INV.SQUAD_INDEX) # | INV.PLAYER_STATUS
    except Exception, ex:
        err(traceback.format_exc())

@registerEvent(DamagePanel, '_updateDeviceState')
def _DamagePanel_updateDeviceState(self, value):
    try:
        as_xfw_cmd(XVM_BATTLE_COMMAND.AS_UPDATE_DEVICE_STATE, *value)
    except:
        err(traceback.format_exc())

@registerEvent(ArenaVehiclesPlugin, '_ArenaVehiclesPlugin__setInAoI')
def _ArenaVehiclesPlugin__setInAoI(self, entry, isInAoI):
    try:
        for vehicleID, entry2 in self._entries.iteritems():
            if entry == entry2:
                g_battle.updateSpottedStatus(vehicleID, isInAoI)
    except:
        err(traceback.format_exc())

@overrideMethod(SharedPage, 'as_setPostmortemTipsVisibleS')
def _SharedPage_as_setPostmortemTipsVisibleS(base, self, value):
    if not config.get('battle/showPostmortemTips'):
        value = False
    base(self, value)

@overrideMethod(SharedPage, '_switchToPostmortem')
def _switchToPostmortem(base, self):
    if config.get('battle/showPostmortemTips'):
        base(self)


#####################################################################
# Battle

class Battle(object):

    battle_page = None
    updateTargetCallbackID = None
    targetVehicleID = None
    xvm_battle_swf_initialized = False
    is_moving = False

    sessionProvider = dependency.descriptor(IBattleSessionProvider)

    def onAppInitialized(self, event):
        #log('onAppInitialized: ' + str(event.ns))
        if event.ns == APP_NAME_SPACE.SF_BATTLE:
            self.xvm_battle_swf_initialized = False
        app = g_appLoader.getApp(event.ns)
        if app is not None and app.loaderManager is not None:
            app.loaderManager.onViewLoaded += self.onViewLoaded

    def onAppDestroyed(self, event):
        #log('onAppDestroyed: ' + str(event.ns))
        if event.ns == APP_NAME_SPACE.SF_BATTLE:
            self.xvm_battle_swf_initialized = False
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

    def onVehicleFeedbackReceived(self, eventID, vehicleID, value):
        if eventID == FEEDBACK_EVENT_ID.VEHICLE_HEALTH:
            (newHealth, aInfo, attackReasonID) = value
            attackerID = aInfo.vehicleID if aInfo is not None else -1
            self.onVehicleHealthChanged(vehicleID, newHealth, attackerID, attackReasonID)
        elif eventID == FEEDBACK_EVENT_ID.VEHICLE_IN_FOCUS:
            self.targetVehicleID = vehicleID
            if self.updateTargetCallbackID:
                BigWorld.cancelCallback(self.updateTargetCallbackID)
            self.updateTargetCallbackID = BigWorld.callback(0, self.updateTarget)
        #else:
        #    debug('onVehicleFeedbackReceived: {} {} {} '.format(eventID, vehicleID, value))

    def onVehicleStateUpdated(self, state, value):
        if state == VEHICLE_VIEW_STATE.SPEED:
            is_moving = value != 0
            if is_moving != self.is_moving:
                self.is_moving = is_moving
                as_xfw_cmd(XVM_BATTLE_COMMAND.AS_MOVING_STATE_CHANGED, is_moving)

    def onOptionalDeviceAdded(self, intCD, descriptor, isOn):
        if intCD == INT_CD.STEREOSCOPE:
            as_xfw_cmd(XVM_BATTLE_COMMAND.AS_STEREOSCOPE_TOGGLED, isOn)

    def onOptionalDeviceUpdated(self, intCD, isOn):
        if intCD == INT_CD.STEREOSCOPE:
            as_xfw_cmd(XVM_BATTLE_COMMAND.AS_STEREOSCOPE_TOGGLED, isOn)

    def onVehicleHealthChanged(self, vehicleID, newHealth, attackerID, attackReasonID):
        inv = INV.CUR_HEALTH
        userData = None
        if attackerID == BigWorld.player().playerVehicleID:
            inv |= INV.HITLOG
            userData = {'damageFlag':self._getVehicleDamageType(attackerID),
                        'damageType':constants.ATTACK_REASONS[attackReasonID]}
        self.updatePlayerState(vehicleID, inv, userData)

    def updateSpottedStatus(self, vehicleID, active):
        spotted_status = SPOTTED_STATUS.SPOTTED if active else SPOTTED_STATUS.LOST
        if self.getSpottedStatus(vehicleID) != spotted_status:
            self._spotted_cache[vehicleID] = spotted_status
            self.updatePlayerState(vehicleID, INV.SPOTTED_STATUS)

    def updatePlayerState(self, vehicleID, targets, userData=None):
        try:
            data = {}

            if targets & INV.SPOTTED_STATUS:
                data['spottedStatus'] = self.getSpottedStatus(vehicleID)

            if targets & INV.HITLOG:
                data['__hitlogData'] = userData

            if targets & INV.ALL_ENTITY:
                entity = BigWorld.entity(vehicleID)

                if targets & INV.CUR_HEALTH:
                    if entity and hasattr(entity, 'health'):
                        data['curHealth'] = entity.health

                if targets & INV.MAX_HEALTH:
                    if entity and hasattr(entity, 'typeDescriptor'):
                        data['maxHealth'] = entity.typeDescriptor.maxHealth

                if targets & INV.MARKS_ON_GUN:
                    if entity and hasattr(entity, 'publicInfo'):
                        data['marksOnGun'] = entity.publicInfo.marksOnGun

            if targets & (INV.ALL_VINFO | INV.ALL_VSTATS):
                arenaDP = self.sessionProvider.getArenaDP()
                if targets & INV.ALL_VINFO:
                    vInfoVO = arenaDP.getVehicleInfo(vehicleID)
                if targets & INV.ALL_VSTATS:
                    vStatsVO = arenaDP.getVehicleStats(vehicleID)

                if targets & INV.VEHICLE_STATUS:
                    data['vehicleStatus'] = vInfoVO.vehicleStatus

                if targets & INV.SQUAD_INDEX:
                    data['squadIndex'] = vInfoVO.squadIndex

                # why vInfoVO.playerStatus == 0?
                #if targets & INV.PLAYER_STATUS:
                #    data['playerStatus'] = vInfoVO.playerStatus

                if targets & INV.FRAGS:
                    data['frags'] = vStatsVO.frags

            if data:
                as_xfw_cmd(XVM_BATTLE_COMMAND.AS_UPDATE_PLAYER_STATE, vehicleID, data)
        except Exception, ex:
            err(traceback.format_exc())

    def updateTarget(self):
        self.updateTargetCallbackID = None
        as_xfw_cmd(XVM_BATTLE_COMMAND.AS_ON_TARGET_CHANGED, self.targetVehicleID)

    def invalidateArenaInfo(self):
        #debug('battle: invalidateArenaInfo')
        if self.battle_page:
            if battle_loading.isBattleLoadingShowed():
                if 'battleLoading' in self.battle_page.as_getComponentsVisibilityS():
                    battleLoading = self.battle_page.getComponent(BATTLE_VIEW_ALIASES.BATTLE_LOADING)
                    if battleLoading:
                        battle_loading._setBattleLoading(False)
                        battleLoading.invalidateArenaInfo()
            ctrl = self.battle_page.getComponent(BATTLE_VIEW_ALIASES.BATTLE_STATISTIC_DATA_CONTROLLER)
            if ctrl:
                ctrl._BattleStatisticsDataController__setPersonalStatus()
                ctrl._BattleStatisticsDataController__setArenaDescription()
                arenaDP = ctrl._battleCtx.getArenaDP()
                ctrl.invalidateVehiclesInfo(arenaDP)
                ctrl.invalidateVehiclesStats(arenaDP)
            # update vehicles data
            for (vehicleID, vData) in BigWorld.player().arena.vehicles.iteritems():
                self.updatePlayerState(vehicleID, INV.ALL)
            g_eventBus.handleEvent(events.HasCtxEvent(XVM_BATTLE_EVENT.ARENA_INFO_INVALIDATED))


    #####################################################################
    # onXfwCommand

    # returns: (result, status)
    def onXfwCommand(self, cmd, *args):
        try:
            if cmd == XVM_BATTLE_COMMAND.REQUEST_BATTLE_GLOBAL_DATA:
                self.xvm_battle_swf_initialized = True
                as_xfw_cmd(XVM_BATTLE_COMMAND.AS_RESPONSE_BATTLE_GLOBAL_DATA, *shared.getGlobalBattleData())
                return (None, True)

            elif cmd == XVM_BATTLE_COMMAND.XMQP_INIT:
                xmqp_events.onBattleInit()
                return (None, True)

            elif cmd == XVM_BATTLE_COMMAND.BATTLE_CTRL_SET_VEHICLE_DATA:
                self.invalidateArenaInfo()
                return (None, True)

            elif cmd == XVM_BATTLE_COMMAND.CAPTURE_BAR_GET_BASE_NUM_TEXT:
                n = int(args[0])
                res = getBattleSubTypeBaseNumder(BigWorld.player().arenaTypeID, n & 0x3F, n >> 6)
                return (res, True)

            elif cmd == XVM_BATTLE_COMMAND.SET_MINIMAP_MAX_SIZE_INDEX:
                minimap_settings.MINIMAP_MAX_SIZE_INDEX = int(args[0])
                return (None, True)

            elif cmd == XVM_BATTLE_COMMAND.MINIMAP_CLICK:
                return (xmqp_events.send_minimap_click(args[0]), True)

        except Exception, ex:
            err(traceback.format_exc())
            return (None, True)

        return (None, False)

    def onVMInvalidateArenaInfo(self, e=None):
        self.invalidateArenaInfo()

    # misc

    def _getVehicleDamageType(self, attackerID):
        entryVehicle = BigWorld.player().arena.vehicles.get(attackerID, None)
        if not entryVehicle:
            return markers2d_settings.DAMAGE_TYPE.FROM_UNKNOWN
        if attackerID == avatar_getter.getPlayerVehicleID():
            return markers2d_settings.DAMAGE_TYPE.FROM_PLAYER
        entityName = self.sessionProvider.getCtx().getPlayerGuiProps(attackerID, entryVehicle['team'])
        if entityName == PLAYER_GUI_PROPS.squadman:
            return markers2d_settings.DAMAGE_TYPE.FROM_SQUAD
        if entityName == PLAYER_GUI_PROPS.ally:
            return markers2d_settings.DAMAGE_TYPE.FROM_ALLY
        if entityName == PLAYER_GUI_PROPS.enemy:
            return markers2d_settings.DAMAGE_TYPE.FROM_ENEMY
        return markers2d_settings.DAMAGE_TYPE.FROM_UNKNOWN

g_battle = Battle()
