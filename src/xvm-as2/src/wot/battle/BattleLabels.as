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
            f = _root.xvm_holder.createTextField("bl" + String(InstanceIndex), 
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
            var currentFieldDefaultStyleColor:Number = int(Macros.FormatGlobalStringValue(BLCfg.currentFieldDefaultStyle.color));
            f.styleSheet = Utils.createStyleSheet(createCSSExtended("class" + String(InstanceIndex),
                !isNaN(currentFieldDefaultStyleColor) ? currentFieldDefaultStyleColor : 0xFFFFFF,
                Macros.FormatGlobalStringValue(BLCfg.currentFieldDefaultStyle.name) != null ?  BLCfg.currentFieldDefaultStyle.name : "$FieldFont", 
                Macros.FormatGlobalNumberValue(BLCfg.currentFieldDefaultStyle.size) != null ? BLCfg.currentFieldDefaultStyle.size : 12,
                BLCfg.currentFieldDefaultStyle.align != null ? BLCfg.currentFieldDefaultStyle.align : "left",
                BLCfg.currentFieldDefaultStyle.bold != null ? BLCfg.currentFieldDefaultStyle.bold : false,
                BLCfg.currentFieldDefaultStyle.italic != null ? BLCfg.currentFieldDefaultStyle.italic : false,
                BLCfg.currentFieldDefaultStyle.display != null ? BLCfg.currentFieldDefaultStyle.display : "block",
                BLCfg.currentFieldDefaultStyle.leading != null ? BLCfg.currentFieldDefaultStyle.leading : 0,
                BLCfg.currentFieldDefaultStyle.marginLeft != null ? BLCfg.currentFieldDefaultStyle.marginLeft : 0,
                BLCfg.currentFieldDefaultStyle.marginRight != null ? BLCfg.currentFieldDefaultStyle.marginRight : 0));
                f.filters = [new flash.filters.DropShadowFilter(
                    BLCfg.shadow.distance != null ? BLCfg.shadow.distance : 0, 
                    BLCfg.shadow.angle != null ? BLCfg.shadow.angle : 0, 
                    int(BLCfg.shadow.color) != null ? int(BLCfg.shadow.color) : 0x000000, 
                    BLCfg.shadow.alpha != null ? BLCfg.shadow.alpha : 0.75, 
                    BLCfg.shadow.blur != null ? BLCfg.shadow.blur : 2, 
                    BLCfg.shadow.blur != null ? BLCfg.shadow.blur : 2, 
                    BLCfg.shadow.strength != null ? BLCfg.shadow.strength : 1)
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
                BattleLabels._BattleLabels.__instance[InstanceIndex][0].f.htmlText = "<p class='class" + String(InstanceIndex) + "'>" + BattleLabelsHTML + "</p>";
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
