package net.wg.gui.lobby.settings
{
    import net.wg.gui.lobby.settings.vo.base.SettingsDataVo;
    import net.wg.gui.lobby.settings.vo.SettingsControlProp;
    import net.wg.gui.components.controls.Slider;
    import net.wg.gui.components.controls.LabelControl;
    import net.wg.gui.lobby.settings.config.SettingsConfigHelper;
    import net.wg.data.constants.Values;
    import scaleform.clik.events.SliderEvent;
    import net.wg.gui.lobby.settings.events.SettingViewEvent;

    public class OtherSettings extends OtherSettingsBase
    {

        private var _keys:Vector.<String> = null;

        private var _values:Vector.<Object> = null;

        public function OtherSettings()
        {
            super();
        }

        override protected function setData(param1:SettingsDataVo) : void
        {
            var _loc4_:String = null;
            var _loc5_:SettingsControlProp = null;
            var _loc7_:* = false;
            var _loc8_:Slider = null;
            var _loc9_:LabelControl = null;
            var _loc10_:* = false;
            super.setData(param1);
            var _loc2_:Boolean = SettingsControlProp(data[SettingsConfigHelper.VIBRO_IS_CONNECTED]).current;
            if(!_loc2_)
            {
                return;
            }
            vibroDeviceConnectionStateField.text = _loc2_?SETTINGS.VIBRO_DEVICE_STATE_CONNECTED:SETTINGS.VIBRO_DEVICE_STATE_NOTCONNECTED;
            this._keys = param1.keys;
            this._values = param1.values;
            var _loc3_:int = this._keys.length;
            _loc4_ = Values.EMPTY_STR;
            _loc5_ = null;
            var _loc6_:* = 0;
            while(_loc6_ < _loc3_)
            {
                _loc4_ = this._keys[_loc6_];
                _loc5_ = this._values[_loc6_] as SettingsControlProp;
                App.utils.asserter.assertNotNull(_loc5_,"values[i] must be SettingsControlProp");
                if(this[_loc4_ + _loc5_.type])
                {
                    _loc7_ = !(_loc5_.current == null || _loc5_.readOnly);
                    switch(_loc5_.type)
                    {
                        case SettingsConfigHelper.TYPE_SLIDER:
                            _loc8_ = Slider(this[_loc4_ + _loc5_.type]);
                            _loc8_.value = Number(_loc5_.current);
                            _loc8_.enabled = _loc7_;
                            _loc8_.addEventListener(SliderEvent.VALUE_CHANGE,this.onSliderValueChangeHandler);
                            if(_loc5_.hasValue && this[_loc4_ + SettingsConfigHelper.TYPE_VALUE])
                            {
                                _loc9_ = this[_loc4_ + SettingsConfigHelper.TYPE_VALUE];
                                _loc9_.text = _loc5_.current.toString();
                            }
                            break;
                    }
                }
                if(this[_loc4_ + _loc5_.type] && _loc5_.isDependOn)
                {
                    _loc10_ = SettingsControlProp(data[_loc5_.isDependOn]).current;
                    this.showHideControl(_loc4_,_loc5_,_loc10_);
                }
                _loc6_++;
            }
        }

        private function onSliderValueChangeHandler(param1:SliderEvent) : void
        {
            var _loc5_:LabelControl = null;
            var _loc2_:Slider = Slider(param1.target);
            var _loc3_:String = SettingsConfigHelper.instance.getControlIdByControlNameAndType(_loc2_.name,SettingsConfigHelper.TYPE_SLIDER);
            var _loc4_:SettingsControlProp = SettingsControlProp(data[_loc3_]);
            if(_loc4_.hasValue && this[_loc3_ + SettingsConfigHelper.TYPE_VALUE])
            {
                _loc5_ = LabelControl(this[_loc3_ + SettingsConfigHelper.TYPE_VALUE]);
                _loc5_.text = _loc2_.value.toString();
            }
            dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_CONTROL_CHANGED,viewId,null,_loc3_,_loc2_.value));
        }

        private function showHideControl(param1:String, param2:SettingsControlProp, param3:Boolean) : void
        {
            if(this[param1 + param2.type])
            {
                this[param1 + param2.type].visible = param3;
            }
            if(param2.hasLabel && this[param1 + SettingsConfigHelper.TYPE_LABEL])
            {
                this[param1 + SettingsConfigHelper.TYPE_LABEL].visible = param3;
            }
            if(param2.hasValue && this[param1 + SettingsConfigHelper.TYPE_VALUE])
            {
                this[param1 + SettingsConfigHelper.TYPE_VALUE].visible = param3;
            }
        }

        override protected function onBeforeDispose() : void
        {
            var _loc1_:int = this._keys.length;
            var _loc2_:String = Values.EMPTY_STR;
            var _loc3_:SettingsControlProp = null;
            var _loc4_:* = 0;
            while(_loc4_ < _loc1_)
            {
                _loc2_ = this._keys[_loc4_];
                _loc3_ = this._values[_loc4_] as SettingsControlProp;
                App.utils.asserter.assertNotNull(_loc3_,"values[i] must be SettingsControlProp");
                if(this[_loc2_ + _loc3_.type])
                {
                    if(_loc3_.type == SettingsConfigHelper.TYPE_SLIDER)
                    {
                        Slider(this[_loc2_ + _loc3_.type]).removeEventListener(SliderEvent.VALUE_CHANGE,this.onSliderValueChangeHandler);
                    }
                }
                _loc4_++;
            }
            super.onBeforeDispose();
        }

        override protected function onDispose() : void
        {
            this._keys.splice(0,this._keys.length);
            this._keys = null;
            this._values.splice(0,this._values.length);
            this._values = null;
            super.onDispose();
        }
    }
}
