/**
 * XVM
 * @author Maxim Schedriviy <m.schedriviy@gmail.com>
 */
package com.xvm
{
    public class Defines
    {
        // Global versions
        public static const XVM_VERSION:String = "5.0.2-test3";
        public static const XVM_INTRO:String = "www.modxvm.com";
        public static const WOT_VERSION:String = "0.8.10";
        public static const CONFIG_VERSION:String = "5.0.1";
        public static const EDITOR_VERSION:String = "0.68";

        // Locale
        public static const LOCALE_AUTO_DETECTION:String = "auto";

        // Region
        public static const REGION_AUTO_DETECTION:String = "auto";

        // res_mods/xvm/
        public static const XVM_ROOT:String = "../../../xvm/";

        // res_mods/xvm/res/
        public static const XVMRES_ROOT:String = XVM_ROOT + "res/";

        // res_mods/xvm/mods/
        public static const XVMMODS_ROOT:String = XVM_ROOT + "mods/";

        // res_mods/xvm/res/ (for <img> tag)
        public static const XVMRES_IMG_ROOT:String = "../res/";

        // res_mods/xvm/res/SixthSense.png
        public static const SIXTH_SENSE_IMG:String = XVMRES_ROOT + "SixthSense.png";

        // res_mods/xvm/xvm.xc
        public static const CONFIG_FILE_NAME:String = "xvm.xc";

        // Settings keys
        public static const SETTINGS_WIDGETS:String = "widgets";
        public static const SETTINGS_WIDGETSSETTINGSDIALOG:String = "widgets.SettingsDialog";

        // Default settings
        public static const DEFAULT_SETTINGS_WIDGETS:Vector.<String> = new Vector.<String>();
        public static const DEFAULT_SETTINGS_WIDGETSSETTINGSDIALOG:Object = { x: 400, y: 150 };

        // Default path to vehicle icons (relative)
        public static const WG_CONTOUR_ICON_PATH:String = "../maps/icons/vehicle/contour/";
        public static const WG_CONTOUR_ICON_NOIMAGE:String = WG_CONTOUR_ICON_PATH + "noImage.png";

        // Events
        public static const E_CONFIG_LOADED:String = "config_loaded";
        public static const E_SET_INFO:String = "set_info";
        public static const E_LOCALE_LOADED:String = "locale_loaded";


        // UI Colors
        public static const UICOLOR_LABEL:uint = 0xA19D95;
        public static const UICOLOR_VALUE:uint = 0xC9C9B6;
        public static const UICOLOR_LIGHT:uint = 0xFDF4CE;
        public static const UICOLOR_DISABLED:uint = 0x4C4A47;
        public static const UICOLOR_GOLD:uint = 0xFFC133;
        public static const UICOLOR_GOLD2:uint = 0xCBAD78;
        public static const UICOLOR_BLUE:uint = 0x408CCF;

        // ColorPalette
        public static const C_WHITE:String = "0xFCFCFC";
        public static const C_RED:String = "0xFE0E00";
        public static const C_ORANGE:String = "0xFE7903";
        public static const C_YELLOW:String = "0xF8F400";
        public static const C_GREEN:String = "0x60FF00";
        public static const C_BLUE:String = "0x02C9B3";
        public static const C_PURPLE:String = "0xD042F3";
        public static const C_MAGENTA:String = "0xEE33FF";
        public static const C_GREENYELLOW:String = "0x99FF44";
        public static const C_REDSMOOTH:String = "0xDD4444";
        public static const C_REDBRIGHT:String = "0xFF0000";

        // Team
        public static const TEAM_ALLY:int = 1;
        public static const TEAM_ENEMY:int = 2;

        // Field Type
        public static const FIELDTYPE_NONE:int = 0;
        public static const FIELDTYPE_NICK:int = 1;
        public static const FIELDTYPE_VEHICLE:int = 2;

        // Dead State
        public static const DEADSTATE_NONE:int = 0;
        public static const DEADSTATE_ALIVE:int = 1;
        public static const DEADSTATE_DEAD:int = 2;

        // Dynamic color types
        public static const DYNAMIC_COLOR_EFF:int = 1;
        public static const DYNAMIC_COLOR_RATING:int = 2;
        public static const DYNAMIC_COLOR_KB:int = 3;
        public static const DYNAMIC_COLOR_HP:int = 4;
        public static const DYNAMIC_COLOR_HP_RATIO:int = 5;
        public static const DYNAMIC_COLOR_TBATTLES:int = 6;
        public static const DYNAMIC_COLOR_TDB:int = 7;
        public static const DYNAMIC_COLOR_TDV:int = 8;
        public static const DYNAMIC_COLOR_TFB:int = 9;
        public static const DYNAMIC_COLOR_TSB:int = 10;
        public static const DYNAMIC_COLOR_E:int = 11;
        public static const DYNAMIC_COLOR_WN:int = 12;
        public static const DYNAMIC_COLOR_X:int = 13;
        public static const DYNAMIC_COLOR_AVGLVL:int = 14;

        // Dynamic alpha types
        public static const DYNAMIC_ALPHA_EFF:int = 1;
        public static const DYNAMIC_ALPHA_RATING:int = 2;
        public static const DYNAMIC_ALPHA_KB:int = 3;
        public static const DYNAMIC_ALPHA_HP:int = 4;
        public static const DYNAMIC_ALPHA_HP_RATIO:int = 5;
        public static const DYNAMIC_ALPHA_TBATTLES:int = 6;
        public static const DYNAMIC_ALPHA_TDB:int = 7;
        public static const DYNAMIC_ALPHA_TDV:int = 8;
        public static const DYNAMIC_ALPHA_TFB:int = 9;
        public static const DYNAMIC_ALPHA_TSB:int = 10;
        public static const DYNAMIC_ALPHA_E:int = 11;
        public static const DYNAMIC_ALPHA_WN:int = 12;
        public static const DYNAMIC_ALPHA_X:int = 13;
        public static const DYNAMIC_ALPHA_AVGLVL:int = 14;

        // Damage flag at Xvm.as: updateHealth
        public static const FROM_UNKNOWN:int = 0;
        public static const FROM_ALLY:int = 1;
        public static const FROM_ENEMY:int = 2;
        public static const FROM_SQUAD:int = 3;
        public static const FROM_PLAYER:int = 4;

        // Text direction
        public static const DIRECTION_DOWN:int = 1;
        public static const DIRECTION_UP:int = 2;

        // Text insert order
        public static const INSERTORDER_BEGIN:int = DIRECTION_DOWN;
        public static const INSERTORDER_END:int = DIRECTION_UP;

        // Load states
        public static const LOADSTATE_NONE:int = 1;    // not loaded
        public static const LOADSTATE_LOADING:int = 2; // loading
        public static const LOADSTATE_DONE:int = 3;    // statistics loaded
        public static const LOADSTATE_UNKNOWN:int = 4; // unknown vehicle in FogOfWar

        // Level in roman numerals
        public static const ROMAN_LEVEL:Vector.<String> = Vector.<String>([ "I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX", "X" ]);

        // Widgets
        public static const WIDGET_MODE_HIDE:int =     0x01;
        public static const WIDGET_MODE_1:int =        0x02;
        public static const WIDGET_MODE_2:int =        0x04;
        public static const WIDGET_MODE_DETAILED:int = 0x08;
        public static const WIDGET_MODES_ALL:int = WIDGET_MODE_HIDE | WIDGET_MODE_1 | WIDGET_MODE_2 | WIDGET_MODE_DETAILED;
    }
}
