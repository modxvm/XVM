""" XVM (c) www.modxvm.com 2013-2016 """

#####################################################################
# constants

class XVM_BATTLE_COMMAND(object):
    REQUEST_BATTLE_GLOBAL_DATA = "xvm.request_battle_global_data"
    BATTLE_CTRL_SET_VEHICLE_DATA = "xvm_battle.battle_ctrl_set_vehicle_data"
    CAPTURE_BAR_GET_BASE_NUM_TEXT = "xvm_battle.capture_bar_get_base_num_text"
    MINIMAP_CLICK = "xvm.minimap_click"

    AS_RESPONSE_BATTLE_GLOBAL_DATA = "xvm.as.response_battle_global_data"
    AS_UPDATE_PLAYER_STATE = "xvm.as.update_player_state"
    AS_TEAMS_HP_CHANGED = "xvm.as.teams_hp_changed"
    AS_SNIPER_CAMERA = "xvm.as.sniper_camera"
    AS_AIM_OFFSET_UPDATE = "xvm.as.aim_offset_update"

class XVM_VM_COMMAND(object):
    # Flash -> Python
    INITIALIZE = "init"
    LOG = "log"
