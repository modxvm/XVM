/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>, wotunion <http://www.koreanrandom.com/forum/user/27262-wotunion/>
 */

import com.xvm.*;
import TextField.StyleSheet;
import wot.battle.BIChances;

    class wot.battle.BattleLabels {

        public static var _BattleLabels:Object = {};
        public var f: TextField;
     
        public function BattleLabels(InstanceIndex: Number) 
        {
            var BLCfg:Object = BattleLabels._BattleLabels.formats[InstanceIndex];
            
            BattleLabels._BattleLabels.__IntervalCount[InstanceIndex] = 0;
            f = _root.xvm_holder.createTextField("bl" + InstanceIndex, 
                _root.xvm_holder.getNextHighestDepth(),
                HVAlign(BLCfg.align, BLCfg.width, false) + Macros.FormatGlobalNumberValue(BLCfg.x),
                HVAlign(BLCfg.valign, BLCfg.height, true) + Macros.FormatGlobalNumberValue(BLCfg.y),
                Macros.FormatGlobalNumberValue(BLCfg.width), 
                Macros.FormatGlobalNumberValue(BLCfg.height));
            f._alpha = Macros.FormatGlobalNumberValue(BLCfg.alpha);
            f._xscale = Macros.FormatGlobalNumberValue(BLCfg.scaleX);
            f._yscale = Macros.FormatGlobalNumberValue(BLCfg.scaleY);
            f._rotation = Macros.FormatGlobalNumberValue(BLCfg.rotation);
            f.selectable = false;
            f.antiAliasType = BLCfg.antiAliasType != null ? BLCfg.antiAliasType : "advanced";
            f.multiline = true;
            f.condenseWhite = true;
            f.border = BLCfg.borderColor != null;
            f.borderColor = Macros.FormatGlobalNumberValue(BLCfg.borderColor);
            f.background = BLCfg.bgColor != null;
            f.backgroundColor = Macros.FormatGlobalNumberValue(BLCfg.bgColor);
            f.autoSize = BLCfg.autoSize != null ? BLCfg.autoSize : "none";
            f.html = true;

            // style temp vars
            var currentFieldDefaultStyleColor: Number = Macros.FormatGlobalNumberValue(BLCfg.currentFieldDefaultStyle.color);
            var currentFieldDefaultStyleName: String = Macros.FormatGlobalStringValue(BLCfg.currentFieldDefaultStyle.name);
            var currentFieldDefaultStyleSize: Number = Macros.FormatGlobalNumberValue(BLCfg.currentFieldDefaultStyle.size);
            var currentFieldDefaultStyleAlign: String = Macros.FormatGlobalStringValue(BLCfg.currentFieldDefaultStyle.align);
            var currentFieldDefaultStyleBold: Boolean = Macros.FormatGlobalBooleanValue(BLCfg.currentFieldDefaultStyle.bold);
            var currentFieldDefaultStyleItalic: Boolean = Macros.FormatGlobalBooleanValue(BLCfg.currentFieldDefaultStyle.italic);
            var currentFieldDefaultStyleDisplay: String = Macros.FormatGlobalStringValue(BLCfg.currentFieldDefaultStyle.display);
            var currentFieldDefaultStyleLeading: Number = Macros.FormatGlobalNumberValue(BLCfg.currentFieldDefaultStyle.leading);
            var currentFieldDefaultStyleMarginLeft: Number = Macros.FormatGlobalNumberValue(BLCfg.currentFieldDefaultStyle.marginLeft);
            var currentFieldDefaultStyleMarginRight: Number = Macros.FormatGlobalNumberValue(BLCfg.currentFieldDefaultStyle.marginRight);
            // shadow temp vars
            var shadowDistance: Number = Macros.FormatGlobalNumberValue(BLCfg.shadow.distance);
            var shadowAngle: Number = Macros.FormatGlobalNumberValue(BLCfg.shadow.angle);
            var shadowColor: Number = Macros.FormatGlobalNumberValue(BLCfg.shadow.color);
            var shadowAlpha: Number = Macros.FormatGlobalNumberValue(BLCfg.shadow.alpha);
            var shadowBlurX: Number = Macros.FormatGlobalNumberValue(BLCfg.shadow.blur);
            var shadowBlurY: Number = Macros.FormatGlobalNumberValue(BLCfg.shadow.blur);
            var shadowStrength: Number = Macros.FormatGlobalNumberValue(BLCfg.shadow.strength);



            f.styleSheet = Utils.createStyleSheet(createCSSExtended("class" + InstanceIndex,
                !isNaN(currentFieldDefaultStyleColor) ? currentFieldDefaultStyleColor : 0xFFFFFF,
                currentFieldDefaultStyleName != null ? currentFieldDefaultStyleName : "$FieldFont", 
                !isNaN(currentFieldDefaultStyleSize) ? currentFieldDefaultStyleSize : 12,
                currentFieldDefaultStyleAlign != null ? currentFieldDefaultStyleAlign : "left",
                currentFieldDefaultStyleBold != null ? currentFieldDefaultStyleBold : false,
                currentFieldDefaultStyleItalic != null ? currentFieldDefaultStyleItalic : false,
                currentFieldDefaultStyleDisplay != null ? currentFieldDefaultStyleDisplay : "block",
                !isNaN(currentFieldDefaultStyleLeading) ? currentFieldDefaultStyleLeading : 0,
                !isNaN(currentFieldDefaultStyleMarginLeft) ? currentFieldDefaultStyleMarginLeft : 0,
                !isNaN(currentFieldDefaultStyleMarginRight) ? currentFieldDefaultStyleMarginRight : 0)
            );
            
            f.filters = [new flash.filters.DropShadowFilter(
                !isNaN(shadowDistance) ? shadowDistance : 0, 
                !isNaN(shadowAngle) ? shadowAngle : 0, 
                !isNaN(shadowColor) ? shadowColor : 0x000000, 
                !isNaN(shadowAlpha) ? shadowAlpha : 0.75, 
                !isNaN(shadowBlurX) ? shadowBlurX : 2, 
                !isNaN(shadowBlurY) ? shadowBlurY : 2, 
                !isNaN(shadowStrength) ? shadowStrength : 1)
            ];
                BattleLabels._BattleLabels.__isCreated = true;
                BattleLabels._BattleLabels.__intervalID[InstanceIndex] = setInterval(function() {
                BattleLabels._BattleLabels.__IntervalCount++;
                BattleLabels.UpdateBattleLabels(InstanceIndex);
               }, 2000);
        }
    
        public static function UpdateBattleLabels(InstanceIndex: Number) 
        {
            if (BattleLabels._BattleLabels.__isCreated == undefined) 
            {
                return;
            }
            var BattleLabelsHTML: String = Macros.FormatGlobalStringValue(BattleLabels._BattleLabels.formats[InstanceIndex].formats);
            if (((BattleLabelsHTML != "") && (BattleLabels._BattleLabels.__isClearedInterval[InstanceIndex] != "true")) || (BattleLabels._BattleLabels.__IntervalCount > 5)) 
            {
                clearInterval(BattleLabels._BattleLabels.__intervalID[InstanceIndex]);
                BattleLabels._BattleLabels.__isClearedInterval[InstanceIndex] = "true";
            }
            if BattleLabelsHTML == "" 
            {
                BattleLabels._BattleLabels.__instance[InstanceIndex][0].f.htmlText = '';
            }
            else 
            {
                BattleLabels._BattleLabels.__instance[InstanceIndex][0].f.htmlText = "<p class='class" + InstanceIndex + "'>" + BattleLabelsHTML + "</p>";
            }
        }

        public static function createTextFields() 
        { 
            BattleLabels._BattleLabels.formats = new Array;
            BattleLabels._BattleLabels.__isClearedInterval = new Array;
            BattleLabels._BattleLabels.__intervalID = new Array;
            BattleLabels._BattleLabels.__IntervalCount = new Array;
            var formats:Array = Config.config.battleLabelsList.formats;
            BattleLabels._BattleLabels.formats = formats;
            if (formats) 
            {
                var l:Number = formats.length;
                BattleLabels._BattleLabels.FieldsCount = l;
                BattleLabels._BattleLabels.EnabledFieldsCount = 0;
                BattleLabels._BattleLabels.UpdateableFieldsCount = 0;
                BattleLabels._BattleLabels.__instance = new Array([],[]);
                for (var i:Number = 0; i < l; ++i) 
                {
                    if (formats[i].enabled) 
                    {
                        BattleLabels._BattleLabels.__instance[i][0]  = new BattleLabels(i);
                        BattleLabels._BattleLabels.__instance[i][1]  = true;
                        if formats[i].updateEvent != "" 
                        {
                        BattleLabels._BattleLabels.__instance[i][2]  = formats[i].updateEvent;
                        BattleLabels._BattleLabels.UpdateableFieldsCount++;
                        }
                        BattleLabels._BattleLabels.EnabledFieldsCount++;
                    }
                }
            }
        }            

        private static function HVAlign(align, WidthOrHeight: Number, isValign: Boolean) 
        {
        //'align' allows only 'left', 'right', 'center' values for horizontal alignment and 'top', 'bottom', 'middle' for vertical
            switch (align) {  
                case 'left':  
                    return 0;  
                case 'right' :  
                    return Stage.width - WidthOrHeight;    
                case 'center': 
                    if (!isValign){ 
                      return (Stage.width/2) - (WidthOrHeight/2);  
                    }
                    else {
                      return (Stage.height/2) - (WidthOrHeight/2);
                    }
                case 'top':  
                    return 0;  
                case 'bottom':  
                    return Stage.height - WidthOrHeight;  
                case 'middle':  
                    return (Stage.height/2) - (WidthOrHeight/2);  
            }

        }

        public static function createCSSExtended(className:String, color:Number, fontName:String, fontSize:Number, align:String, bold:Boolean, italic:Boolean, display:String, leading:Number, marginLeft:Number, marginRight:Number):String
        {
            return "." + className + " {" +
                "color:#" + Strings.padLeft(color.toString(16), 6, '0') + ";" +
                "font-family:\"" + fontName + "\";" +
                "font-size:" + fontSize + ";" +
                "text-align:" + align + ";" +
                "font-weight:" + (bold ? "bold" : "normal") + ";" +
                "font-style:" + (italic ? "italic" : "normal") + ";" +
                "display:" + (display ? "display" : "inline") + ";" +
                "leading:" + leading + ";" +
                "margin-left:" + marginLeft + ";" +
                "margin-right:" + marginRight + ";" +
                "}";
        }

        public static function init()  
        {
            if (Config.config.battle.winChancesOnBattleInterface.enabled && Config.networkServicesSettings.chance && (!Config.config.battle.winChancesOnBattleInterface.disableStatic || (Config.networkServicesSettings.chanceLive && !Config.config.battle.winChancesOnBattleInterface.disableLive)))
                BIChances.init();
            if (!Config.config.battle.allowLabelsOnBattleInterface) 
            {
                return;
            }
            createTextFields();
        }
    }
