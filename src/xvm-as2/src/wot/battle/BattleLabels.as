/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>, wotunion <http://www.koreanrandom.com/forum/user/27262-wotunion/>
 */

import com.xvm.*;

    class wot.battle.BattleLabels {

        public static var _BattleLabels:Object = {};
        public var f: TextField;
     
        public function BattleLabels(InstanceIndex: Number) 
        // assign properties to class instances
        {
            var BLCfg:Object = BattleLabels._BattleLabels.formats[InstanceIndex];
            
            // instance create TextField on holder "xvm_holder" at depth level: -16368 
            f = _root.xvm_holder.createTextField("bl" + InstanceIndex, 
                _root.xvm_holder.getNextHighestDepth(),
                Utils.HVAlign(BLCfg.align, BLCfg.width, false) + Macros.FormatGlobalNumberValue(BLCfg.x),
                Utils.HVAlign(BLCfg.valign, BLCfg.height, true) + Macros.FormatGlobalNumberValue(BLCfg.y),
                Macros.FormatGlobalNumberValue(BLCfg.width), 
                Macros.FormatGlobalNumberValue(BLCfg.height)
            );
            
            // instance properties
            //////////////////////////////////////////////////////////////////////////////////
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
            //////////////////////////////////////////////////////////////////////////////////
            
            // style temp vars
            //////////////////////////////////////////////////////////////////////////////////
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
            //////////////////////////////////////////////////////////////////////////////////
            // shadow temp vars
            //////////////////////////////////////////////////////////////////////////////////
            var shadowDistance: Number = Macros.FormatGlobalNumberValue(BLCfg.shadow.distance);
            var shadowAngle: Number = Macros.FormatGlobalNumberValue(BLCfg.shadow.angle);
            var shadowColor: Number = Macros.FormatGlobalNumberValue(BLCfg.shadow.color);
            var shadowAlpha: Number = Macros.FormatGlobalNumberValue(BLCfg.shadow.alpha);
            var shadowBlurX: Number = Macros.FormatGlobalNumberValue(BLCfg.shadow.blur);
            var shadowBlurY: Number = Macros.FormatGlobalNumberValue(BLCfg.shadow.blur);
            var shadowStrength: Number = Macros.FormatGlobalNumberValue(BLCfg.shadow.strength);
            //////////////////////////////////////////////////////////////////////////////////

            // instance property styleSheet / config: currentFieldDefaultStyle
            f.styleSheet = Utils.createStyleSheet(Utils.createCSSExtended("class" + InstanceIndex,
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
           
            // instance property filter / config: shadow 
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

                // apply html text to text field
                var BattleLabelsHTML: String = Macros.Format(Config.myPlayerName, BattleLabels._BattleLabels.formats[InstanceIndex].formats, {});
                f.htmlText = "<p class='class" + InstanceIndex + "'>" + BattleLabelsHTML + "</p>";
        }
    
        public static function UpdateBattleLabels(eventName: String) 
        // updates text fields on matching event
        {
            if (BattleLabels._BattleLabels.__isCreated == undefined) 
                return;
            for (var i:Number = 0; i < BattleLabels._BattleLabels.UpdateableFieldsCount; ++i) 
                {
                    if (BattleLabels._BattleLabels.formats[BattleLabels._BattleLabels.UpdateableTextFieldsIndexes[i]].updateEvent == eventName)
                    {
                        BattleLabels._BattleLabels.__instance[BattleLabels._BattleLabels.UpdateableTextFieldsIndexes[i]].f.htmlText  = "<p class='class" + BattleLabels._BattleLabels.UpdateableTextFieldsIndexes[i] + "'>" + Macros.Format(Config.myPlayerName, BattleLabels._BattleLabels.formats[BattleLabels._BattleLabels.UpdateableTextFieldsIndexes[i]].formats, {}) + "</p>";
                    }
                }
        }

        public static function createTextFields()
        // create instances of all enabled text fields, logs instance indices of updateable text fields 
        { 
            BattleLabels._BattleLabels.formats = new Array([]);
            var formats:Array = Config.config.battleLabels.formats;
            BattleLabels._BattleLabels.formats = formats;
            if (formats) 
            {
                var l:Number = formats.length;
                BattleLabels._BattleLabels.UpdateableFieldsCount = 0;
                BattleLabels._BattleLabels.UpdateableTextFieldsIndexes = new Array([]);
                BattleLabels._BattleLabels.__instance = new Array([]);
                for (var i:Number = 0; i < l; ++i) 
                {
                    if (formats[i].enabled) 
                    {
                        BattleLabels._BattleLabels.__instance[i]  = new BattleLabels(i);
                        if (formats[i].updateEvent != null && formats[i].updateEvent != "")
                        {
                            BattleLabels._BattleLabels.UpdateableTextFieldsIndexes[BattleLabels._BattleLabels.UpdateableFieldsCount] = i;
                            BattleLabels._BattleLabels.UpdateableFieldsCount++;
                        }
                    }
                }
            }
        }            

        public static function init() 
        // init point, called from battleMain.as 
        {
            if (Config.config.battle.allowLabelsOnBattleInterface) 
                createTextFields();
        }
    }
