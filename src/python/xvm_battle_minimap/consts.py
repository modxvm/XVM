"""
SPDX-License-Identifier: GPL-3.0-or-later
Copyright (c) 2013-2025 XVM Contributors
"""

#
# Imports
#

# BigWorld
from account_helpers.settings_core import settings_constants
import constants



#
# Constants
#

UNSUPPORTED_GUI_TYPES = [
    constants.ARENA_GUI_TYPE.EPIC_BATTLE,
    constants.ARENA_GUI_TYPE.EVENT_BATTLES,
    constants.ARENA_GUI_TYPE.BATTLE_ROYALE,
    constants.ARENA_GUI_TYPE.RTS,
    constants.ARENA_GUI_TYPE.RTS_TRAINING,
    constants.ARENA_GUI_TYPE.RTS_BOOTCAMP,
    constants.ARENA_GUI_TYPE.COMP7,
    31, # constants.ARENA_GUI_TYPE.WINBACK (removed in Lesta since 1.29)
    33,  # constants.ARENA_GUI_TYPE.TOURNAMENT_COMP7 (WG 1.24.1)
    34,  # constants.ARENA_GUI_TYPE.TRAINING_COMP7 (WG 1.24.1)
    # constants.ARENA_GUI_TYPE.STORY_MODE_ONBOARDING (WG 1.25 Newbie tutorial)
    # constants.ARENA_GUI_TYPE.STORY_MODE (Lesta only)
    100,
    101, # constants.ARENA_GUI_TYPE.HB_OFFENCE (Lesta PvE event)
    102, # constants.ARENA_GUI_TYPE.HB_DEFENCE (Lesta PvE event)
    104, # constants.ARENA_GUI_TYPE.STORY_MODE_REGULAR (WG 1.25 PvE event)
    200, # constants.ARENA_GUI_TYPE.FALL_TANKS (WG 1.28.1.0)
    300, # constants.ARENA_GUI_TYPE.COSMIC_EVENT (Lesta 1.25.0.0)
]

UNSUPPORTED_BATTLE_TYPES = [
    constants.ARENA_BONUS_TYPE.EVENT_BATTLES,
    constants.ARENA_BONUS_TYPE.COMP7
]

class XVM_ENTRY_SYMBOL_NAME(object):
    VEHICLE = 'com.xvm.battle.shared.minimap.entries.vehicle::UI_VehicleEntry'
    VIEW_POINT = 'com.xvm.battle.shared.minimap.entries.personal::UI_ViewPointEntry'
    DEAD_POINT = 'com.xvm.battle.shared.minimap.entries.personal::UI_DeadPointEntry'
    VIDEO_CAMERA = 'com.xvm.battle.shared.minimap.entries.personal::UI_VideoCameraEntry'
    ARCADE_CAMERA = 'com.xvm.battle.shared.minimap.entries.personal::UI_ArcadeCameraEntry'
    STRATEGIC_CAMERA = 'com.xvm.battle.shared.minimap.entries.personal::UI_StrategicCameraEntry'
    # Renamed ARCADE_CAMERA and STRATEGIC_CAMERA entries for Lesta since 1.28.0.0
    DIRECTION_ENTRY = 'com.xvm.battle.shared.minimap.entries.personal::UI_DirectionEntry'
    RECTANGLE_AREA = 'com.xvm.battle.shared.minimap.entries.personal::UI_RectangleAreaMinimapEntry'
    VIEW_RANGE_CIRCLES = 'com.xvm.battle.shared.minimap.entries.personal::UI_ViewRangeCirclesEntry'
    MARK_CELL = 'com.xvm.battle.shared.minimap.entries.personal::UI_CellFlashEntry'
    DEL_ENTRY_SYMBOLS = [VEHICLE, VIEW_POINT, DEAD_POINT, VIDEO_CAMERA,
                         ARCADE_CAMERA, STRATEGIC_CAMERA, DIRECTION_ENTRY,
                         RECTANGLE_AREA, VIEW_RANGE_CIRCLES, MARK_CELL]


class ADDITIONAL_ENTRY_SYMBOL_NAME:
    ARCADE_CAMERA = 'ArcadeCameraEntry'
    STRATEGIC_CAMERA = 'StrategicCameraEntry'
    DIRECTION_ENTRY = 'DirectionEntry'
    RECTANGLE_AREA = 'RectangleAreaMinimapEntry'

CIRCLES_SETTINGS = (
    settings_constants.GAME.MINIMAP_DRAW_RANGE,
    settings_constants.GAME.MINIMAP_MAX_VIEW_RANGE,
    settings_constants.GAME.MINIMAP_VIEW_RANGE,
    settings_constants.GAME.SHOW_VEH_MODELS_ON_MAP,
    settings_constants.GAME.MINIMAP_MIN_SPOTTING_RANGE
)

LINES_SETTINGS = (
    settings_constants.GAME.SHOW_VECTOR_ON_MAP,
    settings_constants.GAME.SHOW_SECTOR_ON_MAP
)

LABELS_SETTINGS = (
    settings_constants.GAME.SHOW_VEH_MODELS_ON_MAP
)

HP_SETTINGS = (
    settings_constants.GAME.SHOW_VEHICLE_HP_IN_MINIMAP
)

DEFAULTS = {
    settings_constants.GAME.SHOW_VECTOR_ON_MAP: False,
    settings_constants.GAME.SHOW_SECTOR_ON_MAP: True,
    settings_constants.GAME.MINIMAP_DRAW_RANGE: True,
    settings_constants.GAME.MINIMAP_MAX_VIEW_RANGE: True,
    settings_constants.GAME.MINIMAP_VIEW_RANGE: True,
    settings_constants.GAME.SHOW_VEH_MODELS_ON_MAP: False,
    settings_constants.GAME.MINIMAP_MIN_SPOTTING_RANGE: False,
    settings_constants.GAME.SHOW_VEHICLE_HP_IN_MINIMAP: True,
}
