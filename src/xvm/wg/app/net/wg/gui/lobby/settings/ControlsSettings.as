package net.wg.gui.lobby.settings
{
    import net.wg.gui.components.advanced.FieldSet;
    import net.wg.gui.components.controls.ScrollBar;
    import net.wg.gui.lobby.settings.components.KeysScrollingList;
    import flash.text.TextField;
    import net.wg.gui.components.controls.Slider;
    import net.wg.gui.components.controls.CheckBox;
    import net.wg.gui.components.controls.SoundButtonEx;
    import net.wg.gui.lobby.settings.vo.SettingsControlProp;
    import scaleform.clik.events.ButtonEvent;
    import net.wg.gui.events.ListEventEx;
    import flash.events.Event;
    import scaleform.clik.events.SliderEvent;
    import scaleform.clik.interfaces.IDataProvider;
    import scaleform.clik.data.DataProvider;
    import net.wg.gui.lobby.settings.vo.SettingsKeyProp;
    import net.wg.gui.lobby.settings.evnts.SettingViewEvent;
    
    public class ControlsSettings extends SettingsBaseView
    {
        
        public function ControlsSettings()
        {
            super();
        }
        
        public var keyboardFieldSet:FieldSet = null;
        
        public var scrollBar:ScrollBar = null;
        
        public var keys:KeysScrollingList = null;
        
        public var mouseFieldSet:FieldSet = null;
        
        public var mouseSensitivityLabel:TextField = null;
        
        public var mouseArcadeSensLabel:TextField = null;
        
        public var mouseArcadeSensSlider:Slider = null;
        
        public var mouseSniperSensLabel:TextField = null;
        
        public var mouseSniperSensSlider:Slider = null;
        
        public var mouseStrategicSensLabel:TextField = null;
        
        public var mouseStrategicSensSlider:Slider = null;
        
        public var mouseHorzInvertCheckbox:CheckBox = null;
        
        public var mouseVertInvertCheckbox:CheckBox = null;
        
        public var backDraftInvertCheckbox:CheckBox = null;
        
        public var defaultBtn:SoundButtonEx = null;
        
        override public function update(param1:Object) : void
        {
            super.update(param1);
        }
        
        override protected function onDispose() : void
        {
            /*
             * Decompilation error
             * Code may be obfuscated
             * Error type: TranslateException
             */
            throw new Error("Not decompiled due to error");
        }
        
        override public function toString() : String
        {
            return "[WG ControlsSettings " + name + "]";
        }
        
        public function getKeyasDataProvider() : IDataProvider
        {
            return this.keys.dataProvider;
        }
        
        override protected function configUI() : void
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
        }
        
        override protected function setData(param1:Object) : void
        {
            /*
             * Decompilation error
             * Code may be obfuscated
             * Error type: TranslateException
             */
            throw new Error("Not decompiled due to error");
        }
        
        private function createDataProviderForKeys(param1:Object, param2:Array) : Array
        {
            var _loc6_:String = null;
            var _loc3_:Array = [];
            var _loc4_:uint = param2.length;
            var _loc5_:uint = 0;
            while(_loc5_ < _loc4_)
            {
                _loc6_ = param2[_loc5_];
                _loc3_.push(SettingsKeyProp(param1[_loc6_]).getObject());
                _loc5_++;
            }
            return _loc3_;
        }
        
        private function checkEnabledSetDefBtn() : void
        {
            this.defaultBtn.enabled = (this.keys.keysWasChanged()) || (this.controlsChanged());
        }
        
        private function controlsChanged() : Boolean
        {
            /*
             * Decompilation error
             * Code may be obfuscated
             * Error type: TranslateException
             */
            throw new Error("Not decompiled due to error");
        }
        
        private function onSetDefaultClick(param1:ButtonEvent) : void
        {
            /*
             * Decompilation error
             * Code may be obfuscated
             * Error type: TranslateException
             */
            throw new Error("Not decompiled due to error");
        }
        
        private function onSliderValueChanged(param1:SliderEvent) : void
        {
            var _loc2_:Slider = Slider(param1.target);
            var _loc3_:String = SettingsConfig.getControlId(_loc2_.name,SettingsConfig.TYPE_SLIDER);
            dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_CONTROL_CHANGED,_viewId,_loc3_,_loc2_.value));
            this.checkEnabledSetDefBtn();
        }
        
        private function onCheckBoxSelected(param1:Event) : void
        {
            var _loc2_:CheckBox = CheckBox(param1.target);
            var _loc3_:String = SettingsConfig.getControlId(_loc2_.name,SettingsConfig.TYPE_CHECKBOX);
            dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_CONTROL_CHANGED,_viewId,_loc3_,_loc2_.selected));
            this.checkEnabledSetDefBtn();
        }
        
        private function onKeyChange(param1:ListEventEx) : void
        {
            this.keys.updateDataProvider();
            var _loc2_:String = param1.itemData.id;
            var _loc3_:Object = {};
            _loc3_[_loc2_] = param1.controllerIdx;
            var _loc4_:String = SettingsConfig.KEYBOARD;
            dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_CONTROL_CHANGED,_viewId,_loc4_,_loc3_));
            this.checkEnabledSetDefBtn();
            if(_loc2_ == SettingsConfig.PUSH_TO_TALK)
            {
                dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_PTT_CONTROL_CHANGED,_viewId,_loc2_,param1.controllerIdx));
            }
        }
    }
}
