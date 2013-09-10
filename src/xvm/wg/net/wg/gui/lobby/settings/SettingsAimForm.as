package net.wg.gui.lobby.settings 
{
    import net.wg.gui.components.controls.*;
    import net.wg.gui.lobby.settings.evnts.*;
    import net.wg.gui.lobby.settings.vo.*;
    import scaleform.clik.core.*;
    import scaleform.clik.data.*;
    import scaleform.clik.events.*;
    
    public class SettingsAimForm extends scaleform.clik.core.UIComponent
    {
        public function SettingsAimForm()
        {
            super();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            return;
        }

        protected override function draw():void
        {
            super.draw();
            return;
        }

        public function setData(arg1:String, arg2:Object):void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=null;
            var loc5:*=null;
            var loc6:*=null;
            this.id = arg1;
            if (arg2 == null) 
                this.disableAllControls();
            else 
            {
                this._data = arg2;
                var loc7:*=0;
                var loc8:*=this._data;
                label514: for (loc1 in loc8) 
                {
                    loc2 = net.wg.gui.lobby.settings.vo.SettingsControlProp(this._data[loc1]);
                    if (!this[loc1 + loc2.type]) 
                        continue;
                    var loc9:*=loc2.type;
                    switch (loc9) 
                    {
                        case net.wg.gui.lobby.settings.SettingsConfig.TYPE_SLIDER:
                            (loc3 = this[loc1 + loc2.type]).value = loc2.current;
                            loc3.addEventListener(scaleform.clik.events.SliderEvent.VALUE_CHANGE, this.onSliderValueChanged);
                            loc3.enabled = loc2.current != null ? true : false;
                            if (loc2.hasValue && this[loc1 + net.wg.gui.lobby.settings.SettingsConfig.TYPE_VALUE]) 
                                (loc5 = this[loc1 + net.wg.gui.lobby.settings.SettingsConfig.TYPE_VALUE]).text = loc2.current ? loc2.current : "";
                            if (loc2.hasLabel && this[loc1 + net.wg.gui.lobby.settings.SettingsConfig.TYPE_LABEL]) 
                                (loc6 = this[loc1 + net.wg.gui.lobby.settings.SettingsConfig.TYPE_LABEL]).text = SETTINGS.arcade(loc1);
                            continue label514;
                        case net.wg.gui.lobby.settings.SettingsConfig.TYPE_DROPDOWN:
                            (loc4 = this[loc1 + loc2.type]).dataProvider = new scaleform.clik.data.DataProvider(loc2.options);
                            loc4.menuRowCount = loc2.options is Array ? loc2.options.length : 0;
                            loc4.selectedIndex = loc2.current;
                            loc4.enabled = loc2.current != null ? true : false;
                            loc4.addEventListener(scaleform.clik.events.ListEvent.INDEX_CHANGE, this.onDropDownChange);
                            continue label514;
                    }
                }
            }
            return;
        }

        internal function onDropDownChange(arg1:scaleform.clik.events.ListEvent):void
        {
            var loc1:*=net.wg.gui.components.controls.DropdownMenu(arg1.target);
            var loc2:*=net.wg.gui.lobby.settings.SettingsConfig.getControlId(loc1.name, net.wg.gui.lobby.settings.SettingsConfig.TYPE_DROPDOWN);
            dispatchEvent(new net.wg.gui.lobby.settings.evnts.SettingsSubVewEvent(net.wg.gui.lobby.settings.evnts.SettingsSubVewEvent.ON_CONTROL_CHANGE, this._id, loc2, loc1.selectedIndex));
            return;
        }

        internal function onSliderValueChanged(arg1:scaleform.clik.events.SliderEvent):void
        {
            var loc4:*=null;
            var loc1:*=net.wg.gui.components.controls.Slider(arg1.target);
            var loc2:*=net.wg.gui.lobby.settings.SettingsConfig.getControlId(loc1.name, net.wg.gui.lobby.settings.SettingsConfig.TYPE_SLIDER);
            var loc3:*;
            if ((loc3 = net.wg.gui.lobby.settings.vo.SettingsControlProp(this._data[loc2])).hasValue && this[loc2 + net.wg.gui.lobby.settings.SettingsConfig.TYPE_VALUE]) 
                (loc4 = this[loc2 + net.wg.gui.lobby.settings.SettingsConfig.TYPE_VALUE]).text = loc1.value.toString();
            dispatchEvent(new net.wg.gui.lobby.settings.evnts.SettingsSubVewEvent(net.wg.gui.lobby.settings.evnts.SettingsSubVewEvent.ON_CONTROL_CHANGE, this._id, loc2, loc1.value));
            return;
        }

        internal function disableAllControls():void
        {
            this.netSlider.enabled = false;
            this.netTypeDropDown.enabled = false;
            this.centralTagSlider.enabled = false;
            this.centralTagTypeDropDown.enabled = false;
            this.reloaderSlider.enabled = false;
            this.conditionSlider.enabled = false;
            this.mixingSlider.enabled = false;
            this.mixingTypeDropDown.enabled = false;
            this.gunTagSlider.enabled = false;
            this.gunTagTypeDropDown.enabled = false;
            this.cassetteSlider.enabled = false;
            return;
        }

        public function set id(arg1:String):void
        {
            this._id = arg1;
            return;
        }

        public function get id():String
        {
            return this._id;
        }

        public override function dispose():void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=null;
            super.dispose();
            if (this._data != null) 
            {
                var loc5:*=0;
                var loc6:*=this._data;
                label244: for (loc1 in loc6) 
                {
                    loc2 = net.wg.gui.lobby.settings.vo.SettingsControlProp(this._data[loc1]);
                    if (!this[loc1 + loc2.type]) 
                        continue;
                    var loc7:*=loc2.type;
                    switch (loc7) 
                    {
                        case net.wg.gui.lobby.settings.SettingsConfig.TYPE_SLIDER:
                            loc3 = this[loc1 + loc2.type];
                            loc3.removeEventListener(scaleform.clik.events.SliderEvent.VALUE_CHANGE, this.onSliderValueChanged);
                            continue label244;
                        case net.wg.gui.lobby.settings.SettingsConfig.TYPE_DROPDOWN:
                            (loc4 = this[loc1 + loc2.type]).removeEventListener(scaleform.clik.events.ListEvent.INDEX_CHANGE, this.onDropDownChange);
                            continue label244;
                    }
                }
                this._data = null;
            }
            return;
        }

        internal var _id:String=null;

        internal var _data:Object=null;

        public var netSlider:net.wg.gui.components.controls.Slider=null;

        public var netLabel:net.wg.gui.components.controls.LabelControl=null;

        public var netValue:net.wg.gui.components.controls.LabelControl=null;

        public var netTypeDropDown:net.wg.gui.components.controls.DropdownMenu=null;

        public var centralTagSlider:net.wg.gui.components.controls.Slider=null;

        public var centralTagLabel:net.wg.gui.components.controls.LabelControl=null;

        public var centralTagValue:net.wg.gui.components.controls.LabelControl=null;

        public var centralTagTypeDropDown:net.wg.gui.components.controls.DropdownMenu=null;

        public var reloaderSlider:net.wg.gui.components.controls.Slider=null;

        public var reloaderLabel:net.wg.gui.components.controls.LabelControl=null;

        public var reloaderValue:net.wg.gui.components.controls.LabelControl=null;

        public var conditionSlider:net.wg.gui.components.controls.Slider=null;

        public var conditionLabel:net.wg.gui.components.controls.LabelControl=null;

        public var conditionValue:net.wg.gui.components.controls.LabelControl=null;

        public var mixingSlider:net.wg.gui.components.controls.Slider=null;

        public var cassetteValue:net.wg.gui.components.controls.LabelControl=null;

        public var mixingValue:net.wg.gui.components.controls.LabelControl=null;

        public var mixingTypeDropDown:net.wg.gui.components.controls.DropdownMenu=null;

        public var gunTagSlider:net.wg.gui.components.controls.Slider=null;

        public var gunTagLabel:net.wg.gui.components.controls.LabelControl=null;

        public var gunTagValue:net.wg.gui.components.controls.LabelControl=null;

        public var gunTagTypeDropDown:net.wg.gui.components.controls.DropdownMenu=null;

        public var cassetteSlider:net.wg.gui.components.controls.Slider=null;

        public var cassetteLabel:net.wg.gui.components.controls.LabelControl=null;

        public var mixingLabel:net.wg.gui.components.controls.LabelControl=null;
    }
}
