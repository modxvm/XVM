package net.wg.gui.lobby.settings
{
    import scaleform.clik.core.UIComponent;
    import net.wg.gui.components.controls.Slider;
    import net.wg.gui.components.controls.LabelControl;
    import net.wg.gui.components.controls.DropdownMenu;
    import net.wg.gui.lobby.settings.vo.SettingsControlProp;
    import scaleform.clik.events.SliderEvent;
    import scaleform.clik.data.DataProvider;
    import scaleform.clik.events.ListEvent;
    import net.wg.gui.lobby.settings.evnts.SettingsSubVewEvent;
    
    public class SettingsAimForm extends UIComponent
    {
        
        public function SettingsAimForm() {
            super();
        }
        
        private var _id:String = null;
        
        private var _data:Object = null;
        
        public var netSlider:Slider = null;
        
        public var netLabel:LabelControl = null;
        
        public var netValue:LabelControl = null;
        
        public var netTypeDropDown:DropdownMenu = null;
        
        public var centralTagSlider:Slider = null;
        
        public var centralTagLabel:LabelControl = null;
        
        public var centralTagValue:LabelControl = null;
        
        public var centralTagTypeDropDown:DropdownMenu = null;
        
        public var reloaderSlider:Slider = null;
        
        public var reloaderLabel:LabelControl = null;
        
        public var reloaderValue:LabelControl = null;
        
        public var conditionSlider:Slider = null;
        
        public var conditionLabel:LabelControl = null;
        
        public var conditionValue:LabelControl = null;
        
        public var mixingSlider:Slider = null;
        
        public var mixingLabel:LabelControl = null;
        
        public var mixingValue:LabelControl = null;
        
        public var mixingTypeDropDown:DropdownMenu = null;
        
        public var gunTagSlider:Slider = null;
        
        public var gunTagLabel:LabelControl = null;
        
        public var gunTagValue:LabelControl = null;
        
        public var gunTagTypeDropDown:DropdownMenu = null;
        
        public var cassetteSlider:Slider = null;
        
        public var cassetteLabel:LabelControl = null;
        
        public var cassetteValue:LabelControl = null;
        
        public var reloaderTimerSlider:Slider = null;
        
        public var reloaderTimerLabel:LabelControl = null;
        
        public var reloaderTimerValue:LabelControl = null;
        
        override protected function configUI() : void {
            super.configUI();
        }
        
        override protected function draw() : void {
            super.draw();
        }
        
        public function setData(param1:String, param2:Object) : void {
            var _loc3_:String = null;
            var _loc4_:SettingsControlProp = null;
            var _loc5_:Slider = null;
            var _loc6_:DropdownMenu = null;
            var _loc7_:LabelControl = null;
            var _loc8_:LabelControl = null;
            this.id = param1;
            if(param2 != null)
            {
                this._data = param2;
                for(_loc3_ in this._data)
                {
                    _loc4_ = SettingsControlProp(this._data[_loc3_]);
                    if(this[_loc3_ + _loc4_.type])
                    {
                        switch(_loc4_.type)
                        {
                            case SettingsConfig.TYPE_SLIDER:
                                _loc5_ = this[_loc3_ + _loc4_.type];
                                _loc5_.value = _loc4_.current;
                                _loc5_.addEventListener(SliderEvent.VALUE_CHANGE,this.onSliderValueChanged);
                                _loc5_.enabled = _loc4_.current == null?false:true;
                                if((_loc4_.hasValue) && (this[_loc3_ + SettingsConfig.TYPE_VALUE]))
                                {
                                    _loc7_ = this[_loc3_ + SettingsConfig.TYPE_VALUE];
                                    _loc7_.text = _loc4_.current?_loc4_.current:"";
                                }
                                if((_loc4_.hasLabel) && (this[_loc3_ + SettingsConfig.TYPE_LABEL]))
                                {
                                    _loc8_ = this[_loc3_ + SettingsConfig.TYPE_LABEL];
                                    _loc8_.text = SETTINGS.arcade(_loc3_);
                                }
                                continue;
                            case SettingsConfig.TYPE_DROPDOWN:
                                _loc6_ = this[_loc3_ + _loc4_.type];
                                _loc6_.dataProvider = new DataProvider(_loc4_.options);
                                _loc6_.menuRowCount = _loc4_.options is Array?_loc4_.options.length:0;
                                _loc6_.selectedIndex = _loc4_.current;
                                _loc6_.enabled = _loc4_.current == null?false:true;
                                _loc6_.addEventListener(ListEvent.INDEX_CHANGE,this.onDropDownChange);
                                continue;
                            default:
                                continue;
                        }
                    }
                    else
                    {
                        continue;
                    }
                }
            }
            else
            {
                this.disableAllControls();
            }
        }
        
        private function onDropDownChange(param1:ListEvent) : void {
            var _loc2_:DropdownMenu = DropdownMenu(param1.target);
            var _loc3_:String = SettingsConfig.getControlId(_loc2_.name,SettingsConfig.TYPE_DROPDOWN);
            dispatchEvent(new SettingsSubVewEvent(SettingsSubVewEvent.ON_CONTROL_CHANGE,this._id,_loc3_,_loc2_.selectedIndex));
        }
        
        private function onSliderValueChanged(param1:SliderEvent) : void {
            var _loc5_:LabelControl = null;
            var _loc2_:Slider = Slider(param1.target);
            var _loc3_:String = SettingsConfig.getControlId(_loc2_.name,SettingsConfig.TYPE_SLIDER);
            var _loc4_:SettingsControlProp = SettingsControlProp(this._data[_loc3_]);
            if((_loc4_.hasValue) && (this[_loc3_ + SettingsConfig.TYPE_VALUE]))
            {
                _loc5_ = this[_loc3_ + SettingsConfig.TYPE_VALUE];
                _loc5_.text = _loc2_.value.toString();
            }
            dispatchEvent(new SettingsSubVewEvent(SettingsSubVewEvent.ON_CONTROL_CHANGE,this._id,_loc3_,_loc2_.value));
        }
        
        private function disableAllControls() : void {
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
            this.reloaderTimerSlider.enabled = false;
        }
        
        public function set id(param1:String) : void {
            this._id = param1;
        }
        
        public function get id() : String {
            return this._id;
        }
        
        override protected function onDispose() : void {
            var _loc1_:String = null;
            var _loc2_:SettingsControlProp = null;
            var _loc3_:Slider = null;
            var _loc4_:DropdownMenu = null;
            if(this._data != null)
            {
                for(_loc1_ in this._data)
                {
                    _loc2_ = SettingsControlProp(this._data[_loc1_]);
                    if(this[_loc1_ + _loc2_.type])
                    {
                        switch(_loc2_.type)
                        {
                            case SettingsConfig.TYPE_SLIDER:
                                _loc3_ = this[_loc1_ + _loc2_.type];
                                _loc3_.removeEventListener(SliderEvent.VALUE_CHANGE,this.onSliderValueChanged);
                                continue;
                            case SettingsConfig.TYPE_DROPDOWN:
                                _loc4_ = this[_loc1_ + _loc2_.type];
                                _loc4_.removeEventListener(ListEvent.INDEX_CHANGE,this.onDropDownChange);
                                continue;
                            default:
                                continue;
                        }
                    }
                    else
                    {
                        continue;
                    }
                }
                this._data = null;
            }
            super.onDispose();
        }
    }
}
