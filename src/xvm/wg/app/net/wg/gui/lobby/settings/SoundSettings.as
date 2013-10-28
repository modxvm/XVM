package net.wg.gui.lobby.settings
{
   import net.wg.gui.components.advanced.FieldSet;
   import net.wg.gui.components.controls.LabelControl;
   import net.wg.gui.components.controls.Slider;
   import net.wg.gui.components.controls.CheckBox;
   import net.wg.gui.components.controls.DropdownMenu;
   import net.wg.gui.components.controls.IconButton;
   import net.wg.gui.lobby.settings.components.KeyInput;
   import net.wg.gui.components.controls.SoundButtonEx;
   import flash.text.TextField;
   import net.wg.gui.lobby.settings.components.SoundVoiceWaves;
   import scaleform.clik.events.ButtonEvent;
   import net.wg.gui.lobby.settings.evnts.SettingViewEvent;
   import flash.utils.setInterval;
   import flash.utils.clearInterval;
   import net.wg.gui.lobby.settings.vo.SettingsControlProp;
   import flash.events.Event;
   import scaleform.clik.events.SliderEvent;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.events.ListEvent;
   import net.wg.gui.lobby.settings.components.evnts.KeyInputEvents;
   import flash.events.MouseEvent;
   import net.wg.gui.lobby.settings.evnts.AlternativeVoiceEvent;


   public class SoundSettings extends SettingsBaseView
   {
          
      public function SoundSettings() {
         super();
      }

      public var volumeFieldSet:FieldSet = null;

      public var masterVolumeLabel:LabelControl = null;

      public var masterVolumeSlider:Slider = null;

      public var masterVolumeValue:LabelControl = null;

      public var musicVolumeLabel:LabelControl = null;

      public var musicVolumeSlider:Slider = null;

      public var musicVolumeValue:LabelControl = null;

      public var voiceVolumeLabel:LabelControl = null;

      public var voiceVolumeSlider:Slider = null;

      public var voiceVolumeValue:LabelControl = null;

      public var vehiclesVolumeLabel:LabelControl = null;

      public var vehiclesVolumeSlider:Slider = null;

      public var vehiclesVolumeValue:LabelControl = null;

      public var effectsVolumeLabel:LabelControl = null;

      public var effectsVolumeSlider:Slider = null;

      public var effectsVolumeValue:LabelControl = null;

      public var guiVolumeLabel:LabelControl = null;

      public var guiVolumeSlider:Slider = null;

      public var guiVolumeValue:LabelControl = null;

      public var ambientVolumeLabel:LabelControl = null;

      public var ambientVolumeSlider:Slider = null;

      public var ambientVolumeValue:LabelControl = null;

      public var nationalVoicesCheckbox:CheckBox = null;

      public var alternativeVoicesFieldSet:FieldSet = null;

      public var alternativeVoicesLabel:LabelControl = null;

      public var alternativeVoicesDropDown:DropdownMenu = null;

      public var testAlternativeVoicesButton:IconButton = null;

      public var voiceConnectFieldSet:FieldSet = null;

      public var enableVoIPCheckbox:CheckBox = null;

      public var PTTLabel:LabelControl = null;

      public var PTTKeyInput:KeyInput = null;

      public var captureDeviceLabel:LabelControl = null;

      public var captureDeviceDropDown:DropdownMenu = null;

      public var btnCaptureDevicesUpdate:SoundButtonEx = null;

      public var vivoxTestlabel:LabelControl = null;

      public var btnVivoxTest:SoundButtonEx = null;

      public var voiceAnimationText:TextField = null;

      public var masterVivoxVolumeLabel:LabelControl = null;

      public var masterVivoxVolumeSlider:Slider = null;

      public var masterVivoxVolumeValue:LabelControl = null;

      public var micVivoxVolumeLabel:LabelControl = null;

      public var micVivoxVolumeSlider:Slider = null;

      public var micVivoxVolumeValue:LabelControl = null;

      public var masterFadeVivoxVolumeLabel:LabelControl = null;

      public var masterFadeVivoxVolumeSlider:Slider = null;

      public var masterFadeVivoxVolumeValue:LabelControl = null;

      public var voiceAnimation:SoundVoiceWaves = null;

      private var isVoiceTestStarted:Boolean = false;

      private const UNCHECK_VOICE_TEST_BTN_TIMEOUT:Number = 10000.0;

      private var voiceTestTimerID:uint = 0;

      private var vivoxTestTimeLeft:Number = 0;

      private const LOCALIZATION_PREFIX:String = "";

      override protected function configUI() : void {
         this.volumeFieldSet.label = SETTINGS.SOUND_FIELDSET_HEADER;
         this.masterVolumeLabel.text = SETTINGS.SOUNDS_MASTERVOLUME;
         this.musicVolumeLabel.text = SETTINGS.SOUNDS_ARENA;
         this.voiceVolumeLabel.text = SETTINGS.SOUNDS_VOICE;
         this.vehiclesVolumeLabel.text = SETTINGS.SOUNDS_VEHICLES;
         this.effectsVolumeLabel.text = SETTINGS.SOUNDS_EFFECTS;
         this.guiVolumeLabel.text = SETTINGS.SOUNDS_GUI;
         this.ambientVolumeLabel.text = SETTINGS.SOUNDS_AMBIENT;
         this.nationalVoicesCheckbox.label = SETTINGS.SOUND_NATIONALVOICES;
         this.voiceConnectFieldSet.label = SETTINGS.VOICE_CHAT_FIELDSET_HEADER;
         this.enableVoIPCheckbox.label = SETTINGS.VOICE_CHAT_VOICECHATENABLE;
         this.PTTLabel.text = SETTINGS.VOICE_CHAT_PTT;
         this.captureDeviceLabel.text = SETTINGS.VOICE_CHAT_MICROPHONE;
         this.btnCaptureDevicesUpdate.label = SETTINGS.SOUND_VIVOX_BUTTONS_CAPTURE_DEVICES_REFRESH;
         this.vivoxTestlabel.text = SETTINGS.SOUND_VIVOX_VIVOX_TEST;
         this.btnVivoxTest.label = SETTINGS.SOUND_VIVOX_BUTTONS_TEST_START;
         this.voiceAnimationText.text = "";
         this.masterVivoxVolumeLabel.text = SETTINGS.SOUND_VIVOX_MASTER_VOLUME;
         this.micVivoxVolumeLabel.text = SETTINGS.SOUND_VIVOX_MIC_SENSITIVITY;
         this.masterFadeVivoxVolumeLabel.text = SETTINGS.SOUND_VIVOX_FADE_VOLUME;
         this.alternativeVoicesFieldSet.label = SETTINGS.ALTERNATIVEVOICES_FIELDSET_HEADER;
         this.alternativeVoicesLabel.text = SETTINGS.ALTERNATIVEVOICES_LABELS_VOICEBATTLE;
         this.btnVivoxTest.addEventListener(ButtonEvent.CLICK,this.onBtnVivoxTest);
         this.btnCaptureDevicesUpdate.addEventListener(ButtonEvent.CLICK,this.onCaptureDevicesBtnClick);
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
         this.voiceAnimation.speak(param1);
         this.btnVivoxTest.enabled = this.btnCaptureDevicesUpdate.enabled = !param1;
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
         this.voiceAnimationText.text = "";
         this.btnVivoxTest.enabled = this.btnCaptureDevicesUpdate.enabled = !this.isVoiceTestStarted;
         this.voiceAnimation.speak(this.isVoiceTestStarted);
      }

      override public function update(param1:Object) : void {
         super.update(param1);
      }

      override protected function setData(param1:Object) : void {
         var _loc2_:String = null;
         var _loc3_:SettingsControlProp = null;
         var _loc4_:* = false;
         var _loc5_:CheckBox = null;
         var _loc6_:Slider = null;
         var _loc7_:DropdownMenu = null;
         var _loc8_:KeyInput = null;
         var _loc9_:LabelControl = null;
         super.setData(param1);
         this.showHideVoiceSettings();
         for (_loc2_ in _data)
         {
            _loc3_ = SettingsControlProp(_data[_loc2_]);
            if(this[_loc2_ + _loc3_.type])
            {
               _loc4_ = !(_loc3_.current == null || (_loc3_.readOnly));
               switch(_loc3_.type)
               {
                  case SettingsConfig.TYPE_CHECKBOX:
                     _loc5_ = CheckBox(this[_loc2_ + _loc3_.type]);
                     _loc5_.selected = _loc3_.current;
                     _loc5_.addEventListener(Event.SELECT,this.onCheckBoxSelected);
                     if(_loc2_ == SettingsConfig.ENABLE_VO_IP)
                     {
                        _loc5_.enabled = (SettingsControlProp(_data[SettingsConfig.VOICE_CHAT_SUPORTED]).current) && (_loc4_);
                     }
                     else
                     {
                        _loc5_.enabled = _loc4_;
                     }
                     break;
                  case SettingsConfig.TYPE_SLIDER:
                     _loc6_ = Slider(this[_loc2_ + _loc3_.type]);
                     _loc6_.value = _loc3_.current;
                     _loc6_.addEventListener(SliderEvent.VALUE_CHANGE,this.onSliderValueChanged);
                     _loc6_.enabled = _loc3_.current == null?false:true;
                     if((_loc3_.hasValue) && (this[_loc2_ + SettingsConfig.TYPE_VALUE]))
                     {
                        _loc9_ = this[_loc2_ + SettingsConfig.TYPE_VALUE];
                        _loc9_.text = _loc3_.current;
                     }
                     _loc6_.enabled = _loc4_;
                     break;
                  case SettingsConfig.TYPE_DROPDOWN:
                     _loc7_ = DropdownMenu(this[_loc2_ + _loc3_.type]);
                     _loc7_.dataProvider = new DataProvider(_loc3_.options);
                     _loc7_.selectedIndex = _loc3_.current;
                     _loc7_.addEventListener(ListEvent.INDEX_CHANGE,this.onDropDownChange);
                     _loc7_.enabled = _loc4_;
                     if(_loc2_ == SettingsConfig.ALTERNATIVE_VOICES)
                     {
                        this.showHideAlternativeVoices((_loc4_) && _loc3_.options.length > 1);
                     }
                     break;
                  case SettingsConfig.TYPE_KEYINPUT:
                     _loc8_ = KeyInput(this[_loc2_ + _loc3_.type]);
                     _loc8_.key = _loc3_.current;
                     break;
               }
               trySetLabel(_loc2_,this.LOCALIZATION_PREFIX);
            }
            else
            {
               if(!_loc3_.readOnly)
               {
                  DebugUtils.LOG_WARNING("ERROR in" + this + " control " + (_loc2_ + _loc3_.type) + " can not find");
               }
            }
         }
         if(this.PTTKeyInput)
         {
            this.PTTKeyInput.addEventListener(KeyInputEvents.DISABLE_OVER,this.handleMouseRollOverPTTKey);
            this.PTTKeyInput.addEventListener(KeyInputEvents.DISABLE_OUT,this.handleMouseRollOutPTTKey);
            this.PTTKeyInput.addEventListener(KeyInputEvents.DISABLE_PRESS,this.handleMousePressPTTKey);
         }
         this.onVoiceChatEnabledSelect();
         this.testAlternativeVoicesButton.addEventListener(ButtonEvent.CLICK,this.onTestAlternativeVoicesButtonClick);
         this.testAlternativeVoicesButton.addEventListener(MouseEvent.MOUSE_OVER,this.onTestAlternativeVoicesButtonOver);
         this.testAlternativeVoicesButton.addEventListener(MouseEvent.MOUSE_OUT,this.onTestAlternativeVoicesButtonOut);
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
         this.captureDeviceDropDown.dataProvider = new DataProvider(param2);
         this.captureDeviceDropDown.selectedIndex = param1;
         var _loc4_:String = SettingsConfig.getControlId(this.captureDeviceDropDown.name,SettingsConfig.TYPE_DROPDOWN);
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
         var _loc1_:Boolean = (this.enableVoIPCheckbox.selected) && (SettingsControlProp(_data[SettingsConfig.VOICE_CHAT_SUPORTED]).current);
         if(this.captureDeviceDropDown != null)
         {
            this.captureDeviceDropDown.enabled = _loc1_;
         }
         if(this.micVivoxVolumeSlider != null)
         {
            this.micVivoxVolumeSlider.enabled = _loc1_;
         }
         if(this.btnVivoxTest != null)
         {
            this.btnVivoxTest.enabled = _loc1_;
         }
         if(this.btnCaptureDevicesUpdate != null)
         {
            this.btnCaptureDevicesUpdate.enabled = _loc1_;
         }
         if(this.masterVivoxVolumeSlider != null)
         {
            this.masterVivoxVolumeSlider.enabled = _loc1_;
         }
         if(this.masterFadeVivoxVolumeSlider != null)
         {
            this.masterFadeVivoxVolumeSlider.enabled = _loc1_;
         }
         if(this.captureDeviceDropDown.dataProvider.length == 0)
         {
            this.captureDeviceDropDown.enabled = this.micVivoxVolumeSlider.enabled = this.btnVivoxTest.enabled = false;
         }
      }

      private function showHideVoiceSettings() : void {
         var _loc1_:Boolean = App.voiceChatMgr.isYYS();
         var _loc2_:Boolean = App.voiceChatMgr.isVOIPEnabledS();
         this.voiceConnectFieldSet.visible = _loc2_;
         this.enableVoIPCheckbox.visible = (_loc2_) || (_loc1_);
         this.PTTLabel.visible = _loc2_;
         this.PTTKeyInput.visible = _loc2_;
         this.captureDeviceLabel.visible = _loc2_;
         this.captureDeviceDropDown.visible = _loc2_;
         this.btnCaptureDevicesUpdate.visible = _loc2_;
         this.vivoxTestlabel.visible = _loc2_;
         this.btnVivoxTest.visible = _loc2_;
         this.voiceAnimation.visible = _loc2_;
         this.voiceAnimationText.text = _loc2_?this.voiceAnimationText.text:"";
         this.masterVivoxVolumeLabel.visible = _loc2_;
         this.masterVivoxVolumeSlider.visible = _loc2_;
         this.masterVivoxVolumeValue.visible = _loc2_;
         this.micVivoxVolumeLabel.visible = _loc2_;
         this.micVivoxVolumeSlider.visible = _loc2_;
         this.micVivoxVolumeValue.visible = _loc2_;
         this.masterFadeVivoxVolumeLabel.visible = _loc2_;
         this.masterFadeVivoxVolumeSlider.visible = _loc2_;
         this.masterFadeVivoxVolumeValue.visible = _loc2_;
      }

      override public function dispose() : void {
         var _loc1_:String = null;
         var _loc2_:SettingsControlProp = null;
         var _loc3_:CheckBox = null;
         var _loc4_:Slider = null;
         var _loc5_:DropdownMenu = null;
         this.breakSoundCheck();
         if(this.btnCaptureDevicesUpdate.hasEventListener(ButtonEvent.CLICK))
         {
            this.btnCaptureDevicesUpdate.removeEventListener(ButtonEvent.CLICK,this.onCaptureDevicesBtnClick);
         }
         if(this.btnVivoxTest.hasEventListener(ButtonEvent.CLICK))
         {
            this.btnVivoxTest.removeEventListener(ButtonEvent.CLICK,this.onBtnVivoxTest);
         }
         this.forceFinishVivoxTest();
         for (_loc1_ in _data)
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
         if(this.testAlternativeVoicesButton.hasEventListener(ButtonEvent.CLICK))
         {
            this.testAlternativeVoicesButton.removeEventListener(ButtonEvent.CLICK,this.onTestAlternativeVoicesButtonClick);
         }
         if(this.testAlternativeVoicesButton.hasEventListener(MouseEvent.MOUSE_OVER))
         {
            this.testAlternativeVoicesButton.removeEventListener(MouseEvent.MOUSE_OVER,this.onTestAlternativeVoicesButtonOver);
         }
         if(this.testAlternativeVoicesButton.hasEventListener(MouseEvent.MOUSE_OUT))
         {
            this.testAlternativeVoicesButton.removeEventListener(MouseEvent.MOUSE_OUT,this.onTestAlternativeVoicesButtonOut);
         }
         if(this.PTTKeyInput)
         {
            if(this.PTTKeyInput.hasEventListener(KeyInputEvents.DISABLE_OVER))
            {
               this.PTTKeyInput.removeEventListener(KeyInputEvents.DISABLE_OVER,this.handleMouseRollOverPTTKey);
            }
            if(this.PTTKeyInput.hasEventListener(KeyInputEvents.DISABLE_OUT))
            {
               this.PTTKeyInput.removeEventListener(KeyInputEvents.DISABLE_OUT,this.handleMouseRollOutPTTKey);
            }
            if(this.PTTKeyInput.hasEventListener(KeyInputEvents.DISABLE_PRESS))
            {
               this.PTTKeyInput.removeEventListener(KeyInputEvents.DISABLE_PRESS,this.handleMousePressPTTKey);
            }
         }
         super.dispose();
      }

      public function updatePTTControl(param1:Number) : void {
         this.PTTKeyInput.key = param1;
      }

      private function showHideAlternativeVoices(param1:Boolean) : void {
         this.alternativeVoicesFieldSet.visible = param1;
         this.alternativeVoicesLabel.visible = param1;
         this.alternativeVoicesDropDown.visible = param1;
         this.testAlternativeVoicesButton.visible = param1;
      }

      override public function toString() : String {
         return "[WG SoundSettings " + name + "]";
      }
   }

}