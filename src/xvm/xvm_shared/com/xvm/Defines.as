/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm
{
    import com.xfw.*;

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
        public static const DYNAMIC_COLOR_WN8:int = 11;
        public static const DYNAMIC_COLOR_WGR:int = 12;
        public static const DYNAMIC_COLOR_WTR:int = 13;
        public static const DYNAMIC_COLOR_X:int = 14;
        public static const DYNAMIC_COLOR_AVGLVL:int = 15;
        public static const DYNAMIC_COLOR_WN8EFFD:int = 16;
        public static const DYNAMIC_COLOR_DAMAGERATING:int = 17;
        public static const DYNAMIC_COLOR_HITSRATIO:int = 18;

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
        public static const DYNAMIC_ALPHA_WN8:int = 11;
        public static const DYNAMIC_ALPHA_WGR:int = 12;
        public static const DYNAMIC_ALPHA_WTR:int = 13;
        public static const DYNAMIC_ALPHA_X:int = 14;
        public static const DYNAMIC_ALPHA_AVGLVL:int = 15;

        // Damage flag at Xvm.as: updateHealth
        public static const FROM_UNKNOWN:int = 0;
        public static const FROM_ALLY:int = 1;
        public static const FROM_ENEMY:int = 2;
        public static const FROM_SQUAD:int = 3;
        public static const FROM_PLAYER:int = 4;

        // sync with constants.py: ARENA_BONUS_TYPE
        public static const BATTLE_TYPE_UNKNOWN:Number = 0;
        public static const BATTLE_TYPE_REGULAR:Number = 1;
        public static const BATTLE_TYPE_TRAINING:Number = 2;
        public static const BATTLE_TYPE_TOURNAMENT:Number = 4;
        public static const BATTLE_TYPE_CLAN:Number = 5;
        public static const BATTLE_TYPE_TUTORIAL:Number = 6;
        public static const BATTLE_TYPE_CYBERSPORT:Number = 7;
        public static const BATTLE_TYPE_EVENT_BATTLES:Number = 9;
        public static const BATTLE_TYPE_GLOBAL_MAP:Number = 13;
        public static const BATTLE_TYPE_TOURNAMENT_REGULAR:Number = 14;
        public static const BATTLE_TYPE_TOURNAMENT_CLAN:Number = 15;
        public static const BATTLE_TYPE_RATED_SANDBOX:Number = 16;
        public static const BATTLE_TYPE_SANDBOX:Number = 17;
        public static const BATTLE_TYPE_FALLOUT_CLASSIC:Number = 18;
        public static const BATTLE_TYPE_FALLOUT_MULTITEAM:Number = 19;
        public static const BATTLE_TYPE_SORTIE_2:Number = 20;
        public static const BATTLE_TYPE_FORT_BATTLE_2:Number = 21;
        public static const BATTLE_TYPE_RANKED:Number = 22;
        public static const BATTLE_TYPE_BOOTCAMP:Number = 23;
        public static const BATTLE_TYPE_EPIC_RANDOM:Number = 24;
        public static const BATTLE_TYPE_EPIC_RANDOM_TRAINING:Number = 25;
        public static const BATTLE_TYPE_EVENT_BATTLES_2:Number = 26;
        public static const BATTLE_TYPE_EPIC_BATTLE:Number = 27;
        public static const BATTLE_TYPE_EPIC_BATTLE_TRAINING:Number = 28;
        public static const BATTLE_TYPE_BATTLE_ROYALE_SOLO:Number = 29;
        public static const BATTLE_TYPE_BATTLE_ROYALE_SQUAD:Number = 30;
        public static const BATTLE_TYPE_TOURNAMENT_EVENT:Number = 31;
        public static const BATTLE_TYPE_BOB:Number = 32;
        public static const BATTLE_TYPE_EVENT_RANDOM:Number = 33;
        public static const BATTLE_ROYALE_TRN_SOLO:Number = 34;
        public static const BATTLE_ROYALE_TRN_SQUAD:Number = 35;
        public static const WEEKEND_BRAWL:Number = 36;
        public static const MAPBOX:Number = 37;

        // Events
        public static const XVM_EVENT_CONFIG_LOADED:String = "xvm.config_loaded";
        public static const XVM_EVENT_ATLAS_LOADED:String = "xvm.atlas_loaded";

        // Level in roman numerals
        public static const ROMAN_LEVEL:Vector.<String> = new <String>[ "I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX", "X" ];
        ROMAN_LEVEL.fixed = true;

        // constants.VEHICLE_MISC_STATUS
        public static const VEHICLE_MISC_STATUS_OTHER_VEHICLE_DAMAGED_DEVICES_VISIBLE:int = 0;
        public static const VEHICLE_MISC_STATUS_IS_OBSERVED_BY_ENEMY:int = 1;
        public static const VEHICLE_MISC_STATUS_LOADER_INTUITION_WAS_USED:int = 2;
        public static const VEHICLE_MISC_STATUS_VEHICLE_IS_OVERTURNED:int = 3;
        public static const VEHICLE_MISC_STATUS_VEHICLE_DROWN_WARNING:int = 4;
        public static const VEHICLE_MISC_STATUS_IN_DEATH_ZONE:int = 5;
        public static const VEHICLE_MISC_STATUS_HORN_BANNED:int = 6;
        public static const VEHICLE_MISC_STATUS_DESTROYED_DEVICE_IS_REPAIRING:int = 7;
        public static const VEHICLE_MISC_STATUS_ALL:String = "ALL";

        // constants.DEATH_ZONES
        public static const DEATH_ZONES_STATIC:int = 0;
        public static const DEATH_ZONES_GAS_ATTACK:int = 1;

        // layers
        public static const LAYER_SUBSTRATE:String = "substrate";
        public static const LAYER_BOTTOM:String = "bottom";
        public static const LAYER_NORMAL:String = "normal";
        public static const LAYER_TOP:String = "top";

        // widgets types
        public static const WIDGET_TYPE_EXTRAFIELD:String = "extrafield";

        // App types
        public static const APP_TYPE_UNKNOWN:int =           0x0000;
        public static const APP_TYPE_LOBBY:int =             0x0001;
        public static const APP_TYPE_BATTLE_CLASSIC:int =    0x0002;
        public static const APP_TYPE_BATTLE_EPICBATTLE:int = 0x0004;
        public static const APP_TYPE_BATTLE_EPICRANDOM:int = 0x0008;
        public static const APP_TYPE_BATTLE_RANKED:int =     0x0010;
        public static const APP_TYPE_VEHICLE_MARKERS:int =   0x0020;
        public static const APP_TYPE_BATTLE_ROYALE:int =     0x0040;
        public static const APP_TYPE_BATTLE:int =            APP_TYPE_BATTLE_CLASSIC | APP_TYPE_BATTLE_EPICBATTLE | APP_TYPE_BATTLE_EPICRANDOM | APP_TYPE_BATTLE_RANKED | APP_TYPE_BATTLE_ROYALE;
    }
}
