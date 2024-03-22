"""
SPDX-License-Identifier: GPL-3.0-or-later
Copyright (c) 2013-2024 XVM Contributors
"""

#
# Imports
#

# stdlib
import logging
import weakref

# BigWorld
import BigWorld
import constants
from PlayerEvents import g_playerEvents
from Avatar import PlayerAvatar
from Vehicle import Vehicle
from helpers import dependency
from skeletons.gui.app_loader import IAppLoader
from skeletons.gui.battle_session import IBattleSessionProvider
from gui.app_loader.settings import APP_NAME_SPACE
from gui.shared import g_eventBus, events
from gui.shared.gui_items.Vehicle import VEHICLE_CLASS_NAME
from gui.shared.utils.functions import getBattleSubTypeBaseNumber
from gui.battle_control import avatar_getter
from gui.battle_control.arena_info.settings import INVALIDATE_OP
from gui.battle_control.battle_constants import PLAYER_GUI_PROPS
from gui.battle_control.battle_constants import FEEDBACK_EVENT_ID
from gui.battle_control.battle_constants import VEHICLE_VIEW_STATE
from gui.battle_control.controllers.battle_field_ctrl import BattleFieldCtrl
from gui.battle_control.controllers.dyn_squad_functional import DynSquadFunctional
from gui.Scaleform.genConsts.BATTLE_VIEW_ALIASES import BATTLE_VIEW_ALIASES
from gui.Scaleform.daapi.settings.views import VIEW_ALIAS
from gui.Scaleform.daapi.view.battle.epic.stats_exchange import EpicStatisticsDataController
from gui.Scaleform.daapi.view.battle.shared import battle_loading
from gui.Scaleform.daapi.view.battle.shared.damage_panel import DamagePanel
from gui.Scaleform.daapi.view.battle.shared.markers2d import settings as markers2d_settings
from gui.Scaleform.daapi.view.battle.shared.minimap.plugins import ArenaVehiclesPlugin
from gui.Scaleform.daapi.view.battle.shared.page import SharedPage
from gui.Scaleform.daapi.view.battle.shared.postmortem_panel import PostmortemPanel
from gui.Scaleform.daapi.view.battle.shared.stats_exchange import BattleStatisticsDataController
import gui.Scaleform.daapi.view.battle.shared.hint_panel.plugins as hint_plugin
from gui.Scaleform.daapi.view.meta.PlayersPanelMeta import PlayersPanelMeta

# XFW
from xfw import *

# XFW Actionscript
from xfw_actionscript.python import as_xfw_cmd

# XVM Main
import xvm_main.python.config as config

# XVM Battle
from consts import INT_CD, INV, SPOTTED_STATUS, XVM_BATTLE_COMMAND, XVM_BATTLE_EVENT
import shared



#
# Constants
#

NOT_SUPPORTED_BATTLE_TYPES = [ 
    constants.ARENA_GUI_TYPE.EVENT_BATTLES,
    constants.ARENA_GUI_TYPE.BATTLE_ROYALE,
    constants.ARENA_GUI_TYPE.MAPS_TRAINING,
    constants.ARENA_GUI_TYPE.RTS,
    constants.ARENA_GUI_TYPE.RTS_TRAINING,
    constants.ARENA_GUI_TYPE.RTS_BOOTCAMP,
    constants.ARENA_GUI_TYPE.COMP7,
    constants.ARENA_GUI_TYPE.WINBACK # TODO: fix broken totalEfficiency and hitLog due to broken PlayerPanels
]



#
# Globals
#

g_battle = None
isBattleTypeSupported = True



#
# Handlers
#

# PlayerAvatar

def _PlayerAvatar_vehicle_onAppearanceReady(self, vehicle):
    # on any player marker appear
    # debug("> _PlayerAvatar_vehicle_onAppearanceReady: hp=%i" % vehicle.health)
    if vehicle.id == self.playerVehicleID:
        g_battle.isSPG = self.vehicleTypeDescriptor.type.getVehicleClass() == VEHICLE_CLASS_NAME.SPG
        g_battle.shellCD = 0
    g_battle.updatePlayerState(vehicle.id, INV.ALL)


# Vehicle
def _Vehicle_onHealthChanged(self, newHealth, oldHealth, attackerID, attackReasonID):
    # any vehicle health changed
    # update only for player vehicle, others handled on vehicle feedback event
    if self.isPlayerVehicle:
        g_battle.onVehicleHealthChanged(self.id, newHealth, attackerID, attackReasonID)


# BattleFieldCtrl
def _BattleFieldCtrl__setEnemyMaxHealth(self, vehicleID, currentMaxHealth, newMaxHealth):
    g_battle.updatePlayerState(vehicleID, INV.MAX_HEALTH, newMaxHealth)


def _BattleFieldCtrl__setAllyMaxHealth(self, vehicleID, currentMaxHealth, newMaxHealth):
    g_battle.updatePlayerState(vehicleID, INV.MAX_HEALTH, newMaxHealth)


# DynSquadFunctional
def _DynSquadFunctional_updateVehiclesInfo(self, updated, arenaDP):
    # debug("> _DynSquadFunctional_updateVehiclesInfo")
    try:
        # is dynamic squad created
        if avatar_getter.getArena().guiType == constants.ARENA_GUI_TYPE.RANDOM:
            for flags, vo in updated:
                if flags & INVALIDATE_OP.PREBATTLE_CHANGED and vo.squadIndex > 0:
                    g_battle.updatePlayerState(vo.vehicleID, INV.SQUAD_INDEX) # | INV.PLAYER_STATUS
    except Exception:
        logging.getLogger('XVM/Battle').exception('_DynSquadFunctional_updateVehiclesInfo')


# DamagePanel
def _DamagePanel_updateDeviceState(self, value):
    try:
        as_xfw_cmd(XVM_BATTLE_COMMAND.AS_UPDATE_DEVICE_STATE, *value)
    except:
        logging.getLogger('XVM/Battle').exception('_DamagePanel_updateDeviceState')


# ArenaVehiclesPlugin
def _ArenaVehiclesPlugin_setInAoI(self, entry, isInAoI):
    try:
        for vehicleID, entry2 in self._entries.iteritems():
            if entry == entry2:
                g_battle.updateSpottedStatus(vehicleID, isInAoI)
    except:
        logging.getLogger('XVM/Battle').exception('_ArenaVehiclesPlugin_setInAoI')


# SharedPage
def _SharedPage_as_setPostmortemTipsVisibleS(base, self, value):
    if not config.get('battle/showPostmortemTips'):
        value = False
    base(self, value)

def _SharedPage_switchToPostmortem(base, self):
    if config.get('battle/showPostmortemTips'):
        base(self)


# BSDC
def _BattleStatisticsDataController_as_setQuestsInfoS(base, self, data, setForce):
    # force update quests in FullStats
    base(self, data, True)


# Hints
def _hint_plugin_createPlugins(base):
    if not config.get('battle/showBattleHint'):
        return {}
    return base()


# disable DogTag's
def _PostmortemPanel_onDogTagKillerInPlaySound(base, self):
    if not config.get('battle/showPostmortemDogTag', True) or not config.get('battle/showPostmortemTips', True):
        return
    base(self)


def _PostmortemPanel__onKillerDogTagSet(base, self, dogTagInfo):
    if not config.get('battle/showPostmortemDogTag', True):
        return
    base(self, dogTagInfo)


def _PlayersPanelMetaas_setPanelHPBarVisibilityStateS(base, self, value):
    if config.get('playersPanel/enabled') and config.get('playersPanel/removeHealthPoints'):
        return
    base(self, value)



#
# Battle
#

class Battle(object):

    battle_page = None
    updateTargetCallbackID = None
    targetVehicleID = None
    xvm_battle_swf_initialized = False
    is_moving = False
    shellCD = 0
    isSPG = False

    appLoader = dependency.descriptor(IAppLoader)
    sessionProvider = dependency.descriptor(IBattleSessionProvider)

    def __init__(self):
        self._logger = logging.getLogger('XVM/Battle')
        g_eventBus.addListener(XFW_COMMAND.XFW_CMD, self.onXfwCommand)
        g_eventBus.addListener(XFW_EVENT.APP_INITIALIZED, self.onAppInitialized)
        g_eventBus.addListener(XFW_EVENT.APP_DESTROYED, self.onAppDestroyed)

        g_playerEvents.onAvatarBecomePlayer += self.onBecomePlayer
        g_playerEvents.onAvatarBecomeNonPlayer += self.onBecomeNonPlayer

    def fini(self):
        g_eventBus.removeListener(XFW_COMMAND.XFW_CMD, self.onXfwCommand)
        g_eventBus.removeListener(XFW_EVENT.APP_INITIALIZED, self.onAppInitialized)
        g_eventBus.removeListener(XFW_EVENT.APP_DESTROYED, self.onAppDestroyed)
    
        g_playerEvents.onAvatarBecomePlayer -= self.onBecomePlayer
        g_playerEvents.onAvatarBecomeNonPlayer -= self.onBecomeNonPlayer

    def onNewVehicleListReceived(self):
        as_xfw_cmd(XVM_BATTLE_COMMAND.AS_RESPONSE_BATTLE_GLOBAL_DATA, *shared.getGlobalBattleData())


    def onBecomePlayer(self, *args, **kwargs):
        global isBattleTypeSupported
        try:
            arena = avatar_getter.getArena()
            if arena:
                isBattleTypeSupported = arena.guiType not in NOT_SUPPORTED_BATTLE_TYPES
                arena.onVehicleKilled += self.onVehicleKilled
                arena.onAvatarReady += self.onAvatarReady
                arena.onVehicleStatisticsUpdate += self.onVehicleStatisticsUpdate
                arena.onNewVehicleListReceived += self.onNewVehicleListReceived
            sessionProvider = dependency.instance(IBattleSessionProvider)
            ctrl = sessionProvider.shared.feedback
            if ctrl:
                ctrl.onVehicleFeedbackReceived += self.onVehicleFeedbackReceived
            ctrl = sessionProvider.shared.vehicleState
            if ctrl:
                ctrl.onVehicleStateUpdated += self.onVehicleStateUpdated
            ctrl = sessionProvider.shared.optionalDevices
            if ctrl:
                ctrl.onOptionalDeviceAdded += self.onOptionalDeviceAdded
                ctrl.onOptionalDeviceUpdated += self.onOptionalDeviceUpdated
            ctrl = sessionProvider.shared.ammo
            if ctrl:
                ctrl.onCurrentShellChanged += self.onCurrentShellChanged
            self.onStartBattle()
        except Exception:
            self._logger.exception('onBecomePlayer')

    def onBecomeNonPlayer(self, *args, **kwargs):
        try:
            arena = avatar_getter.getArena()
            if arena:
                arena.onVehicleKilled -= self.onVehicleKilled
                arena.onAvatarReady -= self.onAvatarReady
                arena.onVehicleStatisticsUpdate -= self.onVehicleStatisticsUpdate
                arena.onNewVehicleListReceived -= self.onNewVehicleListReceived
            sessionProvider = dependency.instance(IBattleSessionProvider)
            ctrl = sessionProvider.shared.feedback
            if ctrl:
                ctrl.onVehicleFeedbackReceived -= self.onVehicleFeedbackReceived
            ctrl = sessionProvider.shared.vehicleState
            if ctrl:
                ctrl.onVehicleStateUpdated -= self.onVehicleStateUpdated
            ctrl = sessionProvider.shared.optionalDevices
            if ctrl:
                ctrl.onOptionalDeviceAdded -= self.onOptionalDeviceAdded
                ctrl.onOptionalDeviceUpdated -= self.onOptionalDeviceUpdated
            ctrl = sessionProvider.shared.ammo
            if ctrl:
                ctrl.onCurrentShellChanged -= self.onCurrentShellChanged
        except Exception:
            self._logger.exception('onBecomeNonPlayer')

    def onAppInitialized(self, event):
        #log('onAppInitialized: ' + str(event.ctx.ns))
        if event.ctx.ns == APP_NAME_SPACE.SF_BATTLE:
            self.xvm_battle_swf_initialized = False
            app = self.appLoader.getApp(event.ctx.ns)
            if app is not None and app.loaderManager is not None:
                app.loaderManager.onViewLoaded += self.onViewLoaded

    def onAppDestroyed(self, event):
        #log('onAppDestroyed: ' + str(event.ctx.ns))
        if event.ctx.ns == APP_NAME_SPACE.SF_BATTLE:
            self.xvm_battle_swf_initialized = False
            self.battle_page = None
            app = self.appLoader.getApp(event.ctx.ns)
            if app is not None and app.loaderManager is not None:
                app.loaderManager.onViewLoaded -= self.onViewLoaded

    def onViewLoaded(self, view, loadParams):
        if view and view.uniqueName in [VIEW_ALIAS.CLASSIC_BATTLE_PAGE,
                                        VIEW_ALIAS.EPIC_RANDOM_PAGE,
                                        VIEW_ALIAS.EPIC_BATTLE_PAGE,
                                        VIEW_ALIAS.RANKED_BATTLE_PAGE,
                                        VIEW_ALIAS.BATTLE_ROYALE_PAGE,
                                        VIEW_ALIAS.STRONGHOLD_BATTLE_PAGE,
                                        VIEW_ALIAS.WINBACK_BATTLE_PAGE]:
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
        elif eventID == FEEDBACK_EVENT_ID.ENTITY_IN_FOCUS:
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

    def onOptionalDeviceAdded(self, optDeviceInBattle):
        if optDeviceInBattle.getIntCD() in INT_CD.STEREOSCOPE:
            as_xfw_cmd(XVM_BATTLE_COMMAND.AS_STEREOSCOPE_TOGGLED, bool(optDeviceInBattle.getStatus()))

    def onOptionalDeviceUpdated(self, optDeviceInBattle):
        if optDeviceInBattle.getIntCD() in INT_CD.STEREOSCOPE:
            as_xfw_cmd(XVM_BATTLE_COMMAND.AS_STEREOSCOPE_TOGGLED, bool(optDeviceInBattle.getStatus()))

    def onVehicleHealthChanged(self, vehicleID, newHealth, attackerID, attackReasonID):
        inv = INV.CUR_HEALTH
        userData = None
        if attackerID == avatar_getter.getPlayerVehicleID():
            inv |= INV.DAMAGE_CAUSED
        self.updatePlayerState(vehicleID, inv, userData)

    def onCurrentShellChanged(self, intCD):
        if self.shellCD != intCD:
            self.shellCD = intCD
            if self.isSPG:
                as_xfw_cmd(XVM_BATTLE_COMMAND.AS_CHANGING_SHELL, intCD)

    def updateSpottedStatus(self, vehicleID, active):
        spotted_status = SPOTTED_STATUS.SPOTTED if active else SPOTTED_STATUS.LOST
        if self.getSpottedStatus(vehicleID) != spotted_status:
            self._spotted_cache[vehicleID] = spotted_status
            self.updatePlayerState(vehicleID, INV.SPOTTED_STATUS)

    def updatePlayerState(self, vehicleID, targets, userData=None):
        try:
            data = {}

            arenaDP = self.sessionProvider.getArenaDP()

            if targets & INV.SPOTTED_STATUS:
                data['spottedStatus'] = self.getSpottedStatus(vehicleID)

            if targets & INV.DAMAGE_CAUSED:
                data['__damageCaused'] = 1

            if targets & INV.ALL_ENTITY:
                entity = BigWorld.entity(vehicleID)

                if targets & INV.CUR_HEALTH:
                    if entity and hasattr(entity, 'health'):
                        data['curHealth'] = entity.health

                if targets & INV.MAX_HEALTH:
                    if userData is not None:
                        data['maxHealth'] = userData
                    else:
                        vInfoVO = arenaDP.getVehicleInfo(vehicleID)
                        if vInfoVO:
                            data['maxHealth'] = vInfoVO.vehicleType.maxHealth
                        elif entity and hasattr(entity, 'maxHealth'):
                            data['maxHealth'] = entity.maxHealth

                if targets & INV.MARKS_ON_GUN:
                    if entity and hasattr(entity, 'publicInfo'):
                        data['marksOnGun'] = entity.publicInfo.marksOnGun

            if targets & (INV.ALL_VINFO | INV.ALL_VSTATS):
                if targets & INV.ALL_VINFO:
                    vInfoVO = arenaDP.getVehicleInfo(vehicleID)
                if targets & INV.ALL_VSTATS:
                    vStatsVO = arenaDP.getVehicleStats(vehicleID)

                if targets & INV.VEHICLE_STATUS:
                    data['vehicleStatus'] = vInfoVO.vehicleStatus

                if targets & INV.SQUAD_INDEX:
                    data['squadIndex'] = vInfoVO.squadIndex

                if targets & INV.RANK_LEVEL:
                    data['rankLevel'] = vInfoVO.ranked.rank

                # why vInfoVO.playerStatus == 0?
                #if targets & INV.PLAYER_STATUS:
                #    data['playerStatus'] = vInfoVO.playerStatus

                if targets & INV.FRAGS:
                    data['frags'] = vStatsVO.frags

            if data:
                as_xfw_cmd(XVM_BATTLE_COMMAND.AS_UPDATE_PLAYER_STATE, vehicleID, data)
        except Exception:
            self._logger.exception('updatePlayerState')

    def updateTarget(self):
        self.updateTargetCallbackID = None
        as_xfw_cmd(XVM_BATTLE_COMMAND.AS_ON_TARGET_CHANGED, self.targetVehicleID)

    def invalidateArenaInfo(self):
        #debug('battle: invalidateArenaInfo')
        if self.battle_page:
            if battle_loading._isBattleLoadingShowed():
                if 'battleLoading' in self.battle_page.as_getComponentsVisibilityS():
                    battleLoading = self.battle_page.getComponent(BATTLE_VIEW_ALIASES.BATTLE_LOADING)
                    if battleLoading:
                        battle_loading._setBattleLoading(False)
                        try:
                            battleLoading.invalidateArenaInfo()
                        except Exception:
                            self._logger.exception('invalidateArenaInfo')
            ctrl = self.battle_page.getComponent(BATTLE_VIEW_ALIASES.BATTLE_STATISTIC_DATA_CONTROLLER)
            if ctrl and not isinstance(ctrl, EpicStatisticsDataController):
                ctrl._dispose()
                ctrl._populate()
            # update vehicles data
            for (vehicleID, vData) in avatar_getter.getArena().vehicles.iteritems():
                self.updatePlayerState(vehicleID, INV.ALL)
            g_eventBus.handleEvent(events.HasCtxEvent(XVM_BATTLE_EVENT.ARENA_INFO_INVALIDATED))

    def onXfwCommand(self, cmd, *args):
        # returns: (result, status)
        try:
            if cmd == XVM_BATTLE_COMMAND.REQUEST_BATTLE_GLOBAL_DATA:
                self.xvm_battle_swf_initialized = True
                as_xfw_cmd(XVM_BATTLE_COMMAND.AS_RESPONSE_BATTLE_GLOBAL_DATA, *shared.getGlobalBattleData())
                return (None, True)

            elif cmd == XVM_BATTLE_COMMAND.BATTLE_CTRL_SET_VEHICLE_DATA:
                self.invalidateArenaInfo()
                return (None, True)

            elif cmd == XVM_BATTLE_COMMAND.CAPTURE_BAR_GET_BASE_NUM_TEXT:
                n = int(args[0])
                res = getBattleSubTypeBaseNumber(BigWorld.player().arenaTypeID, n & 0x3F, n >> 6)
                return (res, True)

        except Exception:
            self._logger.exception('onXfwCommand')
            return (None, True)

        return (None, False)

    # misc

    def _getVehicleDamageType(self, attackerID):
        entryVehicle = avatar_getter.getArena().vehicles.get(attackerID, None)
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



#
# Initialization
#

def init():
    global g_battle
    g_battle = Battle()

    registerEvent(PlayerAvatar, 'vehicle_onAppearanceReady')(_PlayerAvatar_vehicle_onAppearanceReady)
    registerEvent(Vehicle, 'onHealthChanged')(_Vehicle_onHealthChanged)
    registerEvent(BattleFieldCtrl, '_BattleFieldCtrl__setEnemyMaxHealth')(_BattleFieldCtrl__setEnemyMaxHealth)
    registerEvent(BattleFieldCtrl, '_BattleFieldCtrl__setAllyMaxHealth')(_BattleFieldCtrl__setAllyMaxHealth)
    registerEvent(DynSquadFunctional, 'updateVehiclesInfo')(_DynSquadFunctional_updateVehiclesInfo)
    registerEvent(DamagePanel, '_updateDeviceState')(_DamagePanel_updateDeviceState)
    registerEvent(ArenaVehiclesPlugin, '_setInAoI')(_ArenaVehiclesPlugin_setInAoI)
    overrideMethod(SharedPage, 'as_setPostmortemTipsVisibleS')(_SharedPage_as_setPostmortemTipsVisibleS)
    overrideMethod(SharedPage, '_switchToPostmortem')(_SharedPage_switchToPostmortem)
    overrideMethod(BattleStatisticsDataController, 'as_setQuestsInfoS')(_BattleStatisticsDataController_as_setQuestsInfoS)
    overrideMethod(hint_plugin, 'createPlugins')(_hint_plugin_createPlugins)
    overrideMethod(PostmortemPanel, 'onDogTagKillerInPlaySound')(_PostmortemPanel_onDogTagKillerInPlaySound)
    overrideMethod(PostmortemPanel, '_PostmortemPanel__onKillerDogTagSet')(_PostmortemPanel__onKillerDogTagSet)
    overrideMethod(PlayersPanelMeta, 'as_setPanelHPBarVisibilityStateS')(_PlayersPanelMetaas_setPanelHPBarVisibilityStateS)


def fini():
    global g_battle
    g_battle.fini()
    g_battle = None
