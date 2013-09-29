package net.wg.gui.lobby.settings 
{
    import flash.events.*;
    import flash.text.*;
    import net.wg.gui.components.advanced.*;
    import net.wg.gui.components.controls.*;
    import net.wg.gui.events.*;
    import net.wg.gui.lobby.settings.components.*;
    import net.wg.gui.lobby.settings.evnts.*;
    import net.wg.gui.lobby.settings.vo.*;
    import scaleform.clik.data.*;
    import scaleform.clik.events.*;
    import scaleform.clik.interfaces.*;
    
    public class ControlsSettings extends net.wg.gui.lobby.settings.SettingsBaseView
    {
        public function ControlsSettings()
        {
            super();
            return;
        }

        public override function update(arg1:Object):void
        {
            super.update(arg1);
            return;
        }

        public override function dispose():void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=null;
            super.dispose();
            if (this.defaultBtn.hasEventListener(scaleform.clik.events.ButtonEvent.CLICK)) 
            {
                this.defaultBtn.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onSetDefaultClick);
            }
            if (this.keys) 
            {
                this.keys.dispose();
                if (this.keys.hasEventListener(net.wg.gui.events.ListEventEx.ITEM_TEXT_CHANGE)) 
                {
                    this.keys.removeEventListener(net.wg.gui.events.ListEventEx.ITEM_TEXT_CHANGE, this.onKeyChange);
                }
            }
            if (_data) 
            {
                var loc5:*=0;
                var loc6:*=_data;
                label388: for (loc1 in loc6) 
                {
                    if (!(_data[loc1] is net.wg.gui.lobby.settings.vo.SettingsControlProp)) 
                    {
                        continue;
                    }
                    loc2 = net.wg.gui.lobby.settings.vo.SettingsControlProp(_data[loc1]);
                    if (!this[loc1 + loc2.type]) 
                    {
                        continue;
                    }
                    var loc7:*=loc2.type;
                    switch (loc7) 
                    {
                        case net.wg.gui.lobby.settings.SettingsConfig.TYPE_CHECKBOX:
                        {
                            loc3 = net.wg.gui.components.controls.CheckBox(this[loc1 + loc2.type]);
                            if (loc3.hasEventListener(flash.events.Event.SELECT)) 
                            {
                                loc3.removeEventListener(flash.events.Event.SELECT, this.onCheckBoxSelected);
                            }
                            continue label388;
                        }
                        case net.wg.gui.lobby.settings.SettingsConfig.TYPE_SLIDER:
                        {
                            if ((loc4 = net.wg.gui.components.controls.Slider(this[loc1 + loc2.type])).hasEventListener(scaleform.clik.events.SliderEvent.VALUE_CHANGE)) 
                            {
                                loc4.removeEventListener(scaleform.clik.events.SliderEvent.VALUE_CHANGE, this.onSliderValueChanged);
                            }
                            continue label388;
                        }
                    }
                }
            }
            return;
        }

        public override function toString():String
        {
            return "[WG ControlsSettings " + name + "]";
        }

        public function getKeyasDataProvider():scaleform.clik.interfaces.IDataProvider
        {
            return this.keys.dataProvider;
        }

        protected override function configUI():void
        {
            this.keyboardFieldSet.label = SETTINGS.KEYBOARD_KEYBOARD;
            this.mouseFieldSet.label = SETTINGS.KEYBOARD_MOUSE;
            this.mouseSensitivityLabel.text = SETTINGS.MOUSE_SENSITIVITY_HEADER;
            this.mouseArcadeSensLabel.text = SETTINGS.MOUSE_SENSITIVITY_MAIN;
            this.mouseSniperSensLabel.text = SETTINGS.MOUSE_SENSITIVITY_SNIPER;
            this.mouseStrategicSensLabel.text = SETTINGS.MOUSE_SENSITIVITY_ART;
            this.mouseHorzInvertCheckbox.label = SETTINGS.MOUSE_SENSITIVITY_INVERTATIONHOR;
            this.mouseVertInvertCheckbox.label = SETTINGS.MOUSE_SENSITIVITY_INVERTATIONVERT;
            this.backDraftInvertCheckbox.label = SETTINGS.KEYBOARD_BACKDRAFTINVERT;
            this.defaultBtn.label = SETTINGS.DEFAULTBTN;
            this.defaultBtn.enabled = false;
            super.configUI();
            return;
        }

        protected override function setData(arg1:Object):void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=null;
            var loc5:*=null;
            super.setData(arg1);
            var loc6:*=0;
            var loc7:*=_data;
            for (loc1 in loc7) 
            {
                if (_data[loc1] is net.wg.gui.lobby.settings.vo.SettingsControlProp) 
                {
                    loc2 = net.wg.gui.lobby.settings.vo.SettingsControlProp(_data[loc1]);
                    if (this[loc1 + loc2.type]) 
                    {
                        var loc8:*=loc2.type;
                        switch (loc8) 
                        {
                            case net.wg.gui.lobby.settings.SettingsConfig.TYPE_CHECKBOX:
                            {
                                (loc3 = net.wg.gui.components.controls.CheckBox(this[loc1 + loc2.type])).selected = loc2.current;
                                loc3.addEventListener(flash.events.Event.SELECT, this.onCheckBoxSelected);
                                loc3.enabled = !(loc2.current == null);
                                break;
                            }
                            case net.wg.gui.lobby.settings.SettingsConfig.TYPE_SLIDER:
                            {
                                (loc4 = net.wg.gui.components.controls.Slider(this[loc1 + loc2.type])).value = loc2.current;
                                loc4.addEventListener(scaleform.clik.events.SliderEvent.VALUE_CHANGE, this.onSliderValueChanged);
                                loc4.enabled = !(loc2.current == null);
                                break;
                            }
                        }
                    }
                    continue;
                }
                if (!(loc1 == net.wg.gui.lobby.settings.SettingsConfig.KEYBOARD && _data[loc1] is Object && _data[net.wg.gui.lobby.settings.SettingsConfig.KEYS_LAYOUT_ORDER] is Array)) 
                {
                    continue;
                }
                loc5 = this.createDataProviderForKeys(_data[loc1], _data[net.wg.gui.lobby.settings.SettingsConfig.KEYS_LAYOUT_ORDER]);
                this.keys.dataProvider = new scaleform.clik.data.DataProvider(loc5);
                this.keys.addEventListener(net.wg.gui.events.ListEventEx.ITEM_TEXT_CHANGE, this.onKeyChange);
                this.keys.validateNow();
            }
            this.defaultBtn.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onSetDefaultClick);
            this.checkEnabledSetDefBtn();
            return;
        }

        internal function createDataProviderForKeys(arg1:Object, arg2:Array):Array
        {
            var loc4:*=null;
            var loc1:*=[];
            var loc2:*=arg2.length;
            var loc3:*=0;
            while (loc3 < loc2) 
            {
                loc4 = arg2[loc3];
                loc1.push(net.wg.gui.lobby.settings.vo.SettingsKeyProp(arg1[loc4]).getObject());
                ++loc3;
            }
            return loc1;
        }

        internal function checkEnabledSetDefBtn():void
        {
            this.defaultBtn.enabled = this.keys.keysWasChanged() || this.controlsChanged();
            return;
        }

        internal function controlsChanged():Boolean
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=null;
            var loc5:*=null;
            var loc1:*=false;
            if (_data) 
            {
                var loc6:*=0;
                var loc7:*=_data;
                for (loc2 in loc7) 
                {
                    if (_data[loc2] is net.wg.gui.lobby.settings.vo.SettingsControlProp) 
                    {
                        loc3 = net.wg.gui.lobby.settings.vo.SettingsControlProp(_data[loc2]);
                        if (this[loc2 + loc3.type]) 
                        {
                            var loc8:*=loc3.type;
                            switch (loc8) 
                            {
                                case net.wg.gui.lobby.settings.SettingsConfig.TYPE_CHECKBOX:
                                {
                                    loc1 = !((loc4 = net.wg.gui.components.controls.CheckBox(this[loc2 + loc3.type])).selected == loc3._default);
                                    break;
                                }
                                case net.wg.gui.lobby.settings.SettingsConfig.TYPE_SLIDER:
                                {
                                    loc1 = !((loc5 = net.wg.gui.components.controls.Slider(this[loc2 + loc3.type])).value == loc3._default);
                                    break;
                                }
                            }
                        }
                    }
                    if (!loc1) 
                    {
                        continue;
                    }
                    break;
                }
            }
            return loc1;
        }

        internal function onSetDefaultClick(arg1:scaleform.clik.events.ButtonEvent):void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=null;
            this.keys.restoreDefault();
            if (_data) 
            {
                var loc5:*=0;
                var loc6:*=_data;
                label260: for (loc1 in loc6) 
                {
                    if (!(_data[loc1] is net.wg.gui.lobby.settings.vo.SettingsControlProp)) 
                    {
                        continue;
                    }
                    loc2 = net.wg.gui.lobby.settings.vo.SettingsControlProp(_data[loc1]);
                    if (!this[loc1 + loc2.type]) 
                    {
                        continue;
                    }
                    var loc7:*=loc2.type;
                    switch (loc7) 
                    {
                        case net.wg.gui.lobby.settings.SettingsConfig.TYPE_CHECKBOX:
                        {
                            (loc3 = net.wg.gui.components.controls.CheckBox(this[loc1 + loc2.type])).selected = loc2._default;
                            continue label260;
                        }
                        case net.wg.gui.lobby.settings.SettingsConfig.TYPE_SLIDER:
                        {
                            (loc4 = net.wg.gui.components.controls.Slider(this[loc1 + loc2.type])).value = loc2._default;
                            continue label260;
                        }
                    }
                }
            }
            return;
        }

        internal function onSliderValueChanged(arg1:scaleform.clik.events.SliderEvent):void
        {
            var loc1:*=net.wg.gui.components.controls.Slider(arg1.target);
            var loc2:*=net.wg.gui.lobby.settings.SettingsConfig.getControlId(loc1.name, net.wg.gui.lobby.settings.SettingsConfig.TYPE_SLIDER);
            dispatchEvent(new net.wg.gui.lobby.settings.evnts.SettingViewEvent(net.wg.gui.lobby.settings.evnts.SettingViewEvent.ON_CONTROL_CHANGED, _viewId, loc2, loc1.value));
            this.checkEnabledSetDefBtn();
            return;
        }

        internal function onCheckBoxSelected(arg1:flash.events.Event):void
        {
            var loc1:*=net.wg.gui.components.controls.CheckBox(arg1.target);
            var loc2:*=net.wg.gui.lobby.settings.SettingsConfig.getControlId(loc1.name, net.wg.gui.lobby.settings.SettingsConfig.TYPE_CHECKBOX);
            dispatchEvent(new net.wg.gui.lobby.settings.evnts.SettingViewEvent(net.wg.gui.lobby.settings.evnts.SettingViewEvent.ON_CONTROL_CHANGED, _viewId, loc2, loc1.selected));
            this.checkEnabledSetDefBtn();
            return;
        }

        internal function onKeyChange(arg1:net.wg.gui.events.ListEventEx):void
        {
            this.keys.updateDataProvider();
            var loc1:*=arg1.itemData.id;
            var loc2:*={};
            loc2[loc1] = arg1.controllerIdx;
            var loc3:*=net.wg.gui.lobby.settings.SettingsConfig.KEYBOARD;
            dispatchEvent(new net.wg.gui.lobby.settings.evnts.SettingViewEvent(net.wg.gui.lobby.settings.evnts.SettingViewEvent.ON_CONTROL_CHANGED, _viewId, loc3, loc2));
            this.checkEnabledSetDefBtn();
            if (loc1 == net.wg.gui.lobby.settings.SettingsConfig.PUSH_TO_TALK) 
            {
                dispatchEvent(new net.wg.gui.lobby.settings.evnts.SettingViewEvent(net.wg.gui.lobby.settings.evnts.SettingViewEvent.ON_PTT_CONTROL_CHANGED, _viewId, loc1, arg1.controllerIdx));
            }
            return;
        }

        public var keyboardFieldSet:net.wg.gui.components.advanced.FieldSet=null;

        public var scrollBar:net.wg.gui.components.controls.ScrollBar=null;

        public var keys:net.wg.gui.lobby.settings.components.KeysScrollingList=null;

        public var mouseFieldSet:net.wg.gui.components.advanced.FieldSet=null;

        public var mouseSensitivityLabel:flash.text.TextField=null;

        public var mouseArcadeSensLabel:flash.text.TextField=null;

        public var mouseArcadeSensSlider:net.wg.gui.components.controls.Slider=null;

        public var mouseSniperSensLabel:flash.text.TextField=null;

        public var mouseSniperSensSlider:net.wg.gui.components.controls.Slider=null;

        public var mouseStrategicSensLabel:flash.text.TextField=null;

        public var mouseStrategicSensSlider:net.wg.gui.components.controls.Slider=null;

        public var mouseHorzInvertCheckbox:net.wg.gui.components.controls.CheckBox=null;

        public var mouseVertInvertCheckbox:net.wg.gui.components.controls.CheckBox=null;

        public var backDraftInvertCheckbox:net.wg.gui.components.controls.CheckBox=null;

        public var defaultBtn:net.wg.gui.components.controls.SoundButtonEx=null;
    }
}
