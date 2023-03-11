"""
SPDX-License-Identifier: GPL-3.0-or-later
Copyright (c) 2016-2022 XVM Contributors
"""

#
# imports
#

# stdlib
import logging
import math

# BigWorld
import BigWorld
import Math
from constants import VISIBILITY
from account_helpers.settings_core import settings_constants
from account_helpers.settings_core.SettingsCore import SettingsCore
from AvatarInputHandler.control_modes import PostMortemControlMode
from gui.battle_control import avatar_getter
from gui.shared import g_eventBus
from gui.Scaleform.daapi.view.battle.shared.minimap.component import MinimapComponent
from gui.Scaleform.daapi.view.battle.shared.minimap.settings import ENTRY_SYMBOL_NAME
from gui.Scaleform.daapi.view.battle.shared.minimap.plugins import ArenaVehiclesPlugin, PersonalEntriesPlugin

# XFW
from xfw import IS_DEVELOPMENT
from xfw.events import overrideMethod
from xfw.wg import getBattleApp, isReplay

# XVM Main
import xvm_main.python.config as config
from xvm_main.python.consts import XVM_EVENT

# XVM Battle
from xvm_battle.python.battle import g_battle

# XVM Battle VM
from .consts import XVM_ENTRY_SYMBOL_NAME, UNSUPPORTED_BATTLE_TYPES, \
     UNSUPPORTED_GUI_TYPES, CIRCLES_SETTINGS, LABELS_SETTINGS, LINES_SETTINGS,\
     HP_SETTINGS, DEFAULTS  



#
# Globals
#

g_minimap = None

_in_PersonalEntriesPlugin_setSettings = False
_in_ArenaVehiclesPlugin_setSettings = False



#
# Handlers/MinimapComponent
#

def _MinimapComponent_populate(base, self):
    g_minimap.init(self)
    base(self)


def _MinimapComponent_dispose(base, self):
    if g_minimap is not None:
        g_minimap.destroy()
    base(self)


def _MinimapComponent_addEntry(base, self, symbol, *args, **kwargs):
    if g_minimap.active:
        if symbol == ENTRY_SYMBOL_NAME.VEHICLE:
            symbol = XVM_ENTRY_SYMBOL_NAME.VEHICLE
        elif symbol == ENTRY_SYMBOL_NAME.VIEW_POINT:
            symbol = XVM_ENTRY_SYMBOL_NAME.VIEW_POINT
        elif symbol == ENTRY_SYMBOL_NAME.DEAD_POINT:
            symbol = XVM_ENTRY_SYMBOL_NAME.DEAD_POINT
        elif symbol == ENTRY_SYMBOL_NAME.VIDEO_CAMERA:
            symbol = XVM_ENTRY_SYMBOL_NAME.VIDEO_CAMERA
        elif symbol == ENTRY_SYMBOL_NAME.ARCADE_CAMERA:
            symbol = XVM_ENTRY_SYMBOL_NAME.ARCADE_CAMERA
        elif symbol == ENTRY_SYMBOL_NAME.STRATEGIC_CAMERA:
            symbol = XVM_ENTRY_SYMBOL_NAME.STRATEGIC_CAMERA
        elif symbol == ENTRY_SYMBOL_NAME.VIEW_RANGE_CIRCLES:
            symbol = XVM_ENTRY_SYMBOL_NAME.VIEW_RANGE_CIRCLES
        else:
            logging.getLogger('XVM/Battle/Minimap').debug('add minimap entry: %s', symbol)
        # TODO: 1.10.0
        # elif symbol == ENTRY_SYMBOL_NAME.MARK_CELL:
        #     symbol = XVM_ENTRY_SYMBOL_NAME.MARK_CELL
    entryID = base(self, symbol, *args, **kwargs)
    if g_minimap.active:
        g_minimap.addEntry(entryID, symbol)
    return entryID


def _MinimapComponent_delEntry(base, self, entryID):
    if g_minimap.active:
        g_minimap.delEntry(entryID)
    base(self, entryID)



#
# Handlers/AreaVehiclesPlugin
#

def _ArenaVehiclesPlugin__switchToVehicle(base, self, prevCtrlID):
    base(self, prevCtrlID)
    if g_minimap.active and g_minimap.opt_labelsEnabled:
        if prevCtrlID != self._ctrlVehicleID:
            if prevCtrlID and prevCtrlID != self._getPlayerVehicleID() and prevCtrlID in self._entries:
                self._invoke(self._entries[prevCtrlID].getID(), 'xvm_setControlMode', False)
            if self._ctrlVehicleID:
                if self._ctrlVehicleID != self._getPlayerVehicleID() and self._ctrlVehicleID in self._entries:
                    self._invoke(self._entries[self._ctrlVehicleID].getID(), 'xvm_setControlMode', True)
                if g_minimap.viewPointID:
                    self._invoke(g_minimap.viewPointID, 'xvm_setVehicleID', self._ctrlVehicleID)


def _ArenaVehiclesPlugin_setSettings(base, self):
    global _in_ArenaVehiclesPlugin_setSettings
    _in_ArenaVehiclesPlugin_setSettings = True
    base(self)
    _in_ArenaVehiclesPlugin_setSettings = False


def _ArenaVehiclesPlugin_updateSettings(base, self, diff):
    if g_minimap is not None and g_minimap.active:
        if g_minimap.opt_labelsEnabled:
            if settings_constants.GAME.SHOW_VEH_MODELS_ON_MAP in diff:
                diff[settings_constants.GAME.SHOW_VEH_MODELS_ON_MAP] = DEFAULTS[settings_constants.GAME.SHOW_VEH_MODELS_ON_MAP]
        if g_minimap.opt_healthPointsEnabled:
            if settings_constants.GAME.SHOW_VEHICLE_HP_IN_MINIMAP in diff:
                diff[settings_constants.GAME.SHOW_VEHICLE_HP_IN_MINIMAP] = DEFAULTS[settings_constants.GAME.SHOW_VEHICLE_HP_IN_MINIMAP]
    base(self, diff)


def _ArenaVehiclesPlugin__showFeatures(base, self, flag):
    if g_minimap.active and g_minimap.opt_labelsEnabled:
        return
    base(self, flag)


def _ArenaVehiclesPlugin__showMinimapHP(base, self, flag):
    if g_minimap.active and g_minimap.opt_healthPointsEnabled:
        return
    base(self, flag)



#
# Handlers/PersonalEntriesPlugin
#

def _PersonalEntriesPlugin__updateViewPointEntry(base, self, vehicleID=0):
    base(self, vehicleID)
    g_minimap.viewPointID = self._getViewPointID()


def _PersonalEntriesPlugin_start(base, self):
    base(self)
    if g_minimap.active and g_minimap.opt_linesEnabled:
        if not self._PersonalEntriesPlugin__yawLimits:
            vehicle = avatar_getter.getArena().vehicles.get(avatar_getter.getPlayerVehicleID(), None)
            if vehicle is None:
                return
            staticTurretYaw = vehicle['vehicleType'].gun.staticTurretYaw
            if staticTurretYaw is None:
                vInfoVO = self._arenaDP.getVehicleInfo()
                yawLimits = vInfoVO.vehicleType.turretYawLimits
                if yawLimits:
                    self._PersonalEntriesPlugin__yawLimits = (math.degrees(yawLimits[0]), math.degrees(yawLimits[1]))


def _PersonalEntriesPlugin_setSettings(base, self):
    global _in_PersonalEntriesPlugin_setSettings
    _in_PersonalEntriesPlugin_setSettings = True
    base(self)
    _in_PersonalEntriesPlugin_setSettings = False


def _PersonalEntriesPlugin_updateSettings(base, self, diff):
    if g_minimap is not None and g_minimap.active:
        if g_minimap.opt_linesEnabled:
            if settings_constants.GAME.SHOW_VECTOR_ON_MAP in diff:
                diff[settings_constants.GAME.SHOW_VECTOR_ON_MAP] = DEFAULTS[settings_constants.GAME.SHOW_VECTOR_ON_MAP]
            if settings_constants.GAME.SHOW_SECTOR_ON_MAP in diff:
                diff[settings_constants.GAME.SHOW_SECTOR_ON_MAP] = DEFAULTS[settings_constants.GAME.SHOW_SECTOR_ON_MAP]
        if g_minimap.opt_circlesEnabled:
            if settings_constants.GAME.MINIMAP_DRAW_RANGE in diff:
                diff[settings_constants.GAME.MINIMAP_DRAW_RANGE] = DEFAULTS[settings_constants.GAME.MINIMAP_DRAW_RANGE]
            if settings_constants.GAME.MINIMAP_MAX_VIEW_RANGE in diff:
                diff[settings_constants.GAME.MINIMAP_MAX_VIEW_RANGE] = DEFAULTS[settings_constants.GAME.MINIMAP_MAX_VIEW_RANGE]
            if settings_constants.GAME.MINIMAP_VIEW_RANGE in diff:
                diff[settings_constants.GAME.MINIMAP_VIEW_RANGE] = DEFAULTS[settings_constants.GAME.MINIMAP_VIEW_RANGE]
            if settings_constants.GAME.MINIMAP_MIN_SPOTTING_RANGE in diff:
                diff[settings_constants.GAME.MINIMAP_MIN_SPOTTING_RANGE] = DEFAULTS[settings_constants.GAME.MINIMAP_MIN_SPOTTING_RANGE]
    base(self, diff)


def _PersonalEntriesPlugin_onVehicleFeedbackReceived(base, self, eventID, _, __):
    if g_minimap.active and g_minimap.opt_circlesEnabled:
        VISIBILITY.MAX_RADIUS = 1000
        base(self, eventID, _, __)
        VISIBILITY.MAX_RADIUS = 445
    else:
        base(self, eventID, _, __)



#
# Handlers/PostMortemControlMode
#

def _PostMortemControlMode_onMinimapClicked(base, self, worldPos):
    base(self, worldPos)
    if g_minimap.active and g_minimap.opt_minimapDeadSwitch:
        try:
            battle = getBattleApp()
            if not battle:
                return

            if isReplay() and not IS_DEVELOPMENT:
                return

            minDistance = None
            toID = None
            plugin = g_minimap.minimapComponent.getPlugin('vehicles')
            for vehicleID, entry in plugin._entries.iteritems():
                vData = avatar_getter.getArena().vehicles[vehicleID]
                if avatar_getter.getPlayerTeam() != vData['team'] or not vData['isAlive']:
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
                logging.getLogger('XVM/Battle/Minimap').exception('_PostMortemControlMode_onMinimapClicked')



#
# Handlers/SettingsCore
#

def _SettingsCore_getSetting(base, self, name):
    value = base(self, name)
    if g_minimap.active:
        if _in_PersonalEntriesPlugin_setSettings:
            if name in LINES_SETTINGS:
                if g_minimap.opt_linesEnabled:
                    value = DEFAULTS[name]
            elif name in CIRCLES_SETTINGS:
                if g_minimap.opt_circlesEnabled:
                    value = DEFAULTS[name]
        if _in_ArenaVehiclesPlugin_setSettings:
            if name in LABELS_SETTINGS:
                if g_minimap.opt_labelsEnabled:
                    value = DEFAULTS[name]
            elif name in HP_SETTINGS:
                if g_minimap.opt_healthPointsEnabled:
                    value = DEFAULTS[name]
    return value



#
# Minimap
#

class Minimap(object):

    enabled = True
    initialized = False
    guiType = 0
    battleType = 0
    opt_labelsEnabled = True
    opt_linesEnabled = True
    opt_circlesEnabled = True
    opt_minimapDeadSwitch = True
    opt_healthPointsEnabled = False
    viewPointID = 0
    minimapComponent = None
    entrySymbols = {}

    @property
    def active(self):
        return g_battle.xvm_battle_swf_initialized \
               and self.enabled  \
               and self.initialized  \
               and self.battleType not in UNSUPPORTED_BATTLE_TYPES \
               and self.guiType not in UNSUPPORTED_GUI_TYPES \

    def __init__(self):
        self._logger = logging.getLogger('XVM/Battle/Minimap')
        g_eventBus.addListener(XVM_EVENT.CONFIG_LOADED, self.onConfigLoaded)

    def init(self, minimapComponent):
        self.initialized = True

        avatar = BigWorld.player()
        arena = None
        if hasattr(avatar, 'arena'):
            arena = avatar.arena

        if arena is not None:
            self.guiType = arena.guiType
            self.battleType = arena.bonusType

        self.minimapComponent = minimapComponent
        self.entrySymbols = {}

    def fini(self):
        self.destroy()
        g_eventBus.removeListener(XVM_EVENT.CONFIG_LOADED, self.onConfigLoaded)

    def addEntry(self, entryID, symbol):
        self.entrySymbols[entryID] = symbol

    def delEntry(self, entryID):
        symbol = self.entrySymbols.pop(entryID)
        if symbol in XVM_ENTRY_SYMBOL_NAME.DEL_ENTRY_SYMBOLS:
            try:
                self.minimapComponent.invoke(entryID, 'xvm_delEntry')
            except Exception:
                self._logger.exception('delEntry')
 
    def destroy(self):
        if self.active:
            for entryID in self.entrySymbols.keys():
                self.delEntry(entryID)

        self.initialized = False
        self.minimapComponent = None

    def onConfigLoaded(self, *args, **kwargs):
        self.enabled = config.get('minimap/enabled', True)
        self.opt_labelsEnabled = config.get('minimap/labelsEnabled', True)
        self.opt_linesEnabled = config.get('minimap/linesEnabled', True)
        self.opt_circlesEnabled = config.get('minimap/circlesEnabled', True)
        self.opt_minimapDeadSwitch = config.get('battle/minimapDeadSwitch', True)
        self.opt_healthPointsEnabled = config.get('minimap/healthPointsEnabled', False)



#
# Initialization
#

def init():
    # minimapComponent
    overrideMethod(MinimapComponent, '_populate')(_MinimapComponent_populate)
    overrideMethod(MinimapComponent, '_dispose')(_MinimapComponent_dispose)
    overrideMethod(MinimapComponent, 'addEntry')(_MinimapComponent_addEntry)
    overrideMethod(MinimapComponent, 'delEntry')(_MinimapComponent_delEntry)
    
    # arenaVehiclesPlugin
    overrideMethod(ArenaVehiclesPlugin, '_ArenaVehiclesPlugin__switchToVehicle')(_ArenaVehiclesPlugin__switchToVehicle)
    overrideMethod(ArenaVehiclesPlugin, 'setSettings')(_ArenaVehiclesPlugin_setSettings)
    overrideMethod(ArenaVehiclesPlugin, 'updateSettings')(_ArenaVehiclesPlugin_updateSettings)
    overrideMethod(ArenaVehiclesPlugin, '_ArenaVehiclesPlugin__showFeatures')(_ArenaVehiclesPlugin__showFeatures)
    overrideMethod(ArenaVehiclesPlugin, '_ArenaVehiclesPlugin__showMinimapHP')(_ArenaVehiclesPlugin__showMinimapHP)

    # personalEntriesPlugin
    overrideMethod(PersonalEntriesPlugin, '_PersonalEntriesPlugin__updateViewPointEntry')(_PersonalEntriesPlugin__updateViewPointEntry)
    overrideMethod(PersonalEntriesPlugin, 'start')(_PersonalEntriesPlugin_start)
    overrideMethod(PersonalEntriesPlugin, 'setSettings')(_PersonalEntriesPlugin_setSettings)
    overrideMethod(PersonalEntriesPlugin, 'updateSettings')(_PersonalEntriesPlugin_updateSettings)
    overrideMethod(PersonalEntriesPlugin, '_onVehicleFeedbackReceived')(_PersonalEntriesPlugin_onVehicleFeedbackReceived)

    # postMortemControlMode
    overrideMethod(PostMortemControlMode, 'onMinimapClicked')(_PostMortemControlMode_onMinimapClicked)

    # settingsCore
    overrideMethod(SettingsCore, 'getSetting')(_SettingsCore_getSetting)

    global g_minimap
    g_minimap = Minimap()



def fini():
    global g_minimap
    g_minimap.fini()
    g_minimap = None
