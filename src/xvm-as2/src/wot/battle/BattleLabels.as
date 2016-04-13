/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>, wotunion <http://www.koreanrandom.com/forum/user/27262-wotunion/>
 */

import com.xvm.*;
import com.xvm.events.*;

    class wot.battle.BattleLabels {

        public static var BoX:Object = {};
        public var f: TextField;
        
        // assign properties to class instances
        public function BattleLabels(InstanceIndex: Number) 
        {
            var BLCfg:Object = BattleLabels.BoX.formats[InstanceIndex];

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
                
                // set flag that indicates creation of even one class instance
                BattleLabels.BoX.__isCreated = true;
                // setting invisibilty for all text fields; it wil be modified in this for non hotKey-assigned fields
                f._visible = false;
                
                if ((BattleLabels.BoX.formats[InstanceIndex].hotKeyCode == null) || (BattleLabels.BoX.formats[InstanceIndex].hotKeyCode == ""))
                {
                    // Logger.add("Instance has no hotKey assigned, applying HTML");
                    // apply html text to text field except field with hotKey assigned
                    var BattleLabelsHTML: String = Macros.Format(Config.myPlayerName, BattleLabels.BoX.formats[InstanceIndex].formats, {});
                    f.htmlText = "<p class='class" + InstanceIndex + "'>" + BattleLabelsHTML + "</p>";
                    f._visible = true;
                }
        }
        
        // updates text fields on matching event, called on events dispatch !key event dispatch
        // updates only fields which is visible, invisible fields updates only on click or one time on hold by hotKey i.e. does not updates in background 
        private static function UpdateBattleLabels(eventName: String):Function 
        {
            return function(e:Object):Void 
            {
                if (BattleLabels.BoX.__isCreated == undefined) 
                    return;
                //Logger.add("Update on eventName " + eventName);    
                for (var i:Number = 0; i < BattleLabels.BoX.UpdateableFieldsCount; ++i)
                {
                    if ((BattleLabels.BoX.formats[BattleLabels.BoX.UpdateableTextFieldsIndexes[i]].updateEvent == eventName) && 
                        (BattleLabels.BoX.__instance[BattleLabels.BoX.UpdateableTextFieldsIndexes[i]].f._visible == true)) 
                    {
                        BattleLabels.doUpdateBattleLabels(BattleLabels.BoX.UpdateableTextFieldsIndexes[i]);
                    }
                }
            };
        }

        // updates field with defined instance index
        private static function doUpdateBattleLabels(instanceIndex: Number)
        {
            BattleLabels.BoX.__instance[instanceIndex].f.htmlText  = "<p class='class" + instanceIndex + "'>" + Macros.Format(Config.myPlayerName, BattleLabels.BoX.formats[instanceIndex].formats, {}) + "</p>";
            //Logger.add(BattleLabels.BoX.__instance[instanceIndex].f.htmlText);
        }

        // control hot keyed fields, called from key event listener
        private static function switchBattleLabels(e:Object):Void
        {
                //Logger.add("Key " + e.key);
                if (BattleLabels.BoX.__isCreated == undefined) 
                    return;
                for (var i:Number = 0; i < BattleLabels.BoX.HotKeyedTextFieldIndexesCount; ++i)   
                { 
                    switch (BattleLabels.BoX.formats[BattleLabels.BoX.HotKeyedTextFieldIndexes[i]].onHold)
                    {
                        // hold key
                        case true:
                            if ((BattleLabels.BoX.formats[BattleLabels.BoX.HotKeyedTextFieldIndexes[i]].hotKeyCode == e.key) && (e.isDown == true)) 
                            {
                                // update field one time on hold button, prevent numerous updates while holding button
                                if BattleLabels.BoX.HotKeyedTextFieldIndexesUpdateFlag[i] == false
                                {
                                    BattleLabels.doUpdateBattleLabels(BattleLabels.BoX.HotKeyedTextFieldIndexes[i]);
                                    //Logger.add("Updating hotkeyed text field for instance " + BattleLabels.BoX.HotKeyedTextFieldIndexes[i]);
                                    BattleLabels.BoX.__instance[BattleLabels.BoX.HotKeyedTextFieldIndexes[i]].f._visible = true;
                                    BattleLabels.BoX.HotKeyedTextFieldIndexesUpdateFlag[i] = true;  
                                }
                            }    
                            else if (BattleLabels.BoX.formats[BattleLabels.BoX.HotKeyedTextFieldIndexes[i]].hotKeyCode == e.key)
                            {
                                BattleLabels.BoX.__instance[BattleLabels.BoX.HotKeyedTextFieldIndexes[i]].f._visible = false;
                                BattleLabels.BoX.HotKeyedTextFieldIndexesUpdateFlag[i] = false;      
                            }
                            break;
                        //click key    
                        case false:
                            if ((BattleLabels.BoX.formats[BattleLabels.BoX.HotKeyedTextFieldIndexes[i]].hotKeyCode == e.key) && 
                                (BattleLabels.BoX.__instance[BattleLabels.BoX.HotKeyedTextFieldIndexes[i]].f._visible == false) && (e.isDown))
                            {
                                BattleLabels.doUpdateBattleLabels(BattleLabels.BoX.HotKeyedTextFieldIndexes[i]);
                                //Logger.add("Updating hotkeyed text field for instance " + BattleLabels.BoX.HotKeyedTextFieldIndexes[i]);
                                BattleLabels.BoX.__instance[BattleLabels.BoX.HotKeyedTextFieldIndexes[i]].f._visible = true;
                            }
                            else if ((BattleLabels.BoX.__instance[BattleLabels.BoX.HotKeyedTextFieldIndexes[i]].f._visible == true) && (BattleLabels.BoX.formats[BattleLabels.BoX.HotKeyedTextFieldIndexes[i]].hotKeyCode == e.key) && (e.isDown)) 
                            {
                                BattleLabels.BoX.__instance[BattleLabels.BoX.HotKeyedTextFieldIndexes[i]].f._visible = false;
                            }
                            break;
                    }
                }
        }
        
        // create instances of all enabled text fields, logs instance indices of updateable text fields 
        private static function createTextFields()
        { 
            BattleLabels.BoX.formats = new Array([]);
            var formats:Array = Config.config.battleLabels.formats;
            BattleLabels.BoX.formats = formats;
            
            if (formats) 
            {
                var l:Number = formats.length;
                BattleLabels.BoX.EnabledFieldsCount = 0;
                BattleLabels.BoX.UpdateableFieldsCount = 0;
                BattleLabels.BoX.UpdateableTextFieldsIndexes = new Array([]);
                BattleLabels.BoX.HotKeyedTextFieldIndexesCount = 0;
                BattleLabels.BoX.HotKeyedTextFieldIndexes = new Array([]);
                BattleLabels.BoX.IsHotKeyedTextFieldsFlag = false;
                BattleLabels.BoX.HotKeyedTextFieldIndexesUpdateFlag = new Array([]);
                BattleLabels.BoX.__instance = new Array([]);
                var listenersCache = new Array([]);
                
                for (var i:Number = 0; i < l; ++i) 
                {
                    if (formats[i].enabled) 
                    {
                        BattleLabels.BoX.__instance[i]  = new BattleLabels(i);
                        BattleLabels.BoX.EnabledFieldsCount++;
                        if (formats[i].updateEvent != null && formats[i].updateEvent != "")
                        {
                            BattleLabels.BoX.UpdateableTextFieldsIndexes[BattleLabels.BoX.UpdateableFieldsCount] = i;
                            if BattleLabels.BoX.__listenersCache[formats[i].updateEvent] == undefined 
                            {
                                BattleLabels.setListeners(formats[i].updateEvent);
                                listenersCache[formats[i].updateEvent] = formats[i].updateEvent;
                                //Logger.add("Set listeners cache for " + i + " " + listenersCache[formats[i].updateEvent]);
                            }
                            BattleLabels.BoX.UpdateableFieldsCount++;
                        }
                        if (formats[i].hotKeyCode != null && formats[i].hotKeyCode != "")
                        {
                            BattleLabels.BoX.HotKeyedTextFieldIndexes[BattleLabels.BoX.HotKeyedTextFieldIndexesCount] = i;
                            BattleLabels.BoX.HotKeyedTextFieldIndexesUpdateFlag[BattleLabels.BoX.HotKeyedTextFieldIndexesCount] = false;
                            BattleLabels.BoX.HotKeyedTextFieldIndexesCount++;
                        }
                    }
                }
                if (BattleLabels.BoX.HotKeyedTextFieldIndexesCount > 0)
                {
                    // create listener for battleLabels key events dispatcher
                    GlobalEventDispatcher.addEventListener(Defines.E_BATTLE_LABEL_KEY_MODE, BattleLabels.switchBattleLabels, BattleLabels.switchBattleLabels);
                    // flag for battleLabels key events dispatcher
                    BattleLabels.BoX.IsHotKeyedTextFieldsFlag = true; 
                }
            }
        } 
        
        // adding listeners to field events, only one listener can be created for each event
        private static function setListeners(eventName: String)
        {
            switch (eventName)
            {
                case "ON_VECHICLE_DESTROYED":
                    //Logger.add("Added listener: " + eventName);
                    GlobalEventDispatcher.addEventListener(Defines.E_PLAYER_DEAD, BattleLabels.UpdateBattleLabels(eventName), BattleLabels.UpdateBattleLabels(eventName));
                    break;
                case "ON_BATTLE_STATE_CHANGED":
                    //Logger.add("Added listener: " + eventName);
                    GlobalEventDispatcher.addEventListener(Events.E_BATTLE_STATE_CHANGED, BattleLabels.UpdateBattleLabels(eventName), BattleLabels.UpdateBattleLabels(eventName));
                    break;
                case "ON_CURRENT_VECHICLE_DESTROYED":
                    //Logger.add("Added listener: " + eventName);
                    GlobalEventDispatcher.addEventListener(Defines.E_SELF_DEAD, BattleLabels.UpdateBattleLabels(eventName), BattleLabels.UpdateBattleLabels(eventName));
                    break;
                case "ON_MODULE_DESTROYED":
                    //Logger.add("Added listener: " + eventName);
                    GlobalEventDispatcher.addEventListener(Defines.E_MODULE_DESTROYED, BattleLabels.UpdateBattleLabels(eventName), BattleLabels.UpdateBattleLabels(eventName));
                    break;
                case "ON_MODULE_REPAIRED":
                    //Logger.add("Added listener: " + eventName);
                    GlobalEventDispatcher.addEventListener(Defines.E_MODULE_REPAIRED, BattleLabels.UpdateBattleLabels(eventName), BattleLabels.UpdateBattleLabels(eventName));
                    break;      
            }
        }           
        
        // init point, called from battleMain.as 
        public static function init() 
        {
            if (Config.config.battle.allowLabelsOnBattleInterface) 
               BattleLabels.createTextFields();
        }
    }
