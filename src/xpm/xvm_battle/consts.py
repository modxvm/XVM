""" XVM (c) www.modxvm.com 2013-2016 """

#####################################################################
# constants

# Shared commands

class XVM_BATTLE_COMMAND(object):
    REQUEST_BATTLE_GLOBAL_DATA = "xvm_battle.request_battle_global_data"
    XMQP_INIT = "xvm_battle.xmqp_init"
    BATTLE_CTRL_SET_VEHICLE_DATA = "xvm_battle.battle_ctrl_set_vehicle_data"
    CAPTURE_BAR_GET_BASE_NUM_TEXT = "xvm_battle.capture_bar_get_base_num_text"
    SET_MINIMAP_MAX_SIZE_INDEX = "xvm_battle.set_minimap_max_size_index"
    MINIMAP_CLICK = "xvm_battle.minimap_click"

    AS_RESPONSE_BATTLE_GLOBAL_DATA = "xvm.as.response_battle_global_data"
    AS_XMQP_EVENT = "xvm.as.as_xmqp_event"
    AS_UPDATE_PLAYER_STATE = "xvm.as.update_player_state"
    AS_UPDATE_DEVICE_STATE = "xvm.as.update_device_state"
    AS_TEAMS_HP_CHANGED = "xvm.as.teams_hp_changed"
    AS_SNIPER_CAMERA = "xvm.as.sniper_camera"
    AS_AIM_OFFSET_UPDATE = "xvm.as.aim_offset_update"
    AS_ON_TARGET_CHANGED = "xvm.as.on_target_changed"
    AS_MOVING_STATE_CHANGED = "xvm.as.as_moving_state_changed"
    AS_STEREOSCOPE_TOGGLED = "xvm.as.as_stereoscope_toggled"

# Markers only commands

class XVM_VM_COMMAND(object):
    # Flash -> Python
    LOG = "xfw.log"
    INITIALIZED = "initialized"
    AS_CMD_RESPONSE = "xvm_vm.as.cmd_response"

# Battle events

class XVM_BATTLE_EVENT(object):
    ARENA_INFO_INVALIDATED = "arena_info_invalidated"
    XMQP_CONNECTED = 'xvm_battle.xmqp_connected'
    XMQP_MESSAGE = 'xvm_battle.xmqp_message'

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
    HITLOG              = 0x00010000
    ALL_VINFO           = VEHICLE_STATUS | SQUAD_INDEX | FRAGS # | PLAYER_STATUS
    ALL_VSTATS          = FRAGS
    ALL_ENTITY          = CUR_HEALTH | MAX_HEALTH | MARKS_ON_GUN
    ALL                 = 0x0000FFFF

# Spotted statuses

class SPOTTED_STATUS(object):
    NEVER_SEEN = 'neverSeen'
    SPOTTED = 'spotted'
    LOST = 'lost'
    DEAD = 'dead'

class INT_CD(object):
    STEREOSCOPE = 1273
