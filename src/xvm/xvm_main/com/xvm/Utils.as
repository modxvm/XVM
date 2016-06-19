/**
 * XVM Utils
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.types.cfg.*;
    import flash.filters.*;
    import mx.utils.ObjectUtil;

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
                case 13: return 'global_map';
                case 14: return 'tournament_regular';
                case 15: return 'tournament_clan';
                case 16: return 'rated_sandbox';
                case 17: return 'sandbox';
                case 18: return 'fallout_classic';
                case 19: return 'fallout_multiteam';
                default: return 'unknown';
            }
        }

        public static function getTopClanText(rank:Number):String
        {
            var value:String = isNaN(rank) ? "regular" : rank == 0 ? "persist" :
                rank <= Config.networkServicesSettings.topClansCount ? "top" : "regular";

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

        // 'RU1', 'RU10', 'RU2' -> 'RU1', 'RU2', 'RU10'
        public static function sortByServer(a:String, b:String):int
        {
            var name_and_number:RegExp = /^(\D+)(\d+)$/;
            var result_a:Object = name_and_number.exec(a)
            if (!result_a)
                return ObjectUtil.stringCompare(a, b)
            var result_b:Object = name_and_number.exec(b)
            if (!result_b)
                return ObjectUtil.stringCompare(a, b)
            if (result_a[1] == result_b[1]) { // non-numeric part is same
                var result_a_num:int = parseInt(result_a[2],10);
                var result_b_num:int = parseInt(result_b[2],10);
                return result_a_num == result_b_num ? 0 : result_a_num > result_b_num ? 1 : -1;
            }
            return result_a[1] > result_b[1] ? 1 : -1;
        }

        public static function createServersOrderFromAnswer(answer:Object):Array
        {
            var serversOrder:Array = new Array();
            for (var name:String in answer)
                serversOrder.push(name);
            serversOrder.sort(Utils.sortByServer);
            return serversOrder
        }

        public static function serversOrderMatchesAnswer(answer:Object, serversOrder:Array):Boolean
        {
            for (var name:String in serversOrder)
                if (! name in answer)
                    return false
            for (name in answer)
                if (serversOrder.indexOf(name) == -1)
                    return false
            return true
        }

        public static function timeStrToSec(str:String):Number
        {
            var p:Array = str.split(':');
            var s:int = 0;
            var m:int = 1;
            while (p.length > 0) {
                s += m * parseInt(p.pop(), 10);
                m *= 60;
            }
            return s;
        }

        public static function getSpottedText(value:String, isArty:Boolean):String
        {
            if (value == null)
                return null;

            if (isArty)
                value += "_arty";

            if (!Config.config.texts.spotted[value])
                return null;

            var v:String = Config.config.texts.spotted[value];
            if (v.indexOf("{{l10n:") >= 0)
                v = Locale.get(v);

            return v;
        }
    }
}
