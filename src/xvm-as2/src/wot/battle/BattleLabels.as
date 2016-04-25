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
        public function BattleLabels(instanceIndex: Number) 
        {
            var BLCfg:Object = BattleLabels.BoX.formats[instanceIndex];

            // temp vars
            //////////////////////////////////////////////////////////////////////////////////
            var shadowBlur: Number = Macros.FormatGlobalNumberValue(BLCfg.shadow.blur, 2);
            var BLCfg_width: Number = Macros.FormatGlobalNumberValue(BLCfg.width, 0);
            var BLCfg_height: Number = Macros.FormatGlobalNumberValue(BLCfg.height, 0);
            var BLCfg_borderColor: Number = Macros.FormatGlobalNumberValue(BLCfg.borderColor, null);
            var BLCfg_bgColor: Number = Macros.FormatGlobalNumberValue(BLCfg.bgColor, null);

            // instance create TextField on holder "xvm_holder" at depth level: -16368 
            f = _root.xvm_holder.createTextField("bl" + instanceIndex, 
                _root.xvm_holder.getNextHighestDepth(),
                Utils.HVAlign(Macros.FormatGlobalStringValue(BLCfg.align, "left"), BLCfg_width, false) + Macros.FormatGlobalNumberValue(BLCfg.x, 0),
                Utils.HVAlign(Macros.FormatGlobalStringValue(BLCfg.valign, "top"), BLCfg_height, true) + Macros.FormatGlobalNumberValue(BLCfg.y, 0),
                BLCfg_width, 
                BLCfg_height
            );
            
            // instance properties
            //////////////////////////////////////////////////////////////////////////////////
            f._alpha = Macros.FormatGlobalNumberValue(BLCfg.alpha, 100);
            f._xscale = Macros.FormatGlobalNumberValue(BLCfg.scaleX, 100);
            f._yscale = Macros.FormatGlobalNumberValue(BLCfg.scaleY, 100);
            f._rotation = Macros.FormatGlobalNumberValue(BLCfg.rotation, 0);
            f.selectable = false;
            f.antiAliasType = Macros.FormatGlobalStringValue(BLCfg.antiAliasType, "advanced");
            f.multiline = true;
            f.condenseWhite = true;
            f.border = BLCfg_borderColor != null;
            f.borderColor = BLCfg_borderColor;
            f.background = BLCfg_bgColor != null;
            f.backgroundColor = BLCfg_bgColor;
            f.autoSize = Macros.FormatGlobalStringValue(BLCfg.autoSize, "left");
            f.html = true;
            //////////////////////////////////////////////////////////////////////////////////
           
            // instance property styleSheet / config: currentFieldDefaultStyle
            f.styleSheet = Utils.createStyleSheet(Utils.createCSSExtended("class" + instanceIndex,
                Macros.FormatGlobalNumberValue(BLCfg.currentFieldDefaultStyle.color, 0xFFFFFF),
                Macros.FormatGlobalStringValue(BLCfg.currentFieldDefaultStyle.name, "$FieldFont"), 
                Macros.FormatGlobalNumberValue(BLCfg.currentFieldDefaultStyle.size, 12),
                Macros.FormatGlobalStringValue(BLCfg.currentFieldDefaultStyle.align, "left"),
                Macros.FormatGlobalBooleanValue(BLCfg.currentFieldDefaultStyle.bold, false),
                Macros.FormatGlobalBooleanValue(BLCfg.currentFieldDefaultStyle.italic, false),
                Macros.FormatGlobalBooleanValue(BLCfg.currentFieldDefaultStyle.underline, false),
                Macros.FormatGlobalStringValue(BLCfg.currentFieldDefaultStyle.display, "block"),
                Macros.FormatGlobalNumberValue(BLCfg.currentFieldDefaultStyle.leading, 0),
                Macros.FormatGlobalNumberValue(BLCfg.currentFieldDefaultStyle.marginLeft, 0),
                Macros.FormatGlobalNumberValue(BLCfg.currentFieldDefaultStyle.marginRight, 0))
            );
            
            // instance property filter / config: shadow 
            f.filters = [new flash.filters.DropShadowFilter(
                Macros.FormatGlobalNumberValue(BLCfg.shadow.distance, 0), 
                Macros.FormatGlobalNumberValue(BLCfg.shadow.angle, 0), 
                Macros.FormatGlobalNumberValue(BLCfg.shadow.color, 0x000000), 
                Macros.FormatGlobalNumberValue(BLCfg.shadow.alpha * 0.01, 0.75), 
                shadowBlur, 
                shadowBlur, 
                Macros.FormatGlobalNumberValue(BLCfg.shadow.strength, 1))
            ];
                
                // set flag that indicates creation of even one class instance
                BattleLabels.BoX.__isCreated = true;
                // setting invisibilty for all text fields; it wil be modified in this for non hotKey-assigned fields
                f._visible = false;
                if ((BattleLabels.BoX.formats[instanceIndex].hotKeyCode == null) || (BattleLabels.BoX.formats[instanceIndex].hotKeyCode == ""))
                {
                    // Logger.add("Instance has no hotKey assigned, applying HTML");
                    // apply html text to text field except field with hotKey assigned
                    var curFormat: String = BattleLabels.BoX.formats[instanceIndex].format;
                    var BattleLabelsHTML: String = curFormat != null ? Macros.Format(Config.myPlayerName, curFormat, {}) : "";
                    f.htmlText = "<p class='class" + instanceIndex + "'>" + BattleLabelsHTML + "</p>";
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
            var curFormat: String = BattleLabels.BoX.formats[instanceIndex].format;
            var BattleLabelsHTML: String = curFormat != null ? Macros.Format(Config.myPlayerName, curFormat, {}) : "";
            BattleLabels.BoX.__instance[instanceIndex].f.htmlText  = "<p class='class" + instanceIndex + "'>" + BattleLabelsHTML + "</p>";
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
                    var curOnHold: Boolean = BattleLabels.BoX.formats[BattleLabels.BoX.HotKeyedTextFieldIndexes[i]].onHold;
                    switch curOnHold != null ? curOnHold : false
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
                case "ON_BATTLE_STATE_CHANGED":
                    //Logger.add("Added listener: " + eventName);
                    GlobalEventDispatcher.addEventListener(Events.E_BATTLE_STATE_CHANGED, BattleLabels.UpdateBattleLabels(eventName), BattleLabels.UpdateBattleLabels(eventName));
                    break;
                case "ON_PLAYERS_HP_CHANGED":
                    //Logger.add("Added listener: " + eventName);
                    GlobalEventDispatcher.addEventListener(Defines.E_PLAYERS_HP_CHANGED, BattleLabels.UpdateBattleLabels(eventName), BattleLabels.UpdateBattleLabels(eventName));
                    break;           
                case "ON_VEHICLE_DESTROYED":
                    //Logger.add("Added listener: " + eventName);
                    GlobalEventDispatcher.addEventListener(Defines.E_PLAYER_DEAD, BattleLabels.UpdateBattleLabels(eventName), BattleLabels.UpdateBattleLabels(eventName));
                    break;
                case "ON_CURRENT_VEHICLE_DESTROYED":
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
