﻿/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm
{
    import com.xfw.XfwConst;

    public class Defines
    {
        // Default path to vehicle icons (relative)
        public static const WG_CONTOUR_ICON_PATH:String = "../maps/icons/vehicle/contour/";
        public static const WG_CONTOUR_ICON_NOIMAGE:String = WG_CONTOUR_ICON_PATH + "noImage.png";

        // res_mods/mods/shared_resources/xvm/res/
        public static const XVMRES_ROOT:String = "../../../mods/shared_resources/xvm/res/";

        // Paths relative to /res_mods/0.x.x/
        // res_mods/mods/shared_resources/xvm/ (for <img> tag)
        public static const XVM_IMG_RES_ROOT:String = "../mods/shared_resources/xvm/";

        // res_mods/configs/xvm/ (for <img> tag)
        public static const XVM_IMG_CFG_ROOT:String = "../configs/xvm/";

        // Paths relative to WoT root
        // res_mods/mods/shared_resources/xvm/
        public static const XVM_RESOURCES_DIR_NAME:String = XfwConst.XFW_RESOURCES_DIR_NAME + "xvm/";

        // res_mods/mods/shared_resources/xvm/l10n
        public static const XVM_L10N_DIR_NAME:String = XVM_RESOURCES_DIR_NAME + "l10n/";

        //public static const MAX_BATTLETIER_HPS:Array = [140, 190, 320, 420, 700, 1400, 1500, 1780, 2000, 3000, 3000];

        //// Field Type
        //public static const FIELDTYPE_NONE:int = 0;
        //public static const FIELDTYPE_NICK:int = 1;
        //public static const FIELDTYPE_VEHICLE:int = 2;
        //public static const FIELDTYPE_FRAGS:int = 3;

        //// Dead State
        //public static const DEADSTATE_NONE:int = 0;
        //public static const DEADSTATE_ALIVE:int = 1;
        //public static const DEADSTATE_DEAD:int = 2;

        // Dynamic color types
        public static const DYNAMIC_COLOR_EFF:int = 1;
        public static const DYNAMIC_COLOR_WINRATE:int = 2;
        public static const DYNAMIC_COLOR_KB:int = 3;
        public static const DYNAMIC_COLOR_HP:int = 4;
        public static const DYNAMIC_COLOR_HP_RATIO:int = 5;
        public static const DYNAMIC_COLOR_TBATTLES:int = 6;
        public static const DYNAMIC_COLOR_TDB:int = 7;
        public static const DYNAMIC_COLOR_TDV:int = 8;
        public static const DYNAMIC_COLOR_TFB:int = 9;
        public static const DYNAMIC_COLOR_TSB:int = 10;
        public static const DYNAMIC_COLOR_WN6:int = 11;
        public static const DYNAMIC_COLOR_WN8:int = 12;
        public static const DYNAMIC_COLOR_WGR:int = 13;
        public static const DYNAMIC_COLOR_X:int = 14;
        public static const DYNAMIC_COLOR_AVGLVL:int = 15;
        public static const DYNAMIC_COLOR_WN8EFFD:int = 16;
        public static const DYNAMIC_COLOR_DAMAGERATING:int = 17;
        public static const DYNAMIC_COLOR_HITSRATIO:int = 18;
        public static const DYNAMIC_COLOR_WINCHANCE:int = 19;

        // Dynamic alpha types
        public static const DYNAMIC_ALPHA_EFF:int = 1;
        public static const DYNAMIC_ALPHA_WINRATE:int = 2;
        public static const DYNAMIC_ALPHA_KB:int = 3;
        public static const DYNAMIC_ALPHA_HP:int = 4;
        public static const DYNAMIC_ALPHA_HP_RATIO:int = 5;
        public static const DYNAMIC_ALPHA_TBATTLES:int = 6;
        public static const DYNAMIC_ALPHA_TDB:int = 7;
        public static const DYNAMIC_ALPHA_TDV:int = 8;
        public static const DYNAMIC_ALPHA_TFB:int = 9;
        public static const DYNAMIC_ALPHA_TSB:int = 10;
        public static const DYNAMIC_ALPHA_WN6:int = 11;
        public static const DYNAMIC_ALPHA_WN8:int = 12;
        public static const DYNAMIC_ALPHA_WGR:int = 13;
        public static const DYNAMIC_ALPHA_X:int = 14;
        public static const DYNAMIC_ALPHA_AVGLVL:int = 15;

        // Damage flag at Xvm.as: updateHealth
        public static const FROM_UNKNOWN:int = 0;
        public static const FROM_ALLY:int = 1;
        public static const FROM_ENEMY:int = 2;
        public static const FROM_SQUAD:int = 3;
        public static const FROM_PLAYER:int = 4;

        //// Text direction
        //public static const DIRECTION_DOWN:int = 1;
        //public static const DIRECTION_UP:int = 2;

        //// Text insert order
        //public static const INSERTORDER_BEGIN:int = DIRECTION_DOWN;
        //public static const INSERTORDER_END:int = DIRECTION_UP;

        //// Load states
        //public static const LOADSTATE_NONE:int = 1;    // not loaded
        //public static const LOADSTATE_LOADING:int = 2; // loading
        //public static const LOADSTATE_DONE:int = 3;    // statistics loaded
        //public static const LOADSTATE_UNKNOWN:int = 4; // unknown vehicle in FogOfWar

        // Level in roman numerals
        public static const ROMAN_LEVEL:Vector.<String> = Vector.<String>([ "I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX", "X" ]);

        //// Widgets
        //public static const WIDGET_MODE_HIDE:int =     0x01;
        //public static const WIDGET_MODE_1:int =        0x02;
        //public static const WIDGET_MODE_2:int =        0x04;
        //public static const WIDGET_MODE_DETAILED:int = 0x08;
        //public static const WIDGET_MODES_ALL:int = WIDGET_MODE_HIDE | WIDGET_MODE_1 | WIDGET_MODE_2 | WIDGET_MODE_DETAILED;

        //// String templates
        //public static const SYSTEM_MESSAGE_HEADER:String =
            //'<textformat tabstops="[130]"><img src="img://../xvm/res/icons/xvm/16x16t.png" vspace="-5">' +
            //'&nbsp;<a href="#XVM_SITE#"><font color="#E2D2A2">www.modxvm.com</font></a>\n\n%VALUE%';

        // ArenaGuiTypes
        // sync with constants.py: ARENA_GUI_TYPE
        public static var ARENA_GUI_TYPE_UNKNOWN:Number = 0
        public static var ARENA_GUI_TYPE_RANDOM:Number = 1
        public static var ARENA_GUI_TYPE_TOURNAMENT:Number = 2
        public static var ARENA_GUI_TYPE_COMPANY:Number = 3
        public static var ARENA_GUI_TYPE_TUTORIAL:Number = 4
        public static var ARENA_GUI_TYPE_CYBERSPORT:Number = 5
        public static var ARENA_GUI_TYPE_FALLOUT:Number = 6
        public static var ARENA_GUI_TYPE_EVENT_BATTLES:Number = 7
        public static var ARENA_GUI_TYPE_SORTIE:Number = 8
        public static var ARENA_GUI_TYPE_FORT_BATTLE:Number = 9
        public static var ARENA_GUI_TYPE_RATED_CYBERSPORT:Number = 10
        public static var ARENA_GUI_TYPE_RATED_SANDBOX:Number = 11
        public static var ARENA_GUI_TYPE_SANDBOX:Number = 12
        public static var ARENA_GUI_TYPE_FALLOUT_CLASSIC:Number = 13
        public static var ARENA_GUI_TYPE_FALLOUT_MULTITEAM:Number = 14

        public static var ARENA_GUI_TYPE_NO_PLAYER_PANELS:Array = [ ARENA_GUI_TYPE_FALLOUT_CLASSIC, ARENA_GUI_TYPE_FALLOUT_MULTITEAM ];


        // sync with constants.py: ARENA_BONUS_TYPE
        public static var BATTLE_TYPE_UNKNOWN:Number = 0;
        public static var BATTLE_TYPE_REGULAR:Number = 1;
        public static var BATTLE_TYPE_TRAINING:Number = 2;
        public static var BATTLE_TYPE_COMPANY:Number = 3;
        public static var BATTLE_TYPE_TOURNAMENT:Number = 4;
        public static var BATTLE_TYPE_CLAN:Number = 5;
        public static var BATTLE_TYPE_TUTORIAL:Number = 6;
        public static var BATTLE_TYPE_CYBERSPORT:Number = 7;
        public static var BATTLE_TYPE_EVENT_BATTLES:Number = 9;
        public static var BATTLE_TYPE_SORTIE:Number = 10;
        public static var BATTLE_TYPE_FORT_BATTLE:Number = 11;
        public static var BATTLE_TYPE_RATED_CYBERSPORT:Number = 12;
        public static var BATTLE_TYPE_GLOBAL_MAP:Number = 13;
        public static var BATTLE_TYPE_TOURNAMENT_REGULAR:Number = 14;
        public static var BATTLE_TYPE_TOURNAMENT_CLAN:Number = 15;
        public static var BATTLE_TYPE_RATED_SANDBOX:Number = 16;
        public static var BATTLE_TYPE_SANDBOX:Number = 17;
        public static var BATTLE_TYPE_FALLOUT_CLASSIC:Number = 18;
        public static var BATTLE_TYPE_FALLOUT_MULTITEAM:Number = 19;

        // Events
        public static const XVM_EVENT_CONFIG_LOADED:String = "xvm.config_loaded";
    }
}
