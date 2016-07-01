/**
 * XVM Utils
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.types.cfg.*;
    import com.xvm.vo.*;
    import flash.filters.*;
    import flash.utils.*;
    import flash.text.*;
    import mx.utils.*;

    public class Utils
    {
        public static const DEFAULT_TEXT_FORMAT:TextFormat = new TextFormat("$FieldFont", 14, 0xFFFFFF, null, null, null, null, null, "center");

        // Create TextFormat from config section
        // http://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/flash/text/TextFormat.html
        public static function createTextFormatFromConfig(cfg:CTextFormat, options:IVOMacrosOptions = null):TextFormat
        {
            if (!Macros.FormatBoolean(cfg.enabled, options, true))
            {
                return DEFAULT_TEXT_FORMAT;
            }

            var textFormat:TextFormat = new TextFormat(
                Macros.FormatString(cfg.font, options, DEFAULT_TEXT_FORMAT.font),
                Macros.FormatNumber(cfg.size, options, Number(DEFAULT_TEXT_FORMAT.size)),
                Macros.FormatNumber(cfg.color, options, Number(DEFAULT_TEXT_FORMAT.color), true),
                Macros.FormatBoolean(cfg.bold, options, Boolean(DEFAULT_TEXT_FORMAT.bold)),
                Macros.FormatBoolean(cfg.italic, options, Boolean(DEFAULT_TEXT_FORMAT.italic)),
                Macros.FormatBoolean(cfg.underline, options, Boolean(DEFAULT_TEXT_FORMAT.underline)),
                "", "", // url, target
                Macros.FormatString(cfg.align, options, DEFAULT_TEXT_FORMAT.align),
                Macros.FormatNumber(cfg.leftMargin, options, Number(DEFAULT_TEXT_FORMAT.leftMargin)),
                Macros.FormatNumber(cfg.rightMargin, options, Number(DEFAULT_TEXT_FORMAT.rightMargin)),
                Macros.FormatNumber(cfg.indent, options, Number(DEFAULT_TEXT_FORMAT.indent)),
                Macros.FormatNumber(cfg.leading, options, Number(DEFAULT_TEXT_FORMAT.leading)));
            textFormat.tabStops = cfg.tabStops;
            return textFormat;
        }

        // Create DropShadowFilter from config section
        // http://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/flash/filters/DropShadowFilter.html
        public static function createShadowFiltersFromConfig(cfg:CShadow, options:IVOMacrosOptions = null):Array
        {
            return !Macros.FormatBoolean(cfg.enabled, options, true) ? null : [new DropShadowFilter(
                Macros.FormatNumber(cfg.distance, options, 0),
                Macros.FormatNumber(cfg.angle, options, 0),
                Macros.FormatNumber(cfg.color, options, 0, true),
                Macros.FormatNumber(cfg.alpha, options, 70) / 100.0,
                Macros.FormatNumber(cfg.blur, options, 4),
                Macros.FormatNumber(cfg.blur, options, 4),
                Macros.FormatNumber(cfg.strength, options, 2),
                Macros.FormatNumber(cfg.quality, options, 3),
                Macros.FormatBoolean(cfg.inner, options, false),
                Macros.FormatBoolean(cfg.knockout, options, false),
                Macros.FormatBoolean(cfg.hideObject, options, false))];
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

        // Fix <img src='xvm://*'> to <img src='img://XVM_IMG_RES_ROOT/*'> (res_mods/mods/shared_resources/xvm/res)
        // Fix <img src='cfg://*'> to <img src='img://XVM_IMG_CFG_ROOT/*'> (res_mods/configs/xvm)
        public static function fixImgTag(str:String):String
        {
            if (str == null || str == "")
                return null;
            str = str.split("xvm://").join("img://" + Defines.XVM_IMG_RES_ROOT);
            str = str.split("cfg://").join("img://" + Defines.XVM_IMG_CFG_ROOT);
            return str;
        }

        // Fix 'img://gui/*' to '../*'> (res_mods/x.x.x)
        // Fix 'xvm://*' to '../../XVM_IMG_RES_ROOT/*'> (res_mods/mods/shared_resources/xvm/res)
        // Fix 'cfg://*' to '../../XVM_IMG_CFG_ROOT/*'> (res_mods/configs/xvm)
        public static function fixImgTagSrc(str:String):String
        {
            if (str == null || str == "")
                return null;
            if (XfwUtils.startsWith(str.toLowerCase(), "img://gui/"))
                return "../" + str.slice(10);
            return "../../" + Utils.fixImgTag(str).split("img://").join("");
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

        // Get relative to screen resolution x or y coordinates for using when applying horizontal or vertical align to object
        public static function HVAlign(align:String, value:Number, isVAlign:Boolean):Number
        {
            // 'align' allows only 'left', 'right', 'center' values for horizontal alignment and 'top', 'bottom', 'middle' or "center" for vertical
            switch (align)
            {
                case 'left':
                    return 0;
                case 'right' :
                    return App.appWidth - value;
                case 'center':
                    if (!isVAlign)
                    {
                      return (App.appWidth / 2) - (value / 2);
                    }
                    else
                    {
                      return (App.appHeight / 2) - (value / 2);
                    }
                case 'top':
                    return 0;
                case 'bottom':
                    return App.appHeight - value;
                case 'middle':
                    return (App.appHeight / 2) - (value / 2);
            }
            return value;
        }
    }
}
