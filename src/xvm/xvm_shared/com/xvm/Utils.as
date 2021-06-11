/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm
{
    import com.xfw.*;
    import com.xvm.types.cfg.*;
    import com.xvm.types.TurretType;
    import com.xvm.vo.*;
    import flash.filters.*;
    import flash.text.*;
    import scaleform.gfx.*;

    public class Utils
    {
        private static const DEFAULT_TEXT_FORMAT:TextFormat = new TextFormat("$FieldFont", 14, 0xFFFFFF, null, null, null, null, null, "center");

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
                Macros.FormatNumber(cfg.color, options, Number(DEFAULT_TEXT_FORMAT.color)),
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
                Macros.FormatNumber(cfg.color, options, 0),
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
            var value:String = getBattleTypeKey(battleType);

            if (!Config.config.texts.battletype[value])
                return null;

            var v:String = Config.config.texts.battletype[value];
            if (v.indexOf("{{l10n:") >= 0)
                v = Locale.get(v);

            return v;
        }

        public static function getBattleTypeKey(battleType:Number):String
        {
            switch (battleType)
            {
                case 1: return 'regular';
                case 2: return 'training';
                case 4: return 'tournament';
                case 5: return 'clan';
                case 6: return 'tutorial';
                case 7: return 'cybersport';
                case 9: return 'event_battles';
                case 13: return 'global_map';
                case 14: return 'tournament_regular';
                case 15: return 'tournament_clan';
                case 16: return 'rated_sandbox';
                case 17: return 'sandbox';
                case 18: return 'fallout_classic';
                case 19: return 'fallout_multiteam';
                case 20: return 'sortie_2';
                case 21: return 'fort_battle_2';
                case 22: return 'ranked';
                case 23: return 'bootcamp';
                case 24: return 'epic_random';
                case 25: return 'epic_random_training';
                case 26: return 'event_battles_2';
                case 27: return 'epic_battle';
                case 28: return 'epic_battle_training';
                case 29: return 'battle_royale_solo';
                case 30: return 'battle_royale_squad';
                case 31: return 'tournament_event';
                case 32: return 'bob';
                case 33: return 'event_random';
                case 34: return 'battle_royale_training_solo';
                case 35: return 'battle_royale_training_squad';
                case 36: return 'weekend_brawl';
                case 37: return 'mapbox';
                default: return 'unknown';
            }
        }

        public static function getTopClanText(rank:Number):String
        {
            var isTop:Boolean = rank <= Config.networkServicesSettings.topClansCountWsh || rank <= Config.networkServicesSettings.topClansCountWgm;
            var value:String = isNaN(rank) ? "regular" : rank == 0 ? "persist" : isTop ? "top" : "regular";

            if (!Config.config.texts.topclan[value])
                return null;

            var v:String = Config.config.texts.topclan[value];
            if (v.indexOf("{{l10n:") >= 0)
                v = Locale.get(v);

            return v;
        }

        // Fix <img src='xvm://*'> to <img src='img://XVM_IMG_RES_ROOT/*'> (res_mods/mods/shared_resources/xvm)
        // Fix <img src='cfg://*'> to <img src='img://XVM_IMG_CFG_ROOT/*'> (res_mods/configs/xvm)
        public static function fixImgTag(str:String):String
        {
            if (str)
            {
                str = str.split("xvm://").join("img://" + Defines.XVM_IMG_RES_ROOT);
                str = str.split("cfg://").join("img://" + Defines.XVM_IMG_CFG_ROOT);
                return str;
            }
            return null;
        }

        // Fix 'img://gui/*' to '../*'> (res_mods/x.x.x)
        // Fix 'xvm://*' to '../../XVM_IMG_RES_ROOT/*'> (res_mods/mods/shared_resources/xvm)
        // Fix 'cfg://*' to '../../XVM_IMG_CFG_ROOT/*'> (res_mods/configs/xvm)
        public static function fixImgTagSrc(str:String):String
        {
            if (str)
            {
                if (str.slice(0, 10).toLowerCase() == "img://gui/")
                    return "../" + str.slice(10);
                return "../../" + Utils.fixImgTag(str).slice(6);
            }
            return null;
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

        // Get relative to screen resolution x or y coordinates for using when applying horizontal align to object
        public static function HAlign(align:String, value:Number, maxWidth:Number):Number
        {
            switch (align)
            {
                case TextFormatAlign.LEFT:
                    return 0;
                case TextFormatAlign.RIGHT:
                    return maxWidth - value;
                case TextFormatAlign.CENTER:
                    return (maxWidth / 2.0) - (value / 2.0);
            }
            return value;
        }

        // Get relative to screen resolution x or y coordinates for using when applying vertical align to object
        public static function VAlign(align:String, value:Number, maxHeight:Number):Number
        {
            switch (align)
            {
                case TextFieldEx.VALIGN_TOP:
                    return 0;
                case TextFieldEx.VALIGN_BOTTOM:
                    return maxHeight - value;
                case TextFieldEx.VALIGN_CENTER:
                    return (maxHeight / 2.0) - (value / 2.0);
            }
            return value;
        }

        public static function getTurret(turret:Number):String
        {
            switch (turret)
            {
                case TurretType.TOP_GUN_IMPOSSIBLE:
                    return Config.config.markers.turretMarkers.highVulnerability;
                case TurretType.TOP_GUN_POSSIBLE:
                    return Config.config.markers.turretMarkers.lowVulnerability;
            }
            return null;
        }
    }
}
