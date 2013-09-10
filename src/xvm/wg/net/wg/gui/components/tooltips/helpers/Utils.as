package net.wg.gui.components.tooltips.helpers 
{
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.filters.*;
    import flash.text.*;
    import net.wg.gui.components.controls.*;
    import net.wg.gui.components.tooltips.*;
    import net.wg.gui.components.tooltips.VO.*;
    
    public class Utils extends Object
    {
        public function Utils()
        {
            super();
            if (__allowInstantiation) ;
            return;
        }

        public function getIcont(arg1:String, arg2:String="", arg3:Boolean=false, arg4:Boolean=false):String
        {
            var loc1:*=net.wg.gui.components.controls.IconText.EMPTY;
            var loc2:*=arg1;
            switch (loc2) 
            {
                case "xp":
                    loc1 = arg4 ? net.wg.gui.components.controls.IconText.ELITE_XP : net.wg.gui.components.controls.IconText.XP;
                    break;
                case "doubleXPFactor":
                    loc1 = net.wg.gui.components.controls.IconText.DOUBLE_XP_FACTOR;
                    break;
                case "actionXPFactor":
                    loc1 = net.wg.gui.components.controls.IconText.ACTION_XP_FACTOR;
                    break;
                case "unlock_price":
                    loc1 = net.wg.gui.components.controls.IconText.XP_PRICE;
                    break;
                case "buy_price_action":
                    loc1 = arg3 ? net.wg.gui.components.controls.IconText.CREDITS : net.wg.gui.components.controls.IconText.GOLD;
                    break;
                case "buy_price":
                case "sell_price":
                    if (arg3 && arg2 == "shop" || arg2 == "hangar" && arg3) 
                        loc1 = net.wg.gui.components.controls.IconText.GOLD;
                    else 
                        loc1 = net.wg.gui.components.controls.IconText.CREDITS;
                    break;
                default:
                    loc1 = net.wg.gui.components.controls.IconText.EMPTY;
            }
            return loc1;
        }

        public function htmlWrapper(arg1:String, arg2:String="#ffffff", arg3:Number=12, arg4:String="$TextFont", arg5:Boolean=false, arg6:String=""):String
        {
            var loc1:*=(loc1 = (loc1 = (loc1 = "") + (arg4 != "" ? " face=\"" + arg4 + "\"" : "")) + (arg2 != "" ? " color=\"" + arg2 + "\"" : "")) + (arg3 ? " size=\"" + arg3 + "\"" : "");
            arg1 = "<font" + loc1 + ">" + arg1 + "</font>";
            if (arg5) 
                arg1 = "<b>" + arg1 + "</b>";
            return arg1 + arg6;
        }

        public function convertStringColorToNumber(arg1:String):Number
        {
            return Number("0x" + arg1.slice(1));
        }

        public function createBlock(arg1:net.wg.gui.components.tooltips.VO.ToolTipBlockVO, arg2:Number):net.wg.gui.components.tooltips.VO.ToolTipBlockResultVO
        {
            var loc6:*=NaN;
            var loc14:*=null;
            var loc15:*=null;
            var loc16:*=null;
            var loc1:*=0;
            var loc2:*=new flash.text.TextFormat();
            var loc3:*=0;
            var loc4:*="$TextFont";
            var loc5:*=false;
            loc6 = 0;
            var loc7:*=new Vector.<net.wg.gui.components.controls.IconText>();
            var loc8:*=[];
            var loc9:*=null;
            var loc10:*=null;
            if (arg1.header) 
            {
                loc10 = new flash.text.TextField();
                loc2.leading = -3;
                loc2.align = flash.text.TextFormatAlign.LEFT;
                (loc10 = new flash.text.TextField()).name = arg1.childrenNamePrefix + "_header";
                loc10.x = arg2;
                loc10.y = arg1.startYPos;
                loc10.width = 800;
                loc10.height = 10;
                loc10.autoSize = flash.text.TextFormatAlign.LEFT;
                loc10.multiline = true;
                loc10.htmlText = this.htmlWrapper(arg1.header, this.COLOR_BLOCK_HEADER, 14, "$TitleFont", true);
                loc10.setTextFormat(loc2);
                loc10.width = loc10.textWidth;
                loc6 = Math.max(loc6, loc10.width);
                arg1.contener.addChild(loc10);
                arg1.startYPos = arg1.startYPos + (loc10.textHeight + 12 ^ 0);
            }
            loc2.leading = 2;
            loc2.align = flash.text.TextFormatAlign.RIGHT;
            loc2.size = 11;
            loc2.font = loc4;
            var loc11:*=0;
            var loc12:*=arg1.startYPos;
            (loc9 = new flash.text.TextField()).name = arg1.childrenNamePrefix + "_left";
            loc9.x = arg2;
            loc9.y = loc12;
            loc9.width = 300;
            loc9.height = 10;
            loc9.autoSize = flash.text.TextFormatAlign.RIGHT;
            loc9.multiline = true;
            loc9.wordWrap = true;
            loc9.htmlText = arg1.leftText;
            loc9.setTextFormat(loc2);
            loc9.height = loc9.textHeight + 6;
            loc9.width = loc9.textWidth + 5 > this.LEFT_TEXTFIELD_MIN_WIDTH ? loc9.textWidth + 5 : this.LEFT_TEXTFIELD_MIN_WIDTH;
            loc1 = Math.max(loc9.width, loc1);
            loc6 = Math.max(loc6, loc1);
            loc11 = loc9.getLineMetrics(0).height + loc2.leading + 0.3;
            arg1.contener.addChild(loc9);
            var loc13:*=arg1.rightTextList.length;
            loc3 = 0;
            while (loc3 < loc13) 
            {
                (loc14 = App.utils.classFactory.getComponent("IconText", net.wg.gui.components.controls.IconText)).name = arg1.childrenNamePrefix + "_iconText_" + loc3;
                loc14.x = arg2 + this.LEFT_TEXTFIELD_MIN_WIDTH + this.MARGIN_BEETWEEN_LEFT_AND_RIGHT_BLOCKS;
                loc14.y = Math.round(loc12);
                loc14.textAlign = flash.text.TextFormatAlign.LEFT;
                loc14.textColor = arg1.rightTextColor;
                loc14.iconPosition = flash.text.TextFormatAlign.LEFT;
                loc14.textFont = loc4;
                loc14.textSize = 11;
                loc14.textFieldYOffset = 0;
                if (arg1.rightTextCSS) 
                    loc14.css = arg1.rightTextCSS;
                loc15 = net.wg.gui.components.tooltips.VO.ToolTipBlockRightListItemVO(arg1.rightTextList[loc3]);
                loc14.xCorrect = loc15.textXOffset;
                loc14.icon = loc15.icon;
                loc14.text = loc15.text;
                loc14.textField.htmlText = loc15.text;
                loc14.textField.width = loc14.textField.textWidth + 4;
                loc14.iconClip.y = loc15.textYOffset;
                loc14.validateNow();
                if (!(loc14.iconClip.currentFrame == 1) && !loc5) 
                    loc5 = true;
                loc12 = loc12 + loc11;
                arg1.contener.addChild(loc14);
                loc7.push(loc14);
                ++loc3;
            }
            if (!loc5) 
            {
                loc13 = loc7.length;
                loc3 = 0;
                while (loc3 < loc13) 
                {
                    (loc16 = loc7[loc3]).xCorrect = -17;
                    loc16.validateNow();
                    loc6 = Math.max(loc6, loc16.x + loc16.textField.x + loc16.textField.width);
                    ++loc3;
                }
            }
            arg1.startYPos = Math.round(loc12) + this.MARGIN_AFTER_BLOCK;
            return new net.wg.gui.components.tooltips.VO.ToolTipBlockResultVO(arg1.startYPos, loc9, loc7, loc8, loc10, loc5, loc1, loc6);
        }

        public function getStatusColor(arg1:String):net.wg.gui.components.tooltips.VO.ToolTipStatusColorsVO
        {
            var loc1:*=new net.wg.gui.components.tooltips.VO.ToolTipStatusColorsVO();
            var loc2:*=0;
            var loc3:*=0;
            var loc4:*=0;
            var loc5:*=0;
            var loc7:*=arg1;
            switch (loc7) 
            {
                case this.STATUS_ADDITIONAL:
                    loc1.textColor = 16761699;
                    loc1.filters = [];
                    return loc1;
                case this.STATUS_CRITICAL:
                    loc1.textColor = 16721687;
                    loc2 = 16711680;
                    loc3 = 0.5;
                    loc4 = 0.27;
                    loc5 = 11;
                    break;
                case this.STATUS_WARNING:
                    loc1.textColor = 16117989;
                    loc2 = 15521204;
                    loc3 = 0.3;
                    loc4 = 0.11;
                    loc5 = 11;
                    break;
                case this.STATUS_INFO:
                default:
                    loc1.textColor = 8041216;
                    loc2 = 3997440;
                    loc3 = 0.5;
                    loc4 = 0.24;
                    loc5 = 11;
                    break;
            }
            loc1.filters = [];
            var loc6:*;
            (loc6 = new flash.filters.DropShadowFilter()).distance = 0;
            loc6.angle = 0;
            loc6.color = loc2;
            loc6.alpha = loc4;
            loc6.blurX = loc5;
            loc6.blurY = loc5;
            loc6.strength = loc3;
            loc6.quality = 3;
            loc6.inner = false;
            loc6.knockout = false;
            loc6.hideObject = false;
            loc1.filters.push(loc6);
            return loc1;
        }

        public function createSeparate(arg1:flash.display.MovieClip):net.wg.gui.components.tooltips.Separator
        {
            var loc1:*=App.utils.classFactory.getComponent("SeparatorUI", net.wg.gui.components.tooltips.Separator);
            arg1.addChild(loc1);
            return loc1;
        }

        public static function get instance():net.wg.gui.components.tooltips.helpers.Utils
        {
            if (!__instance) 
            {
                __allowInstantiation = true;
                __instance = new Utils();
                __allowInstantiation = false;
            }
            return __instance;
        }

        
        {
            __allowInstantiation = false;
        }

        public const COLOR_HEADER:String="#fdf4ce";

        public const COLOR_BLOCK_HEADER:String="#4c4b41";

        public const COLOR_NUMBER:String="#d3d3ca";

        public const COLOR_ALERT:String="#ff0000";

        public const COLOR_NORMAL:String="#7b7969";

        public const COLOR_SUB_NORMAL:String="#4c4b41";

        public const COLOR_ADD_INFO:String="#ccad77";

        public const STATUS_ADDITIONAL:String="additional";

        public const STATUS_CRITICAL:String="critical";

        public const STATUS_WARNING:String="warning";

        public const STATUS_INFO:String="info";

        internal const LEFT_TEXTFIELD_MIN_WIDTH:Number=54;

        public const MARGIN_AFTER_BLOCK:Number=15;

        public const MARGIN_BEETWEEN_LEFT_AND_RIGHT_BLOCKS:Number=3;

        public const MARGIN_AFTER_SEPARATE:Number=11;

        internal static var __instance:net.wg.gui.components.tooltips.helpers.Utils;

        internal static var __allowInstantiation:Boolean=false;
    }
}
