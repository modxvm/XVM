""" XVM (c) www.modxvm.com 2013-2017 """

#####################################################################
# imports

import Math
import math
import traceback

import BigWorld
import constants
import game
from constants import VISIBILITY
from account_helpers.settings_core.SettingsCore import SettingsCore
from account_helpers.settings_core import settings_constants
from Avatar import PlayerAvatar
from AvatarInputHandler.control_modes import PostMortemControlMode
from items.vehicles import VEHICLE_CLASS_TAGS
from gui.shared import g_eventBus, events
from gui.Scaleform.daapi.view.battle.shared.minimap.component import MinimapComponent
from gui.Scaleform.daapi.view.battle.shared.minimap.settings import ENTRY_SYMBOL_NAME, ADDITIONAL_FEATURES
from gui.Scaleform.daapi.view.battle.shared.minimap.plugins import ArenaVehiclesPlugin, PersonalEntriesPlugin

from xfw import *

from xvm_main.python.logger import *
from xvm_main.python.consts import *
import xvm_main.python.config as config

from battle import g_battle


#####################################################################
# initialization/finalization

def onConfigLoaded(self, e=None):
    g_minimap.enabled = config.get('minimap/enabled', True)
    g_minimap.labelsEnabled = config.get('minimap/labelsEnabled', True)
    g_minimap.linesEnabled = config.get('minimap/linesEnabled', True)
    g_minimap.circlesEnabled = config.get('minimap/circlesEnabled', True)

g_eventBus.addListener(XVM_EVENT.CONFIG_LOADED, onConfigLoaded)

@registerEvent(game, 'fini')
def fini():
    g_eventBus.removeListener(XVM_EVENT.CONFIG_LOADED, onConfigLoaded)


######################################################################
## handlers

# Minimap

@overrideMethod(MinimapComponent, '_populate')
def _MinimapComponent_populate(base, self):
    g_minimap.init(self)
    base(self)

@overrideMethod(MinimapComponent, '_dispose')
def _MinimapComponent_dispose(base, self):
    g_minimap.destroy()
    base(self)

@overrideMethod(MinimapComponent, 'addEntry')
def _MinimapComponent_addEntry(base, self, symbol, *args, **kwargs):
    if g_minimap.active:
        if symbol == ENTRY_SYMBOL_NAME.VEHICLE:
            symbol = "com.xvm.battle.minimap.entries.vehicle::UI_VehicleEntry"
        elif symbol == ENTRY_SYMBOL_NAME.VIEW_POINT:
            symbol = "com.xvm.battle.minimap.entries.personal::UI_ViewPointEntry"
        elif symbol == ENTRY_SYMBOL_NAME.DEAD_POINT:
            symbol = "com.xvm.battle.minimap.entries.personal::UI_DeadPointEntry"
        elif symbol == ENTRY_SYMBOL_NAME.VIDEO_CAMERA:
            symbol = "com.xvm.battle.minimap.entries.personal::UI_VideoCameraEntry"
        elif symbol == ENTRY_SYMBOL_NAME.ARCADE_CAMERA:
            symbol = "com.xvm.battle.minimap.entries.personal::UI_ArcadeCameraEntry"
        elif symbol == ENTRY_SYMBOL_NAME.STRATEGIC_CAMERA:
            symbol = "com.xvm.battle.minimap.entries.personal::UI_StrategicCameraEntry"
        elif symbol == ENTRY_SYMBOL_NAME.VIEW_RANGE_CIRCLES:
           symbol = "com.xvm.battle.minimap.entries.personal::UI_ViewRangeCirclesEntry"
        elif symbol == ENTRY_SYMBOL_NAME.MARK_CELL:
            symbol = "com.xvm.battle.minimap.entries.personal::UI_CellFlashEntry"
        #else:
        #    debug('add minimap entry: ' + symbol)
    return base(self, symbol, *args, **kwargs)

@overrideMethod(ArenaVehiclesPlugin, '_ArenaVehiclesPlugin__switchToVehicle')
def _ArenaVehiclesPlugin__switchToVehicle(base, self, prevCtrlID):
    base(self, prevCtrlID)
    if g_minimap.active and g_minimap.labelsEnabled:
        if prevCtrlID != self._ctrlVehicleID:
            if prevCtrlID and prevCtrlID != self._getPlayerVehicleID() and prevCtrlID in self._entries:
                self._invoke(self._entries[prevCtrlID].getID(), 'setControlMode', False)
            if self._ctrlVehicleID:
                if self._ctrlVehicleID != self._getPlayerVehicleID() and self._ctrlVehicleID in self._entries:
                    self._invoke(self._entries[self._ctrlVehicleID].getID(), 'setControlMode', True)
                if g_minimap.viewPointID:
                    self._invoke(g_minimap.viewPointID, 'setVehicleID', self._ctrlVehicleID)

# Disable standard features if XVM minimap is active

@overrideClassMethod(ADDITIONAL_FEATURES, 'isOn')
def _ADDITIONAL_FEATURES_isOn(base, cls, mask):
    return False if g_minimap.active and g_minimap.labelsEnabled else base(mask)

@overrideClassMethod(ADDITIONAL_FEATURES, 'isChanged')
def _ADDITIONAL_FEATURES_isChanged(base, cls, mask):
    return False if g_minimap.active and g_minimap.labelsEnabled else base(mask)

@overrideMethod(PersonalEntriesPlugin, '_PersonalEntriesPlugin__createViewPointEntry')
def _PersonalEntriesPlugin__createViewPointEntry(base, self, avatar):
   base(self, avatar)
   g_minimap.viewPointID = self._getViewPointID()

@overrideMethod(PersonalEntriesPlugin, '_PersonalEntriesPlugin__onVehicleFeedbackReceived')
def _PersonalEntriesPlugin__onVehicleFeedbackReceived(base, self, eventID, _, value):
    if g_minimap.active and g_minimap.circlesEnabled:
        VISIBILITY.MAX_RADIUS = 1000
        base(self, eventID, _, value)
        VISIBILITY.MAX_RADIUS = 445
    else:
        base(self, eventID, _, value)

# Minimap settings

_CIRCLES_SETTINGS = (
    settings_constants.GAME.MINIMAP_DRAW_RANGE,
    settings_constants.GAME.MINIMAP_MAX_VIEW_RANGE,
    settings_constants.GAME.MINIMAP_VIEW_RANGE,
    settings_constants.GAME.SHOW_VEH_MODELS_ON_MAP)
_LINES_SETTINGS = (
    settings_constants.GAME.SHOW_VECTOR_ON_MAP,
    settings_constants.GAME.SHOW_SECTOR_ON_MAP)
_LABELS_SETTINGS = (
    settings_constants.GAME.SHOW_VEH_MODELS_ON_MAP)
_DEFAULTS = {
    settings_constants.GAME.SHOW_VECTOR_ON_MAP: False,
    settings_constants.GAME.SHOW_SECTOR_ON_MAP: True,
    settings_constants.GAME.MINIMAP_DRAW_RANGE: True,
    settings_constants.GAME.MINIMAP_MAX_VIEW_RANGE: True,
    settings_constants.GAME.MINIMAP_VIEW_RANGE: True,
    settings_constants.GAME.SHOW_VEH_MODELS_ON_MAP: False,
}

_in_PersonalEntriesPlugin_setSettings = False
_in_ArenaVehiclesPlugin_setSettings = False

@overrideMethod(SettingsCore, 'getSetting')
def _SettingsCore_getSetting(base, self, name):
    value = base(self, name)
    if g_minimap.active:
        global _in_PersonalEntriesPlugin_setSettings
        if _in_PersonalEntriesPlugin_setSettings:
            if name in _LINES_SETTINGS:
                if g_minimap.linesEnabled:
                    value = _DEFAULTS[name]
            elif name in _CIRCLES_SETTINGS:
                if g_minimap.circlesEnabled:
                    value = _DEFAULTS[name]
        global _in_ArenaVehiclesPlugin_setSettings
        if _in_ArenaVehiclesPlugin_setSettings:
            if name in _LABELS_SETTINGS:
                if g_minimap.labelsEnabled:
                    value = _DEFAULTS[name]
        #debug('getSetting: {} = {}'.format(name, value))
    return value

@overrideMethod(PersonalEntriesPlugin, 'start')
def _PersonalEntriesPlugin_start(base, self):
    base(self)
    if g_minimap.active and g_minimap.linesEnabled:
        if not self._PersonalEntriesPlugin__yawLimits:
            vehicle = BigWorld.player().arena.vehicles.get(BigWorld.player().playerVehicleID)
            staticTurretYaw = vehicle['vehicleType'].gun['staticTurretYaw']
            if staticTurretYaw is None:
                vInfoVO = self._arenaDP.getVehicleInfo()
                yawLimits = vInfoVO.vehicleType.turretYawLimits
                if yawLimits:
                    self._PersonalEntriesPlugin__yawLimits = (math.degrees(yawLimits[0]), math.degrees(yawLimits[1]))

@overrideMethod(PersonalEntriesPlugin, 'setSettings')
def _PersonalEntriesPlugin_setSettings(base, self):
    global _in_PersonalEntriesPlugin_setSettings
    _in_PersonalEntriesPlugin_setSettings = True
    base(self)
    _in_PersonalEntriesPlugin_setSettings = False

@overrideMethod(PersonalEntriesPlugin, 'updateSettings')
def _PersonalEntriesPlugin_updateSettings(base, self, diff):
    if g_minimap.active:
        if g_minimap.linesEnabled:
            if settings_constants.GAME.SHOW_VECTOR_ON_MAP in diff:
                diff[settings_constants.GAME.SHOW_VECTOR_ON_MAP] = _DEFAULTS[settings_constants.GAME.SHOW_VECTOR_ON_MAP]
            if settings_constants.GAME.SHOW_SECTOR_ON_MAP in diff:
                diff[settings_constants.GAME.SHOW_SECTOR_ON_MAP] = _DEFAULTS[settings_constants.GAME.SHOW_SECTOR_ON_MAP]
        if g_minimap.circlesEnabled:
            if settings_constants.GAME.MINIMAP_DRAW_RANGE in diff:
                diff[settings_constants.GAME.MINIMAP_DRAW_RANGE] = _DEFAULTS[settings_constants.GAME.MINIMAP_DRAW_RANGE]
            if settings_constants.GAME.MINIMAP_MAX_VIEW_RANGE in diff:
                diff[settings_constants.GAME.MINIMAP_MAX_VIEW_RANGE] = _DEFAULTS[settings_constants.GAME.MINIMAP_MAX_VIEW_RANGE]
            if settings_constants.GAME.MINIMAP_VIEW_RANGE in diff:
                diff[settings_constants.GAME.MINIMAP_VIEW_RANGE] = _DEFAULTS[settings_constants.GAME.MINIMAP_VIEW_RANGE]
    base(self, diff)

@overrideMethod(ArenaVehiclesPlugin, 'setSettings')
def _ArenaVehiclesPlugin_setSettings(base, self):
    global _in_ArenaVehiclesPlugin_setSettings
    _in_ArenaVehiclesPlugin_setSettings = True
    base(self)
    _in_ArenaVehiclesPlugin_setSettings = False

@overrideMethod(ArenaVehiclesPlugin, 'updateSettings')
def _ArenaVehiclesPlugin_updateSettings(base, self, diff):
    if g_minimap.active:
        if g_minimap.labelsEnabled:
            if settings_constants.GAME.SHOW_VEH_MODELS_ON_MAP in diff:
                diff[settings_constants.GAME.SHOW_VEH_MODELS_ON_MAP] = _DEFAULTS[settings_constants.GAME.SHOW_VEH_MODELS_ON_MAP]
    base(self, diff)

# Minimap dead switch
@registerEvent(PostMortemControlMode, 'onMinimapClicked')
def _PostMortemControlMode_onMinimapClicked(self, worldPos):
    #log('_PostMortemControlMode_onMinimapClicked active=' + str(g_minimap.active))
    if g_minimap.active and config.get('battle/minimapDeadSwitch'):
        try:
            battle = getBattleApp()
            if not battle:
                return

            if isReplay() and not IS_DEVELOPMENT:
                return

            minDistance = None
            toID = None
            player = BigWorld.player()
            plugin = g_minimap.minimapComponent.getPlugin('vehicles')
            for vehicleID, entry in plugin._entries.iteritems():
                vData = player.arena.vehicles[vehicleID]
                if player.team != vData['team'] or not vData['isAlive']:
                    continue
                matrix = entry.getMatrix()
                if matrix is not None:
                    pos = Math.Matrix(matrix).translation
                    distance = Math.Vector3(worldPos - pos).length
                    if minDistance is None or minDistance > distance:
                        minDistance = distance
                        toID = vehicleID
            if toID is not None:
                self.selectPlayer(toID)
        except Exception as ex:
            if IS_DEVELOPMENT:
                err(traceback.format_exc())


#####################################################################
# Minimap

class _Minimap(object):

    enabled = True
    initialized = False
    guiType = 0
    labelsEnabled = True
    linesEnabled = True
    circlesEnabled = True
    viewPointID = 0
    minimapComponent = None

    @property
    def active(self):
        #log('g_battle.xvm_battle_swf_initialized: ' + str(g_battle.xvm_battle_swf_initialized))
        return g_battle.xvm_battle_swf_initialized and \
               self.enabled and \
               self.initialized and \
               (self.guiType != constants.ARENA_GUI_TYPE.TUTORIAL)

    def init(self, minimapComponent):
        self.initialized = True
        self.guiType = BigWorld.player().arena.guiType
        self.minimapComponent = minimapComponent

    def destroy(self):
        self.initialized = False
        self.minimapComponent = None

g_minimap = _Minimap()
