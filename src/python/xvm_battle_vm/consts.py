"""
SPDX-License-Identifier: GPL-3.0-or-later
Copyright (c) 2013-2024 XVM Contributors
"""

#
# Imports
#

# BigWorld
import constants

# XFW
from xfw import *



#
# Constants
#

class DAMAGE_TYPE(object):
    FROM_UNKNOWN = 0
    FROM_ALLY = 1
    FROM_ENEMY = 2
    FROM_SQUAD = 3
    FROM_PLAYER = 4


class XVM_VM_COMMAND(object):
    LOG = "xfw.log"
    INITIALIZED = "initialized"


class BC(object):
    setVehiclesData = 'BC_setVehiclesData'
    addVehiclesInfo = 'BC_addVehiclesInfo'
    updateVehiclesData = 'BC_updateVehiclesData'
    updateVehicleStatus = 'BC_updateVehicleStatus'
    updatePlayerStatus = 'BC_updatePlayerStatus'
    setFrags = 'BC_setFrags'
    updateVehiclesStat = 'BC_updateVehiclesStat'
    updatePersonalStatus = 'BC_updatePersonalStatus'
    setUserTags = 'BC_setUserTags'
    updateUserTags = 'BC_updateUserTags'
    setPersonalStatus = 'BC_setPersonalStatus'
    updateInvitationsStatuses = 'BC_updateInvitationsStatuses'


class AS_SYMBOLS(object):
    AS_VEHICLE_MARKER = 'com.xvm.vehiclemarkers.ui::XvmVehicleMarker'


UNSUPPORTED_GUI_TYPES = [
    constants.ARENA_GUI_TYPE.EVENT_BATTLES,
    constants.ARENA_GUI_TYPE.BATTLE_ROYALE,
    constants.ARENA_GUI_TYPE.MAPS_TRAINING,
    constants.ARENA_GUI_TYPE.RTS,
    constants.ARENA_GUI_TYPE.RTS_TRAINING,
    constants.ARENA_GUI_TYPE.RTS_BOOTCAMP,
    constants.ARENA_GUI_TYPE.COMP7,
    33, # constants.ARENA_GUI_TYPE.TOURNAMENT_COMP7 (WG 1.24.1)
    34, # constants.ARENA_GUI_TYPE.TRAINING_COMP7 (WG 1.24.1)
    # constants.ARENA_GUI_TYPE.STORY_MODE_ONBOARDING (WG 1.25 Newbie tutorial)
    # constants.ARENA_GUI_TYPE.STORY_MODE (Lesta only)
    100,
    101, # constants.ARENA_GUI_TYPE.HALLOWEEN (WG 1.25 PvE event)
    102, # constants.ARENA_GUI_TYPE.HALLOWEEN_DEFENCE (WG 1.25 PvE event)
    104,  # constants.ARENA_GUI_TYPE.STORY_MODE_REGULAR (WG 1.25 PvE event)
    300, # constants.ARENA_GUI_TYPE.COSMIC_EVENT (Lesta 1.25.0.0)
    301, # constants.ARENA_GUI_TYPE.WHITE_TIGER (Lesta 1.30.0.0 WT: Hyperion copycat)
]

UNSUPPORTED_BATTLE_TYPES = [
    constants.ARENA_BONUS_TYPE.EVENT_BATTLES,
    constants.ARENA_BONUS_TYPE.COMP7
]
