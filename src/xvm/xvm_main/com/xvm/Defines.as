/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm
{
    public class Defines
    {
        // Global versions
        public static const XVM_VERSION:String = "6.1.0-dev";
        public static const XVM_INTRO:String = "www.modxvm.com";
        public static const WOT_VERSION:String = "0.9.7";
        public static const CONFIG_VERSION:String = "5.1.0";

        //// Locale
        public static const LOCALE_AUTO_DETECTION:String = "auto";
//
        //// Region
        public static const REGION_AUTO_DETECTION:String = "auto";
//
        //// TODO: Check this
        //// res_mods/mods/shared_resources/xvm/res/
        //public static const XVMRES_ROOT:String = "../../../mods/shared_resources/xvm/res/";
//
        //// Paths relative to /res_mods/0.x.x/
        //// res_mods/mods/shared_resources/xvm/ (for <img> tag)
        //public static const XVM_IMG_RES_ROOT:String = "../mods/shared_resources/xvm/";
//
        //// res_mods/configs/xvm/ (for <img> tag)
        //public static const XVM_IMG_CFG_ROOT:String = "../configs/xvm/";

        // res_mods/configs/xvm/
        public static const XVM_CONFIGS_DIR_NAME:String = "res_mods/configs/xvm/";

        // res_mods/configs/xvm/xvm.xc
        public static const XVM_CONFIG_FILE_NAME:String = XVM_CONFIGS_DIR_NAME + "xvm.xc";

        // Paths relative to WoT root
        // res_mods/mods/shared_resources/xvm/
        public static const XVM_RESOURCES_DIR_NAME:String = "res_mods/mods/shared_resources/xvm/";

        // res_mods/mods/shared_resources/xvm/l10n
        public static const XVM_L10N_DIR_NAME:String = XVM_RESOURCES_DIR_NAME + "l10n/";
//
        //// Settings keys
        //public static const SETTINGS_WIDGETS:String = "widgets";
        //public static const SETTINGS_WIDGETSSETTINGSDIALOG:String = "widgets.SettingsDialog";
//
        //// Default settings
        //public static const DEFAULT_SETTINGS_WIDGETS:Vector.<String> = new Vector.<String>();
        //public static const DEFAULT_SETTINGS_WIDGETSSETTINGSDIALOG:Object = { x: 400, y: 150 };
//
        //// Default path to vehicle icons (relative)
        //public static const WG_CONTOUR_ICON_PATH:String = "../maps/icons/vehicle/contour/";
        //public static const WG_CONTOUR_ICON_NOIMAGE:String = WG_CONTOUR_ICON_PATH + "noImage.png";
//
        //public static const MAX_BATTLETIER_HPS:Array = [140, 190, 320, 420, 700, 1400, 1500, 1780, 2000, 3000, 3000];
//
        //// Field Type
        //public static const FIELDTYPE_NONE:int = 0;
        //public static const FIELDTYPE_NICK:int = 1;
        //public static const FIELDTYPE_VEHICLE:int = 2;
        //public static const FIELDTYPE_FRAGS:int = 3;
//
        //// Dead State
        //public static const DEADSTATE_NONE:int = 0;
        //public static const DEADSTATE_ALIVE:int = 1;
        //public static const DEADSTATE_DEAD:int = 2;
//
        //// Dynamic color types
        //public static const DYNAMIC_COLOR_EFF:int = 1;
        //public static const DYNAMIC_COLOR_RATING:int = 2;
        //public static const DYNAMIC_COLOR_KB:int = 3;
        //public static const DYNAMIC_COLOR_HP:int = 4;
        //public static const DYNAMIC_COLOR_HP_RATIO:int = 5;
        //public static const DYNAMIC_COLOR_TBATTLES:int = 6;
        //public static const DYNAMIC_COLOR_TDB:int = 7;
        //public static const DYNAMIC_COLOR_TDV:int = 8;
        //public static const DYNAMIC_COLOR_TFB:int = 9;
        //public static const DYNAMIC_COLOR_TSB:int = 10;
        //public static const DYNAMIC_COLOR_E:int = 11;
        //public static const DYNAMIC_COLOR_WN6:int = 12;
        //public static const DYNAMIC_COLOR_WN8:int = 13;
        //public static const DYNAMIC_COLOR_WGR:int = 14;
        //public static const DYNAMIC_COLOR_X:int = 15;
        //public static const DYNAMIC_COLOR_AVGLVL:int = 16;
        //public static const DYNAMIC_COLOR_WN8EFFD:int = 17;
        //public static const DYNAMIC_COLOR_DAMAGERATING:int = 18;
        //public static const DYNAMIC_COLOR_HITSRATIO:int = 19;
        //public static const DYNAMIC_COLOR_WINCHANCE:int = 20;
//
        //// Dynamic alpha types
        //public static const DYNAMIC_ALPHA_EFF:int = 1;
        //public static const DYNAMIC_ALPHA_RATING:int = 2;
        //public static const DYNAMIC_ALPHA_KB:int = 3;
        //public static const DYNAMIC_ALPHA_HP:int = 4;
        //public static const DYNAMIC_ALPHA_HP_RATIO:int = 5;
        //public static const DYNAMIC_ALPHA_TBATTLES:int = 6;
        //public static const DYNAMIC_ALPHA_TDB:int = 7;
        //public static const DYNAMIC_ALPHA_TDV:int = 8;
        //public static const DYNAMIC_ALPHA_TFB:int = 9;
        //public static const DYNAMIC_ALPHA_TSB:int = 10;
        //public static const DYNAMIC_ALPHA_E:int = 11;
        //public static const DYNAMIC_ALPHA_WN6:int = 12;
        //public static const DYNAMIC_ALPHA_WN8:int = 13;
        //public static const DYNAMIC_ALPHA_WGR:int = 14;
        //public static const DYNAMIC_ALPHA_X:int = 15;
        //public static const DYNAMIC_ALPHA_AVGLVL:int = 16;
//
        //// Damage flag at Xvm.as: updateHealth
        //public static const FROM_UNKNOWN:int = 0;
        //public static const FROM_ALLY:int = 1;
        //public static const FROM_ENEMY:int = 2;
        //public static const FROM_SQUAD:int = 3;
        //public static const FROM_PLAYER:int = 4;
//
        //// Text direction
        //public static const DIRECTION_DOWN:int = 1;
        //public static const DIRECTION_UP:int = 2;
//
        //// Text insert order
        //public static const INSERTORDER_BEGIN:int = DIRECTION_DOWN;
        //public static const INSERTORDER_END:int = DIRECTION_UP;
//
        //// Load states
        //public static const LOADSTATE_NONE:int = 1;    // not loaded
        //public static const LOADSTATE_LOADING:int = 2; // loading
        //public static const LOADSTATE_DONE:int = 3;    // statistics loaded
        //public static const LOADSTATE_UNKNOWN:int = 4; // unknown vehicle in FogOfWar
//
        //// Level in roman numerals
        //public static const ROMAN_LEVEL:Vector.<String> = Vector.<String>([ "I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX", "X" ]);
//
        //// Widgets
        //public static const WIDGET_MODE_HIDE:int =     0x01;
        //public static const WIDGET_MODE_1:int =        0x02;
        //public static const WIDGET_MODE_2:int =        0x04;
        //public static const WIDGET_MODE_DETAILED:int = 0x08;
        //public static const WIDGET_MODES_ALL:int = WIDGET_MODE_HIDE | WIDGET_MODE_1 | WIDGET_MODE_2 | WIDGET_MODE_DETAILED;
//
        //// String templates
        //public static const SYSTEM_MESSAGE_HEADER:String =
            //'<textformat tabstops="[130]"><img src="img://../xvm/res/icons/xvm/16x16t.png" vspace="-5">' +
            //'&nbsp;<a href="#XVM_SITE#"><font color="#E2D2A2">www.modxvm.com</font></a>\n\n%VALUE%';
//
        //// BattleTypes
        //public static const BATTLE_TYPE_UNKNOWN:int = 0;
        //public static const BATTLE_TYPE_REGULAR:int = 1;
        //public static const BATTLE_TYPE_TRAINING:int = 2;
        //public static const BATTLE_TYPE_COMPANY:int = 3;
        //public static const BATTLE_TYPE_TOURNAMENT:int = 4;
        //public static const BATTLE_TYPE_CLAN:int = 5;
        //public static const BATTLE_TYPE_TUTORIAL:int = 6;
        //public static const BATTLE_TYPE_CYBERSPORT:int = 7;
        //public static const BATTLE_TYPE_HISTORICAL:int = 8;
        //public static const BATTLE_TYPE_EVENT_BATTLES:int = 9;
        //public static const BATTLE_TYPE_SORTIE:int = 10;
        //public static const BATTLE_TYPE_FORT_BATTLE:int = 11;
        //public static const BATTLE_TYPE_RATED_CYBERSPORT:int = 12;

        // Events
        //public static const XFW_EVENT_CMD_RECEIVED:String = "xfw.cmd_rvcd";
        public static const XVM_EVENT_CONFIG_LOADED:String = "xvm.config_loaded";

        // DAAPI commands
        public static const XVM_COMMAND_SETCONFIG:String = "xvm.setconfig";

        public static const XVM_AS_COMMAND_RELOAD_CONFIG:String = "xvm.as.reload_config";

        //public static const XFW_COMMAND_LOADFILE:String = "xfw.loadFile";
        //public static const XFW_COMMAND_GETGAMEREGION:String = "xfw.gameRegion";
        //public static const XFW_COMMAND_GETGAMELANGUAGE:String = "xfw.gameLanguage";
        //// args: title, message
        //public static const XFW_COMMAND_MESSAGEBOX:String = 'xfw.messageBox';
        //// args: message, type
        //// Types: gui.SystemMessages.SM_TYPE: 'Error', 'Warning', 'Information', 'GameGreeting', ...
        //public static const XFW_AS_COMMAND_L10N:String = "xfw.as.l10n";
//
        //public static const XVM_COMMAND_GET_SVC_SETTINGS:String = "xvm.get_svc_settings";
        //public static const XVM_COMMAND_GET_BATTLE_LEVEL:String = "xvm.get_battle_level";
        //public static const XVM_COMMAND_GET_BATTLE_TYPE:String = "xvm.get_battle_type";
        //public static const XVM_COMMAND_LOAD_SETTINGS:String = "xvm.load_settings";
        //public static const XVM_COMMAND_SAVE_SETTINGS:String = "xvm.save_settings";
//
        //public static const XVM_AS_COMMAND_SET_SVC_SETTINGS:String = "xvm.as.set_svc_settings";
    }
}
