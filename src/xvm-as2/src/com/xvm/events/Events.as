/**
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */

class com.xvm.events.Events
{
    // XVM EVENTS
    public static var E_CONFIG_LOADED:String = "config_loaded";
    public static var E_STAT_LOADED:String = "stat_loaded";
    public static var E_PP_ALT_MODE:String = "pp_alt_mode";
    public static var E_MM_ALT_MODE:String = "mm_alt_mode";
    public static var E_MM_ZOOM:String = "mm_zoom";
    public static var E_STEREOSCOPE_TOGGLED:String = "stereoscope_toggled";
    public static var E_PLAYER_DEAD:String = "player_dead";
    public static var E_SELF_DEAD:String = "self_dead";
    public static var E_UPDATE_STAGE:String = "update_stage";
    public static var E_LEFT_PANEL_SIZE_ADJUSTED:String = "left_panel_size_adjusted";
    public static var E_RIGHT_PANEL_SIZE_ADJUSTED:String = "right_panel_size_adjusted";
    public static var E_MOVING_STATE_CHANGED:String = "moving_state_changed";
    public static var E_MODULE_DESTROYED:String = "module_destroyed";
    public static var E_MODULE_REPAIRED:String = "module_repaired";
    public static var E_BATTLE_LABEL_KEY_MODE:String = "battle_label_key_mode";
    public static var E_PLAYERS_HP_CHANGED:String = "players_hp_changed";
    public static var E_BATTLE_STATE_CHANGED:String = "battle_state_changed";

    // XMQP EVENTS
    public static var XMQP_HOLA:String = "xmqp_hola";
    public static var XMQP_FIRE:String = "xmqp_fire";
    public static var XMQP_VEHICLE_TIMER:String = "xmqp_vehicle_timer";
    public static var XMQP_DEATH_ZONE_TIMER:String = "xmqp_death_zone_timer";
    public static var XMQP_SPOTTED:String = "xmqp_spotted";
    public static var XMQP_MINIMAP_CLICK:String = "xmqp_minimap_click";

    // MINIMAP EVENTS
    public static var MM_ENTRY_INITED:String = "MM_ENTRY_INITED";
    public static var MM_ENTRY_UPDATED:String = "MM_ENTRY_UPDATED";
    public static var MM_ENTRY_NAME_UPDATED:String = "MM_ENTRY_NAME_UPDATED";
    public static var MM_CAMERA_UPDATED:String = "MM_CAMERA_UPDATED";
    public static var MM_ENTRY_LOST:String = "MM_ENTRY_LOST";
    public static var MM_RESPAWNED:String = "MM_RESPAWNED";
    public static var MM_REFRESH:String = "MM_REFRESH";
    public static var MM_SET_STRATEGIC_POS:String = "MM_SET_STRATEGIC_POS";
}
