package net.wg.gui.lobby.settings
{
   import scaleform.clik.events.ButtonEvent;
   import net.wg.gui.lobby.settings.evnts.SettingViewEvent;
   import flash.utils.setInterval;
   import flash.utils.clearInterval;
   import net.wg.gui.lobby.settings.vo.SettingsControlProp;
   import net.wg.gui.components.controls.CheckBox;
   import net.wg.gui.components.controls.Slider;
   import net.wg.gui.components.controls.DropdownMenu;
   import net.wg.gui.lobby.settings.components.KeyInput;
   import net.wg.gui.components.controls.LabelControl;
   import flash.events.Event;
   import scaleform.clik.events.SliderEvent;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.events.ListEvent;
   import net.wg.gui.lobby.settings.components.evnts.KeyInputEvents;
   import flash.events.MouseEvent;
   import net.wg.gui.lobby.settings.evnts.AlternativeVoiceEvent;
   
   public class SoundSettings extends SoundSettingsBase
   {
      
      public function SoundSettings() {
         super();
      }
      
      private var isVoiceTestStarted:Boolean = false;
      
      private const UNCHECK_VOICE_TEST_BTN_TIMEOUT:Number = 10000.0;
      
      private var voiceTestTimerID:uint = 0;
      
      private var vivoxTestTimeLeft:Number = 0;
      
      private const LOCALIZATION_PREFIX:String = "";
      
      override protected function configUI() : void {
         btnVivoxTest.addEventListener(ButtonEvent.CLICK,this.onBtnVivoxTest);
         btnCaptureDevicesUpdate.addEventListener(ButtonEvent.CLICK,this.onCaptureDevicesBtnClick);
         super.configUI();
      }
      
      private function onBtnVivoxTest(param1:ButtonEvent) : void {
         if(this.isVoiceTestStarted)
         {
            return;
         }
         dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_VIVOX_TEST,_viewId,"",true));
      }
      
      public function onViewChanged() : void {
         this.breakSoundCheck();
      }
      
      public function breakSoundCheck() : void {
         if(this.isVoiceTestStarted)
         {
            dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_VIVOX_TEST,_viewId,"",false));
         }
      }
      
      public function setVoiceTestState(param1:Boolean) : void {
         if(this.isVoiceTestStarted == param1)
         {
            return;
         }
         this.isVoiceTestStarted = param1;
         voiceAnimation.speak(param1);
         btnVivoxTest.enabled = btnCaptureDevicesUpdate.enabled = !param1;
         if((param1) && this.voiceTestTimerID == 0)
         {
            this.vivoxTestTimeLeft = this.UNCHECK_VOICE_TEST_BTN_TIMEOUT;
            this.voiceTestTimerID = setInterval(this.voiceTimerTest,100,this);
         }
         else
         {
            this.forceFinishVivoxTest();
         }
      }
      
      private function voiceTimerTest(param1:SoundSettings) : void {
         var _loc2_:String = null;
         param1.vivoxTestTimeLeft = param1.vivoxTestTimeLeft - 100;
         if(param1.vivoxTestTimeLeft > 0)
         {
            _loc2_ = Number(param1.vivoxTestTimeLeft / 1000).toFixed(1);
            param1.voiceAnimationText.text = _loc2_;
         }
         else
         {
            param1.dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_VIVOX_TEST,param1._viewId,"",false));
         }
      }
      
      private function forceFinishVivoxTest() : void {
         if(this.voiceTestTimerID != 0)
         {
            clearInterval(this.voiceTestTimerID);
            this.voiceTestTimerID = 0;
         }
         this.vivoxTestTimeLeft = 0;
         voiceAnimationText.text = "";
         btnVivoxTest.enabled = btnCaptureDevicesUpdate.enabled = !this.isVoiceTestStarted;
         voiceAnimation.speak(this.isVoiceTestStarted);
      }
      
      override public function update(param1:Object) : void {
         super.update(param1);
      }
      
      override protected function setData(param1:Object) : void {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      private function handleMousePressPTTKey(param1:KeyInputEvents) : void {
         this.hideTooltip();
      }
      
      private function handleMouseRollOutPTTKey(param1:KeyInputEvents) : void {
         this.hideTooltip();
      }
      
      private function handleMouseRollOverPTTKey(param1:KeyInputEvents) : void {
         App.toolTipMgr.showComplex(TOOLTIPS.SETTINGS_DIALOG_SOUND_PTTKEY,null);
      }
      
      private function onTestAlternativeVoicesButtonOut(param1:MouseEvent) : void {
         this.hideTooltip();
      }
      
      private function onTestAlternativeVoicesButtonOver(param1:MouseEvent) : void {
         App.toolTipMgr.showComplex(TOOLTIPS.SETTINGS_DIALOG_SOUND_ALTERNATIVEVOICES,null);
      }
      
      private function onTestAlternativeVoicesButtonClick(param1:ButtonEvent) : void {
         dispatchEvent(new AlternativeVoiceEvent(AlternativeVoiceEvent.ON_TEST_ALTERNATIVE_VOICES));
      }
      
      private function hideTooltip() : void {
         App.toolTipMgr.hide();
      }
      
      private function onCaptureDevicesBtnClick(param1:ButtonEvent) : void {
         dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_UPDATE_CAPTURE_DEVICE,_viewId));
      }
      
      public function setCaptureDevices(param1:Number, param2:Array) : void {
         var _loc3_:uint = 0;
         while(_loc3_ < param2.length)
         {
            param2[_loc3_] = String(param2[_loc3_]);
            _loc3_++;
         }
         captureDeviceDropDown.dataProvider = new DataProvider(param2);
         captureDeviceDropDown.selectedIndex = param1;
         var _loc4_:String = SettingsConfig.getControlId(captureDeviceDropDown.name,SettingsConfig.TYPE_DROPDOWN);
         var _loc5_:SettingsControlProp = SettingsControlProp(_data[_loc4_]);
         if(param2.length != _loc5_.options.length)
         {
            _loc5_.current = -1;
         }
         _loc5_.options = param2;
         dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_CONTROL_CHANGED,_viewId,_loc4_,param1));
         this.onVoiceChatEnabledSelect();
      }
      
      private function onCheckBoxSelected(param1:Event) : void {
         var _loc2_:CheckBox = CheckBox(param1.target);
         var _loc3_:String = SettingsConfig.getControlId(_loc2_.name,SettingsConfig.TYPE_CHECKBOX);
         if(_loc3_ == SettingsConfig.ENABLE_VO_IP)
         {
            this.onVoiceChatEnabledSelect();
         }
         dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_CONTROL_CHANGED,_viewId,_loc3_,_loc2_.selected));
      }
      
      private function onSliderValueChanged(param1:SliderEvent) : void {
         var _loc5_:LabelControl = null;
         var _loc2_:Slider = Slider(param1.target);
         var _loc3_:String = SettingsConfig.getControlId(_loc2_.name,SettingsConfig.TYPE_SLIDER);
         var _loc4_:SettingsControlProp = SettingsControlProp(_data[_loc3_]);
         if((_loc4_.hasValue) && (this[_loc3_ + SettingsConfig.TYPE_VALUE]))
         {
            _loc5_ = this[_loc3_ + SettingsConfig.TYPE_VALUE];
            _loc5_.text = _loc2_.value.toString();
         }
         if(_loc3_ == SettingsConfig.MIC_VIVOX_VOLUME)
         {
            this.setVivoxMicVolume(_loc2_.value);
         }
         dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_CONTROL_CHANGED,_viewId,_loc3_,_loc2_.value));
      }
      
      private function onDropDownChange(param1:ListEvent) : void {
         var _loc2_:DropdownMenu = DropdownMenu(param1.target);
         var _loc3_:String = SettingsConfig.getControlId(_loc2_.name,SettingsConfig.TYPE_DROPDOWN);
         dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_CONTROL_CHANGED,_viewId,_loc3_,_loc2_.selectedIndex));
      }
      
      private function setVivoxMicVolume(param1:Number) : void {
      }
      
      private function onVoiceChatEnabledSelect() : void {
         this.breakSoundCheck();
         var _loc1_:Boolean = (enableVoIPCheckbox.selected) && (SettingsControlProp(_data[SettingsConfig.VOICE_CHAT_SUPORTED]).current);
         if(captureDeviceDropDown != null)
         {
            captureDeviceDropDown.enabled = _loc1_;
         }
         if(micVivoxVolumeSlider != null)
         {
            micVivoxVolumeSlider.enabled = _loc1_;
         }
         if(btnVivoxTest != null)
         {
            btnVivoxTest.enabled = _loc1_;
         }
         if(btnCaptureDevicesUpdate != null)
         {
            btnCaptureDevicesUpdate.enabled = _loc1_;
         }
         if(masterVivoxVolumeSlider != null)
         {
            masterVivoxVolumeSlider.enabled = _loc1_;
         }
         if(masterFadeVivoxVolumeSlider != null)
         {
            masterFadeVivoxVolumeSlider.enabled = _loc1_;
         }
         if(captureDeviceDropDown.dataProvider.length == 0)
         {
            captureDeviceDropDown.enabled = micVivoxVolumeSlider.enabled = btnVivoxTest.enabled = false;
         }
      }
      
      private function showHideVoiceSettings() : void {
         var _loc1_:Boolean = App.voiceChatMgr.isYYS();
         var _loc2_:Boolean = App.voiceChatMgr.isVOIPEnabledS();
         voiceConnectFieldSet.visible = _loc2_;
         enableVoIPCheckbox.visible = (_loc2_) || (_loc1_);
         PTTLabel.visible = _loc2_;
         PTTKeyInput.visible = _loc2_;
         captureDeviceLabel.visible = _loc2_;
         captureDeviceDropDown.visible = _loc2_;
         btnCaptureDevicesUpdate.visible = _loc2_;
         vivoxTestlabel.visible = _loc2_;
         btnVivoxTest.visible = _loc2_;
         voiceAnimation.visible = _loc2_;
         voiceAnimationText.text = _loc2_?voiceAnimationText.text:"";
         masterVivoxVolumeLabel.visible = _loc2_;
         masterVivoxVolumeSlider.visible = _loc2_;
         masterVivoxVolumeValue.visible = _loc2_;
         micVivoxVolumeLabel.visible = _loc2_;
         micVivoxVolumeSlider.visible = _loc2_;
         micVivoxVolumeValue.visible = _loc2_;
         masterFadeVivoxVolumeLabel.visible = _loc2_;
         masterFadeVivoxVolumeSlider.visible = _loc2_;
         masterFadeVivoxVolumeValue.visible = _loc2_;
      }
      
      override protected function onDispose() : void {
         var _loc1_:String = null;
         var _loc2_:SettingsControlProp = null;
         var _loc3_:CheckBox = null;
         var _loc4_:Slider = null;
         var _loc5_:DropdownMenu = null;
         this.breakSoundCheck();
         if(btnCaptureDevicesUpdate.hasEventListener(ButtonEvent.CLICK))
         {
            btnCaptureDevicesUpdate.removeEventListener(ButtonEvent.CLICK,this.onCaptureDevicesBtnClick);
         }
         if(btnVivoxTest.hasEventListener(ButtonEvent.CLICK))
         {
            btnVivoxTest.removeEventListener(ButtonEvent.CLICK,this.onBtnVivoxTest);
         }
         this.forceFinishVivoxTest();
         for(_loc1_ in _data)
         {
            _loc2_ = SettingsControlProp(_data[_loc1_]);
            if(this[_loc1_ + _loc2_.type])
            {
               switch(_loc2_.type)
               {
                  case SettingsConfig.TYPE_CHECKBOX:
                     _loc3_ = this[_loc1_ + _loc2_.type];
                     if(_loc3_.hasEventListener(Event.SELECT))
                     {
                        _loc3_.removeEventListener(Event.SELECT,this.onCheckBoxSelected);
                     }
                     continue;
                  case SettingsConfig.TYPE_SLIDER:
                     _loc4_ = this[_loc1_ + _loc2_.type];
                     if(_loc4_.hasEventListener(SliderEvent.VALUE_CHANGE))
                     {
                        _loc4_.removeEventListener(SliderEvent.VALUE_CHANGE,this.onSliderValueChanged);
                     }
                     continue;
                  case SettingsConfig.TYPE_DROPDOWN:
                     _loc5_ = this[_loc1_ + _loc2_.type];
                     if(_loc5_.hasEventListener(ListEvent.INDEX_CHANGE))
                     {
                        _loc5_.removeEventListener(ListEvent.INDEX_CHANGE,this.onDropDownChange);
                     }
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
         if(testAlternativeVoicesButton.hasEventListener(ButtonEvent.CLICK))
         {
            testAlternativeVoicesButton.removeEventListener(ButtonEvent.CLICK,this.onTestAlternativeVoicesButtonClick);
         }
         if(testAlternativeVoicesButton.hasEventListener(MouseEvent.MOUSE_OVER))
         {
            testAlternativeVoicesButton.removeEventListener(MouseEvent.MOUSE_OVER,this.onTestAlternativeVoicesButtonOver);
         }
         if(testAlternativeVoicesButton.hasEventListener(MouseEvent.MOUSE_OUT))
         {
            testAlternativeVoicesButton.removeEventListener(MouseEvent.MOUSE_OUT,this.onTestAlternativeVoicesButtonOut);
         }
         if(PTTKeyInput)
         {
            if(PTTKeyInput.hasEventListener(KeyInputEvents.DISABLE_OVER))
            {
               PTTKeyInput.removeEventListener(KeyInputEvents.DISABLE_OVER,this.handleMouseRollOverPTTKey);
            }
            if(PTTKeyInput.hasEventListener(KeyInputEvents.DISABLE_OUT))
            {
               PTTKeyInput.removeEventListener(KeyInputEvents.DISABLE_OUT,this.handleMouseRollOutPTTKey);
            }
            if(PTTKeyInput.hasEventListener(KeyInputEvents.DISABLE_PRESS))
            {
               PTTKeyInput.removeEventListener(KeyInputEvents.DISABLE_PRESS,this.handleMousePressPTTKey);
            }
         }
         super.onDispose();
      }
      
      public function updatePTTControl(param1:Number) : void {
         PTTKeyInput.key = param1;
      }
      
      private function showHideAlternativeVoices(param1:Boolean) : void {
         alternativeVoicesFieldSet.visible = param1;
         alternativeVoicesLabel.visible = param1;
         alternativeVoicesDropDown.visible = param1;
         testAlternativeVoicesButton.visible = param1;
      }
      
      override public function toString() : String {
         return "[WG SoundSettings " + name + "]";
      }
   }
}
