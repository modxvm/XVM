/**
 * XVM Utils
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.utils
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.types.cfg.*;
    import flash.filters.*;

    public class Utils
    {
        // Create DropShadowFilter from config section
        public static function createShadowFilterFromConfig(cfg:CShadow):DropShadowFilter
        {
            // NOTE: quality arg is not working with Scaleform 4.2 AS3
            return cfg.enabled == false ? null : new DropShadowFilter(
                cfg.distance, // distance
                cfg.angle, // angle
                parseInt(cfg.color, 16),
                cfg.alpha / 100.0,
                cfg.blur,
                cfg.blur,
                cfg.strength);
        }

        public static function getMarksOnGunText(value:Number):String
        {
            if (isNaN(value) || !Config.config.texts.marksOnGun["_" + value])
                return null;
            var v:String = Config.config.texts.marksOnGun["_" + value];
            if (v.indexOf("{{l10n:") >= 0)
                v = Locale.get(v);
            return v;
        }

        public static function getXvmUserText(status:Number):String
        {
            var value:String = isNaN(status) ? 'none' : (status & 0x01) ? 'on' : 'off';

            if (!Config.config.texts.xvmuser[value])
                return null;

            var v:String = Config.config.texts.xvmuser[value];
            if (v.indexOf("{{l10n:") >= 0)
                v = Locale.get(v);

            return v;
        }

        public static function getBattleTypeText(battleType:Number):String
        {
            var value:String = getBattleTypeStr(battleType);

            if (!Config.config.texts.battletype[value])
                return null;

            var v:String = Config.config.texts.battletype[value];
            if (v.indexOf("{{l10n:") >= 0)
                v = Locale.get(v);

            return v;
        }

        public static function getBattleTypeStr(battleType:Number):String
        {
            switch (battleType)
            {
                case 1: return 'regular';
                case 2: return 'training';
                case 3: return 'company';
                case 4: return 'tournament';
                case 5: return 'clan';
                case 6: return 'tutorial';
                case 7: return 'cybersport';
                case 8: return 'historical';
                case 9: return 'event_battles';
                case 10: return 'sortie';
                case 11: return 'fort_battle';
                case 12: return 'rated_cybersport';
                default: return 'unknown';
            }
        }

        public static function getTopClanText(clanInfoRank:Number):String
        {
            var value:String = isNaN(clanInfoRank) ? "regular" : clanInfoRank == 0 ? "persist" :
                clanInfoRank <= Config.networkServicesSettings.topClansCount ? "top" : "regular";

            if (!Config.config.texts.topclan[value])
                return null;

            var v:String = Config.config.texts.topclan[value];
            if (v.indexOf("{{l10n:") >= 0)
                v = Locale.get(v);

            return v;
        }

        // Fix <img src='xvm://...'> to <img src='img://XVM_IMG_RES_ROOT/...'> (res_mods/mods/shared_resources/xvm/res)
        // Fix <img src='cfg://...'> to <img src='img://XVM_IMG_CFG_ROOT/...'> (res_mods/configs/xvm)
        public static function fixImgTag(str:String):String
        {
            str = str.split("xvm://").join("img://" + Defines.XVM_IMG_RES_ROOT);
            str = str.split("cfg://").join("img://" + Defines.XVM_IMG_CFG_ROOT);
            return str;
        }

        public static function vehicleClassToVehicleType(vclass:String):String
        {
            switch (vclass)
            {
                case "lightTank": return "LT";
                case "mediumTank": return "MT";
                case "heavyTank": return "HT";
                case "SPG": return "SPG";
                case "AT-SPG": return "TD";
                default: return vclass;
            }
        }
    }
}
