/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
class com.xvm.Defines
{
    // Paths relative to /res_mods/x.x.x/gui/scaleform/
    // res_mods/mods/shared_resources/xvm/
    public static var XVM_ROOT:String = "../../../mods/shared_resources/xvm/";

    // res_mods/mods/shared_resources/xvm/res/
    public static var XVMRES_ROOT:String = XVM_ROOT + "res/";

    // Paths relative to /res_mods/0.x.x/
    // res_mods/configs/xvm/ (for <img> tag))
    public static var XVM_IMG_CFG_ROOT:String = "../configs/xvm/";

    // Paths relative to /res_mods/0.x.x/
    // res_mods/mods/shared_resources/xvm/ (for <img> tag))
    public static var XVM_IMG_RES_ROOT:String = "../mods/shared_resources/xvm/";

    // Default path to vehicle icons (relative)
    public static var WG_CONTOUR_ICON_PATH:String = "../maps/icons/vehicle/contour/";

    // Team
    public static var TEAM_ALLY:Number = 1;
    public static var TEAM_ENEMY:Number = 2;

    // Field Type
    public static var FIELDTYPE_NICK:Number = 1;
    public static var FIELDTYPE_VEHICLE:Number = 2;
    public static var FIELDTYPE_FRAGS:Number = 3;

    // Dynamic color types
    public static var DYNAMIC_COLOR_EFF:Number = 1;
    public static var DYNAMIC_COLOR_WINRATE:Number = 2;
    public static var DYNAMIC_COLOR_KB:Number = 3;
    public static var DYNAMIC_COLOR_HP:Number = 4;
    public static var DYNAMIC_COLOR_HP_RATIO:Number = 5;
    public static var DYNAMIC_COLOR_TBATTLES:Number = 6;
    public static var DYNAMIC_COLOR_TDB:Number = 7;
    public static var DYNAMIC_COLOR_TDV:Number = 8;
    public static var DYNAMIC_COLOR_TFB:Number = 9;
    public static var DYNAMIC_COLOR_TSB:Number = 10;
    public static var DYNAMIC_COLOR_WN6:Number = 11;
    public static var DYNAMIC_COLOR_WN8:Number = 12;
    public static var DYNAMIC_COLOR_WGR:Number = 13;
    public static var DYNAMIC_COLOR_X:Number = 14;
    public static var DYNAMIC_COLOR_AVGLVL:Number = 15;
    public static var DYNAMIC_COLOR_SPOTTED:Number = 16;
    public static var DYNAMIC_COLOR_WINCHANCE:Number = 17;

    // Dynamic alpha types
    public static var DYNAMIC_ALPHA_EFF:Number = 1;
    public static var DYNAMIC_ALPHA_WINRATE:Number = 2;
    public static var DYNAMIC_ALPHA_KB:Number = 3;
    public static var DYNAMIC_ALPHA_HP:Number = 4;
    public static var DYNAMIC_ALPHA_HP_RATIO:Number = 5;
    public static var DYNAMIC_ALPHA_TBATTLES:Number = 6;
    public static var DYNAMIC_ALPHA_TDB:Number = 7;
    public static var DYNAMIC_ALPHA_TDV:Number = 8;
    public static var DYNAMIC_ALPHA_TFB:Number = 9;
    public static var DYNAMIC_ALPHA_TSB:Number = 10;
    public static var DYNAMIC_ALPHA_WN6:Number = 11;
    public static var DYNAMIC_ALPHA_WN8:Number = 12;
    public static var DYNAMIC_ALPHA_WGR:Number = 13;
    public static var DYNAMIC_ALPHA_X:Number = 14;
    public static var DYNAMIC_ALPHA_AVGLVL:Number = 15;
    public static var DYNAMIC_ALPHA_SPOTTED:Number = 16;

    // Damage flag at Xvm.as: updateHealth
    public static var FROM_UNKNOWN:Number = 0;
    public static var FROM_ALLY:Number = 1;
    public static var FROM_ENEMY:Number = 2;
    public static var FROM_SQUAD:Number = 3;
    public static var FROM_PLAYER:Number = 4;

    // Text direction
    public static var DIRECTION_DOWN:Number = 1;
    public static var DIRECTION_UP:Number = 2;

    // Text insert order
    public static var INSERTORDER_BEGIN:Number = DIRECTION_DOWN;
    public static var INSERTORDER_END:Number = DIRECTION_UP;

    // Load states
    public static var LOADSTATE_NONE:Number = 1;    // not loaded
    public static var LOADSTATE_LOADING:Number = 2; // loading
    public static var LOADSTATE_DONE:Number = 3;    // statistics loaded
    public static var LOADSTATE_UNKNOWN:Number = 4; // unknown vehicle in FogOfWar

    // Level in roman numerals
    public static var ROMAN_LEVEL:Array = [ "I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX", "X" ];

    // Default colors
    public static var C_ALLY_ALIVE = "0x96FF00";
    public static var C_ENEMY_ALIVE = "0xF50800";

    // Moving state
    public static var MOVING_STATE_STOPPED = 0x01;
    public static var MOVING_STATE_MOVING = 0x02;
    public static var MOVING_STATE_ALL = MOVING_STATE_STOPPED | MOVING_STATE_MOVING;

    // Events
    public static var E_CONFIG_LOADED = "config_loaded";
    public static var E_STAT_LOADED = "stat_loaded";
    public static var E_PP_ALT_MODE = "pp_alt_mode";
    public static var E_MM_ALT_MODE = "mm_alt_mode";
    public static var E_MM_ZOOM = "mm_zoom";
    public static var E_STEREOSCOPE_TOGGLED = "stereoscope_toggled";
    public static var E_PLAYER_DEAD = "player_dead";
    public static var E_SELF_DEAD = "self_dead";
    public static var E_UPDATE_STAGE = "update_stage";
    public static var E_LEFT_PANEL_SIZE_ADJUSTED = "left_panel_size_adjusted";
    public static var E_RIGHT_PANEL_SIZE_ADJUSTED = "right_panel_size_adjusted";
    public static var E_MOVING_STATE_CHANGED = "moving_state_changed";
    public static var E_MODULE_DESTROYED = "module_destroyed";
    public static var E_MODULE_REPAIRED = "module_repaired";

    // BattleTypes
    public static var BATTLE_TYPE_UNKNOWN:Number = 0;
    public static var BATTLE_TYPE_REGULAR:Number = 1;
    public static var BATTLE_TYPE_TRAINING:Number = 2;
    public static var BATTLE_TYPE_COMPANY:Number = 3;
    public static var BATTLE_TYPE_TOURNAMENT:Number = 4;
    public static var BATTLE_TYPE_CLAN:Number = 5;
    public static var BATTLE_TYPE_TUTORIAL:Number = 6;
    public static var BATTLE_TYPE_CYBERSPORT:Number = 7;
    public static var BATTLE_TYPE_HISTORICAL:Number = 8;
    public static var BATTLE_TYPE_EVENT_BATTLES:Number = 9;
    public static var BATTLE_TYPE_SORTIE:Number = 10;
    public static var BATTLE_TYPE_FORT_BATTLE:Number = 11;
    public static var BATTLE_TYPE_RATED_CYBERSPORT:Number = 12;

    // alive/dead flags
    public static var ALIVE_FLAG_ALIVE:Number = 0x01;
    public static var ALIVE_FLAG_DEAD:Number  = 0x02;
    public static var ALIVE_FLAG_ANY:Number   = 0x03;

    // Spotted status flags
    public static var SPOTTED_STATUS_NEVER_SEEN:Number = 0x01;
    public static var SPOTTED_STATUS_SPOTTED:Number =    0x02;
    public static var SPOTTED_STATUS_LOST:Number =       0x04;
    public static var SPOTTED_STATUS_ANY:Number =        0x06;
}
