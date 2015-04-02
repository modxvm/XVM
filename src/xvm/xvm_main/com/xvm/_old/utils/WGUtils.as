/**
 * XVM Utils
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.utils
{
    import com.xvm.*;
    import com.xvm.types.cfg.*;
    import flash.text.*;
    import flash.filters.*;
    import net.wg.gui.lobby.profile.components.*;
    import org.idmedia.as3commons.util.*;

    public class WGUtils
    {
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

        public static function GetPlayerName(fullplayername:String):String
        {
            if (fullplayername == null)
                return null;
            var pos:int = fullplayername.indexOf("[");
            return (pos < 0) ? fullplayername : StringUtils.trim(fullplayername.slice(0, pos));
        }

        public static function GetClanNameWithoutBrackets(fullplayername:String):String
        {
            if (fullplayername == null)
                return null;
            var pos:Number = fullplayername.indexOf("[");
            if (pos < 0)
                return null;
            var n:String = fullplayername.slice(pos + 1);
            return n.slice(0, n.indexOf("]"));
        }

        public static function GetClanNameWithBrackets(fullplayername:String):String
        {
            var clan:String = GetClanNameWithoutBrackets(fullplayername);
            return clan ? "[" + clan + "]" : null;
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

        // Clone Objects

        public static function cloneTextField(textField:TextField, replace:Boolean = false):TextField
        {
            var clone:TextField = Utils.shallowCopyClass(textField, TextField);
            clone.defaultTextFormat = textField.getTextFormat();
            clone.selectable = false;
            if (textField.parent && replace) {
                textField.parent.addChild(clone);
                textField.parent.removeChild(textField);
            }
            return clone;
        }

        public static function cloneTextFormat(textFormat:TextFormat):TextFormat
        {
            return new TextFormat(textFormat.font, textFormat.size, textFormat.color, textFormat.bold,
                textFormat.italic, textFormat.underline, textFormat.url, textFormat.target, textFormat.align,
                textFormat.leftMargin, textFormat.rightMargin, textFormat.indent, textFormat.leading);
        }

        public static function cloneDashLineTextItem(dl:ProfileDashLineTextItem):ProfileDashLineTextItem
        {
            var clone:ProfileDashLineTextItem = App.utils.classFactory.getComponent("DashLineTextItem_UI", ProfileDashLineTextItem,
                {
                    x:dl.x,
                    y:dl.y,
                    width: dl.width,
                    height: dl.height,
                    label: dl.label,
                    value: dl.value
                });

            clone.labelTextField.defaultTextFormat = cloneTextFormat(dl.labelTextField.defaultTextFormat);
            clone.valueTextField.defaultTextFormat = cloneTextFormat(dl.valueTextField.defaultTextFormat);

            return clone;
        }




        public static function createTextStyleSheet(name:String, textFormat:TextFormat):StyleSheet
        {
            return WGUtils.createStyleSheet(WGUtils.createCSS(name, textFormat.color as Number,
                textFormat.font, textFormat.size, textFormat.align, textFormat.bold, textFormat.italic));
        }

        public static function addEventListeners(obj:Object, target:Object, handlers:Object):void
        {
            if (!obj || !target || !handlers)
                return;
            for (var name:* in handlers)
                obj.addEventListener(name, target, handlers[name]);
        }

        public static function createCSS(className:String, color:Number,
            fontName:String, fontSize:Object, align:String, bold:Boolean, italic:Boolean):String
        {
            return "." + className + " {" +
                "color:" + Utils.toHtmlColor(color) + ";" +
                "font-family:\"" + fontName + "\";" +
                "font-size:" + fontSize + ";" +
                "text-align:" + align + ";" +
                "font-weight:" + (bold ? "bold" : "normal") + ";" +
                "font-style:" + (italic ? "italic" : "normal") + ";" +
                "}";
        }

        public static function createStyleSheet(css:String):StyleSheet
        {
            var style:StyleSheet = new StyleSheet();
            style.parseCSS(css);
            return style;
        }

        // Tooltips

        private static function showTooltip(e:Object):void
        {
            var b:* = e.target;
            if (b.tooltipText)
                App.toolTipMgr.showComplex(b.tooltipText);
        }

        private static function hideTooltip(e:Object):void
        {
            App.toolTipMgr.hide();
        }
    }
}
