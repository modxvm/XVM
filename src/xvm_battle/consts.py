'''
SPDX-License-Identifier: GPL-3.0-or-later
Copyright (c) 2013-2025 XVM Contributors
'''

#
# Imports
#

import constants



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
    31, # constants.ARENA_GUI_TYPE.WINBACK (removed in Lesta since 1.29)
    32, # constants.ARENA_GUI_TYPE.BOB (Lesta 1.32)
    33, # constants.ARENA_GUI_TYPE.TOURNAMENT_COMP7 (WG 1.24.1)
    34, # constants.ARENA_GUI_TYPE.TRAINING_COMP7 (WG 1.24.1)
    # constants.ARENA_GUI_TYPE.STORY_MODE_ONBOARDING (WG 1.25 Newbie tutorial)
    # constants.ARENA_GUI_TYPE.STORY_MODE (Lesta only)
    100,
    101, # constants.ARENA_GUI_TYPE.HB_OFFENCE (Lesta PvE event)
    102, # constants.ARENA_GUI_TYPE.LAST_STAND (WG) | constants.ARENA_GUI_TYPE.HB_DEFENCE (Lesta PvE event)
    104, # constants.ARENA_GUI_TYPE.STORY_MODE_REGULAR (WG 1.25 PvE event)
    200, # constants.ARENA_GUI_TYPE.FALL_TANKS (WG 1.28.1.0)
    300, # constants.ARENA_GUI_TYPE.COSMIC_EVENT (Lesta 1.25.0.0)
]

class XVM_BATTLE_COMMAND(object):
    REQUEST_BATTLE_GLOBAL_DATA = 'xvm_battle.request_battle_global_data'
    XMQP_INIT = 'xvm_battle.xmqp_init'
    BATTLE_CTRL_SET_VEHICLE_DATA = 'xvm_battle.battle_ctrl_set_vehicle_data'
    CAPTURE_BAR_GET_BASE_NUM_TEXT = 'xvm_battle.capture_bar_get_base_num_text'
    MINIMAP_CLICK = 'xvm_battle.minimap_click'

    AS_RESPONSE_BATTLE_GLOBAL_DATA = 'xvm.as.response_battle_global_data'
    AS_XMQP_EVENT = 'xvm.as.as_xmqp_event'
    AS_UPDATE_PLAYER_STATE = 'xvm.as.update_player_state'
    AS_UPDATE_DEVICE_STATE = 'xvm.as.update_device_state'
    AS_SNIPER_CAMERA = 'xvm.as.sniper_camera'
    AS_AIM_OFFSET_UPDATE = 'xvm.as.aim_offset_update'
    AS_ON_TARGET_CHANGED = 'xvm.as.on_target_changed'
    AS_MOVING_STATE_CHANGED = 'xvm.as.as_moving_state_changed'
    AS_STEREOSCOPE_TOGGLED = 'xvm.as.as_stereoscope_toggled'
    AS_CHANGING_SHELL = 'xvm.as.as_changing_shell'


class XVM_BATTLE_EVENT(object):
    ARENA_INFO_INVALIDATED = 'arena_info_invalidated'
    XMQP_CONNECTED = 'xvm_battle.xmqp_connected'
    XMQP_MESSAGE = 'xvm_battle.xmqp_message'


class INV(object):
    NONE                = 0x00000000
    VEHICLE_STATUS      = 0x00000001 # ready, alive, not_available, stop_respawn
    # PLAYER_STATUS       = 0x00000002 # isActionDisabled, isSelected, isSquadMan, isSquadPersonal, isTeamKiller, isVoipDisabled
    CREW_ACTIVE         = 0x00000004
    SQUAD_INDEX         = 0x00000008
    RANK_LEVEL          = 0x00000010
    CUR_HEALTH          = 0x00000020
    MAX_HEALTH          = 0x00000040
    MARKS_ON_GUN        = 0x00000080
    SPOTTED_STATUS      = 0x00000100
    FRAGS               = 0x00000200
    TURRET              = 0x00000400
    DAMAGE_CAUSED       = 0x00010000
    ALL_VINFO           = VEHICLE_STATUS | SQUAD_INDEX | RANK_LEVEL | FRAGS # | PLAYER_STATUS
    ALL_VSTATS          = FRAGS
    ALL_ENTITY          = CUR_HEALTH | MAX_HEALTH | MARKS_ON_GUN | CREW_ACTIVE | TURRET
    ALL                 = 0x0000FFFF


class SPOTTED_STATUS(object):
    NEVER_SEEN = 'neverSeen'
    SPOTTED = 'spotted'
    LOST = 'lost'
    DEAD = 'dead'


class INT_CD(object):
    STEREOSCOPE = {17913, 17657, 17401}
