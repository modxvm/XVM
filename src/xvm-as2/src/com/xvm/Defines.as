/**
 * ...
 * @author sirmax2
 */
class com.xvm.Defines
{
    // Global versions
    public static var XVM_VERSION:String = "5.0.1";
    public static var XVM_INTRO:String = "www.modxvm.com";
    public static var WOT_VERSION:String = "0.8.10";
    public static var CONFIG_VERSION:String = "5.0.0";
    public static var EDITOR_VERSION:String = "0.60";

    // Locale
    public static var LOCALE_AUTO_DETECTION:String = "auto";

    // res_mods/xvm/
    public static var XVM_ROOT:String = "../../../xvm/";

    // res_mods/xvm/res/
    public static var XVMRES_ROOT:String = XVM_ROOT + "res/";

    // res_mods/xvm/res/ (for <img> tag)
    public static var XVMRES_IMG_ROOT:String = "../xvm/res/";

    // res_mods/xvm/res/SixthSense.png
    public static var SIXTH_SENSE_IMG:String = XVMRES_ROOT + "SixthSense.png";

    // res_mods/xvm/xvm.xc
    public static var CONFIG_FILE_NAME:String = "xvm.xc";
    // res_mods/x.x.x/gui/flash/XVM.xvmconf
    public static var CONFIG_FILE_NAME_XVMCONF:String = "XVM.xvmconf";

    // Settings keys
    public static var SETTINGS_WIDGETS:String = "widgets";
    public static var SETTINGS_WIDGETSSETTINGSDIALOG:String = "widgets.SettingsDialog";

    // Default settings
    public static  var DEFAULT_SETTINGS_WIDGETS = [];
    public static  var DEFAULT_SETTINGS_WIDGETSSETTINGSDIALOG = { x: 400, y: 150 };

    // Default path to vehicle icons (relative)
    public static var WG_CONTOUR_ICON_PATH:String = "../maps/icons/vehicle/contour/";

    // Team
    public static var TEAM_ALLY:Number = 1;
    public static var TEAM_ENEMY:Number = 2;

    // Field Type
    public static var FIELDTYPE_NONE:Number = 0;
    public static var FIELDTYPE_NICK:Number = 1;
    public static var FIELDTYPE_VEHICLE:Number = 2;

    // Dead State
    public static var DEADSTATE_NONE:Number = 0;
    public static var DEADSTATE_ALIVE:Number = 1;
    public static var DEADSTATE_DEAD:Number = 2;

    // Dynamic color types
    public static var DYNAMIC_COLOR_EFF:Number = 1;
    public static var DYNAMIC_COLOR_RATING:Number = 2;
    public static var DYNAMIC_COLOR_KB:Number = 3;
    public static var DYNAMIC_COLOR_HP:Number = 4;
    public static var DYNAMIC_COLOR_HP_RATIO:Number = 5;
    public static var DYNAMIC_COLOR_TBATTLES:Number = 6;
    public static var DYNAMIC_COLOR_TDB:Number = 7;
    public static var DYNAMIC_COLOR_TDV:Number = 8;
    public static var DYNAMIC_COLOR_TFB:Number = 9;
    public static var DYNAMIC_COLOR_TSB:Number = 10;
    public static var DYNAMIC_COLOR_E:Number = 11;
    public static var DYNAMIC_COLOR_WN:Number = 12;
    public static var DYNAMIC_COLOR_X:Number = 13;
    public static var DYNAMIC_COLOR_AVGLVL:Number = 14;

    // Dynamic alpha types
    public static var DYNAMIC_ALPHA_EFF:Number = 1;
    public static var DYNAMIC_ALPHA_RATING:Number = 2;
    public static var DYNAMIC_ALPHA_KB:Number = 3;
    public static var DYNAMIC_ALPHA_HP:Number = 4;
    public static var DYNAMIC_ALPHA_HP_RATIO:Number = 5;
    public static var DYNAMIC_ALPHA_TBATTLES:Number = 6;
    public static var DYNAMIC_ALPHA_TDB:Number = 7;
    public static var DYNAMIC_ALPHA_TDV:Number = 8;
    public static var DYNAMIC_ALPHA_TFB:Number = 9;
    public static var DYNAMIC_ALPHA_TSB:Number = 10;
    public static var DYNAMIC_ALPHA_E:Number = 11;
    public static var DYNAMIC_ALPHA_WN:Number = 12;
    public static var DYNAMIC_ALPHA_X:Number = 13;
    public static var DYNAMIC_ALPHA_AVGLVL:Number = 14;

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

    // UI Colors
    public static var UICOLOR_DEFAULT = 0xC9C9B6;
    public static var UICOLOR_DEFAULT2 = 0x969687;
    public static var UICOLOR_GOLD = 0xFFC133;
    public static var UICOLOR_BLUE = 0x408CCF;

    // Widgets
    public static var WIDGET_MODE_HIDE =     0x01;
    public static var WIDGET_MODE_1 =        0x02;
    public static var WIDGET_MODE_2 =        0x04;
    public static var WIDGET_MODE_DETAILED = 0x08;
    public static var WIDGET_MODES_ALL = WIDGET_MODE_HIDE | WIDGET_MODE_1 | WIDGET_MODE_2 | WIDGET_MODE_DETAILED;
}
