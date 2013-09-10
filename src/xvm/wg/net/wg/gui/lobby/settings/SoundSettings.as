package net.wg.gui.lobby.settings 
{
    import flash.events.*;
    import flash.text.*;
    import flash.utils.*;
    import net.wg.gui.components.advanced.*;
    import net.wg.gui.components.controls.*;
    import net.wg.gui.lobby.settings.components.*;
    import net.wg.gui.lobby.settings.components.evnts.*;
    import net.wg.gui.lobby.settings.evnts.*;
    import net.wg.gui.lobby.settings.vo.*;
    import scaleform.clik.data.*;
    import scaleform.clik.events.*;
    
    public class SoundSettings extends net.wg.gui.lobby.settings.SettingsBaseView
    {
        public function SoundSettings()
        {
            super();
            return;
        }

        public function setCaptureDevices(arg1:Number, arg2:Array):void
        {
            var loc1:*=0;
            while (loc1 < arg2.length) 
            {
                arg2[loc1] = String(arg2[loc1]);
                ++loc1;
            }
            this.captureDeviceDropDown.dataProvider = new scaleform.clik.data.DataProvider(arg2);
            this.captureDeviceDropDown.selectedIndex = arg1;
            var loc2:*=net.wg.gui.lobby.settings.SettingsConfig.getControlId(this.captureDeviceDropDown.name, net.wg.gui.lobby.settings.SettingsConfig.TYPE_DROPDOWN);
            var loc3:*=net.wg.gui.lobby.settings.vo.SettingsControlProp(_data[loc2]);
            if (arg2.length != loc3.options.length) 
                loc3.current = -1;
            loc3.options = arg2;
            dispatchEvent(new net.wg.gui.lobby.settings.evnts.SettingViewEvent(net.wg.gui.lobby.settings.evnts.SettingViewEvent.ON_CONTROL_CHANGED, _viewId, loc2, arg1));
            this.onVoiceChatEnabledSelect();
            return;
        }

        protected override function configUI():void
        {
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
            this.btnVivoxTest.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onBtnVivoxTest);
            this.btnCaptureDevicesUpdate.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onCaptureDevicesBtnClick);
            super.configUI();
            return;
        }

        internal function onBtnVivoxTest(arg1:scaleform.clik.events.ButtonEvent):void
        {
            if (this.isVoiceTestStarted) 
                return;
            dispatchEvent(new net.wg.gui.lobby.settings.evnts.SettingViewEvent(net.wg.gui.lobby.settings.evnts.SettingViewEvent.ON_VIVOX_TEST, _viewId, "", true));
            return;
        }

        public function onViewChanged():void
        {
            this.breakSoundCheck();
            return;
        }

        public function breakSoundCheck():void
        {
            if (this.isVoiceTestStarted) 
                dispatchEvent(new net.wg.gui.lobby.settings.evnts.SettingViewEvent(net.wg.gui.lobby.settings.evnts.SettingViewEvent.ON_VIVOX_TEST, _viewId, "", false));
            return;
        }

        public function setVoiceTestState(arg1:Boolean):void
        {
            if (this.isVoiceTestStarted == arg1) 
                return;
            this.isVoiceTestStarted = arg1;
            this.voiceAnimation.speak(arg1);
            var loc1:*;
            this.btnCaptureDevicesUpdate.enabled = loc1 = !arg1;
            this.btnVivoxTest.enabled = loc1;
            if (arg1 && this.voiceTestTimerID == 0) 
            {
                this.vivoxTestTimeLeft = this.UNCHECK_VOICE_TEST_BTN_TIMEOUT;
                this.voiceTestTimerID = flash.utils.setInterval(this.voiceTimerTest, 100, this);
            }
            else 
                this.forceFinishVivoxTest();
            return;
        }

        internal function voiceTimerTest(arg1:net.wg.gui.lobby.settings.SoundSettings):void
        {
            var loc1:*=null;
            arg1.vivoxTestTimeLeft = arg1.vivoxTestTimeLeft - 100;
            if (arg1.vivoxTestTimeLeft > 0) 
            {
                loc1 = Number(arg1.vivoxTestTimeLeft / 1000).toFixed(1);
                arg1.voiceAnimationText.text = loc1;
            }
            else 
                arg1.dispatchEvent(new net.wg.gui.lobby.settings.evnts.SettingViewEvent(net.wg.gui.lobby.settings.evnts.SettingViewEvent.ON_VIVOX_TEST, arg1._viewId, "", false));
            return;
        }

        internal function forceFinishVivoxTest():void
        {
            if (this.voiceTestTimerID != 0) 
            {
                flash.utils.clearInterval(this.voiceTestTimerID);
                this.voiceTestTimerID = 0;
            }
            this.vivoxTestTimeLeft = 0;
            this.voiceAnimationText.text = "";
            var loc1:*;
            this.btnCaptureDevicesUpdate.enabled = loc1 = !this.isVoiceTestStarted;
            this.btnVivoxTest.enabled = loc1;
            this.voiceAnimation.speak(this.isVoiceTestStarted);
            return;
        }

        public override function update(arg1:Object):void
        {
            super.update(arg1);
            return;
        }

        protected override function setData(arg1:Object):void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=false;
            var loc4:*=null;
            var loc5:*=null;
            var loc6:*=null;
            var loc7:*=null;
            var loc8:*=null;
            super.setData(arg1);
            this.showHideVoiceSettings();
            var loc9:*=0;
            var loc10:*=_data;
            for (loc1 in loc10) 
            {
                loc2 = net.wg.gui.lobby.settings.vo.SettingsControlProp(_data[loc1]);
                if (this[loc1 + loc2.type]) 
                {
                    loc3 = !(loc2.current == null || loc2.readOnly);
                    var loc11:*=loc2.type;
                    switch (loc11) 
                    {
                        case net.wg.gui.lobby.settings.SettingsConfig.TYPE_CHECKBOX:
                            (loc4 = net.wg.gui.components.controls.CheckBox(this[loc1 + loc2.type])).selected = loc2.current;
                            loc4.addEventListener(flash.events.Event.SELECT, this.onCheckBoxSelected);
                            if (loc1 != net.wg.gui.lobby.settings.SettingsConfig.ENABLE_VO_IP) 
                                loc4.enabled = loc3;
                            else 
                                loc4.enabled = net.wg.gui.lobby.settings.vo.SettingsControlProp(_data[net.wg.gui.lobby.settings.SettingsConfig.VOICE_CHAT_SUPORTED]).current && loc3;
                            break;
                        case net.wg.gui.lobby.settings.SettingsConfig.TYPE_SLIDER:
                            (loc5 = net.wg.gui.components.controls.Slider(this[loc1 + loc2.type])).value = loc2.current;
                            loc5.addEventListener(scaleform.clik.events.SliderEvent.VALUE_CHANGE, this.onSliderValueChanged);
                            loc5.enabled = loc2.current != null ? true : false;
                            if (loc2.hasValue && this[loc1 + net.wg.gui.lobby.settings.SettingsConfig.TYPE_VALUE]) 
                                (loc8 = this[loc1 + net.wg.gui.lobby.settings.SettingsConfig.TYPE_VALUE]).text = loc2.current;
                            loc5.enabled = loc3;
                            break;
                        case net.wg.gui.lobby.settings.SettingsConfig.TYPE_DROPDOWN:
                            (loc6 = net.wg.gui.components.controls.DropdownMenu(this[loc1 + loc2.type])).dataProvider = new scaleform.clik.data.DataProvider(loc2.options);
                            loc6.selectedIndex = loc2.current;
                            loc6.addEventListener(scaleform.clik.events.ListEvent.INDEX_CHANGE, this.onDropDownChange);
                            loc6.enabled = loc3;
                            if (loc1 == net.wg.gui.lobby.settings.SettingsConfig.ALTERNATIVE_VOICES) 
                                this.showHideAlternativeVoices(loc3 && loc2.options.length > 1);
                            break;
                        case net.wg.gui.lobby.settings.SettingsConfig.TYPE_KEYINPUT:
                            (loc7 = net.wg.gui.lobby.settings.components.KeyInput(this[loc1 + loc2.type])).key = loc2.current;
                            break;
                    }
                    trySetLabel(loc1, this.LOCALIZATION_PREFIX);
                    continue;
                }
                if (loc2.readOnly) 
                    continue;
                DebugUtils.LOG_WARNING("ERROR in" + this + " control " + (loc1 + loc2.type) + " can not find");
            }
            if (this.PTTKeyInput) 
            {
                this.PTTKeyInput.addEventListener(net.wg.gui.lobby.settings.components.evnts.KeyInputEvents.DISABLE_OVER, this.handleMouseRollOverPTTKey);
                this.PTTKeyInput.addEventListener(net.wg.gui.lobby.settings.components.evnts.KeyInputEvents.DISABLE_OUT, this.handleMouseRollOutPTTKey);
                this.PTTKeyInput.addEventListener(net.wg.gui.lobby.settings.components.evnts.KeyInputEvents.DISABLE_PRESS, this.handleMousePressPTTKey);
            }
            this.onVoiceChatEnabledSelect();
            this.testAlternativeVoicesButton.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onTestAlternativeVoicesButtonClick);
            this.testAlternativeVoicesButton.addEventListener(flash.events.MouseEvent.MOUSE_OVER, this.onTestAlternativeVoicesButtonOver);
            this.testAlternativeVoicesButton.addEventListener(flash.events.MouseEvent.MOUSE_OUT, this.onTestAlternativeVoicesButtonOut);
            return;
        }

        internal function handleMousePressPTTKey(arg1:net.wg.gui.lobby.settings.components.evnts.KeyInputEvents):void
        {
            this.hideTooltip();
            return;
        }

        internal function handleMouseRollOutPTTKey(arg1:net.wg.gui.lobby.settings.components.evnts.KeyInputEvents):void
        {
            this.hideTooltip();
            return;
        }

        internal function handleMouseRollOverPTTKey(arg1:net.wg.gui.lobby.settings.components.evnts.KeyInputEvents):void
        {
            App.toolTipMgr.showComplex(TOOLTIPS.SETTINGS_DIALOG_SOUND_PTTKEY, null);
            return;
        }

        internal function onTestAlternativeVoicesButtonOut(arg1:flash.events.MouseEvent):void
        {
            this.hideTooltip();
            return;
        }

        internal function onTestAlternativeVoicesButtonOver(arg1:flash.events.MouseEvent):void
        {
            App.toolTipMgr.showComplex(TOOLTIPS.SETTINGS_DIALOG_SOUND_ALTERNATIVEVOICES, null);
            return;
        }

        internal function onTestAlternativeVoicesButtonClick(arg1:scaleform.clik.events.ButtonEvent):void
        {
            dispatchEvent(new net.wg.gui.lobby.settings.evnts.AlternativeVoiceEvent(net.wg.gui.lobby.settings.evnts.AlternativeVoiceEvent.ON_TEST_ALTERNATIVE_VOICES));
            return;
        }

        internal function hideTooltip():void
        {
            App.toolTipMgr.hide();
            return;
        }

        internal function onCaptureDevicesBtnClick(arg1:scaleform.clik.events.ButtonEvent):void
        {
            dispatchEvent(new net.wg.gui.lobby.settings.evnts.SettingViewEvent(net.wg.gui.lobby.settings.evnts.SettingViewEvent.ON_UPDATE_CAPTURE_DEVICE, _viewId));
            return;
        }

        internal function onCheckBoxSelected(arg1:flash.events.Event):void
        {
            var loc1:*=net.wg.gui.components.controls.CheckBox(arg1.target);
            var loc2:*=net.wg.gui.lobby.settings.SettingsConfig.getControlId(loc1.name, net.wg.gui.lobby.settings.SettingsConfig.TYPE_CHECKBOX);
            if (loc2 == net.wg.gui.lobby.settings.SettingsConfig.ENABLE_VO_IP) 
                this.onVoiceChatEnabledSelect();
            dispatchEvent(new net.wg.gui.lobby.settings.evnts.SettingViewEvent(net.wg.gui.lobby.settings.evnts.SettingViewEvent.ON_CONTROL_CHANGED, _viewId, loc2, loc1.selected));
            return;
        }

        internal function onSliderValueChanged(arg1:scaleform.clik.events.SliderEvent):void
        {
            var loc4:*=null;
            var loc1:*=net.wg.gui.components.controls.Slider(arg1.target);
            var loc2:*=net.wg.gui.lobby.settings.SettingsConfig.getControlId(loc1.name, net.wg.gui.lobby.settings.SettingsConfig.TYPE_SLIDER);
            var loc3:*;
            if ((loc3 = net.wg.gui.lobby.settings.vo.SettingsControlProp(_data[loc2])).hasValue && this[loc2 + net.wg.gui.lobby.settings.SettingsConfig.TYPE_VALUE]) 
                (loc4 = this[loc2 + net.wg.gui.lobby.settings.SettingsConfig.TYPE_VALUE]).text = loc1.value.toString();
            if (loc2 == net.wg.gui.lobby.settings.SettingsConfig.MIC_VIVOX_VOLUME) 
                this.setVivoxMicVolume(loc1.value);
            dispatchEvent(new net.wg.gui.lobby.settings.evnts.SettingViewEvent(net.wg.gui.lobby.settings.evnts.SettingViewEvent.ON_CONTROL_CHANGED, _viewId, loc2, loc1.value));
            return;
        }

        internal function onDropDownChange(arg1:scaleform.clik.events.ListEvent):void
        {
            var loc1:*=net.wg.gui.components.controls.DropdownMenu(arg1.target);
            var loc2:*=net.wg.gui.lobby.settings.SettingsConfig.getControlId(loc1.name, net.wg.gui.lobby.settings.SettingsConfig.TYPE_DROPDOWN);
            dispatchEvent(new net.wg.gui.lobby.settings.evnts.SettingViewEvent(net.wg.gui.lobby.settings.evnts.SettingViewEvent.ON_CONTROL_CHANGED, _viewId, loc2, loc1.selectedIndex));
            return;
        }

        internal function setVivoxMicVolume(arg1:Number):void
        {
            return;
        }

        internal function onVoiceChatEnabledSelect():void
        {
            this.breakSoundCheck();
            var loc1:*=this.enableVoIPCheckbox.selected && net.wg.gui.lobby.settings.vo.SettingsControlProp(_data[net.wg.gui.lobby.settings.SettingsConfig.VOICE_CHAT_SUPORTED]).current;
            if (this.captureDeviceDropDown != null) 
                this.captureDeviceDropDown.enabled = loc1;
            if (this.micVivoxVolumeSlider != null) 
                this.micVivoxVolumeSlider.enabled = loc1;
            if (this.btnVivoxTest != null) 
                this.btnVivoxTest.enabled = loc1;
            if (this.btnCaptureDevicesUpdate != null) 
                this.btnCaptureDevicesUpdate.enabled = loc1;
            if (this.masterVivoxVolumeSlider != null) 
                this.masterVivoxVolumeSlider.enabled = loc1;
            if (this.masterFadeVivoxVolumeSlider != null) 
                this.masterFadeVivoxVolumeSlider.enabled = loc1;
            if (this.captureDeviceDropDown.dataProvider.length == 0) 
            {
                var loc2:*;
                this.btnVivoxTest.enabled = loc2 = false;
                this.micVivoxVolumeSlider.enabled = loc2 = loc2;
                this.captureDeviceDropDown.enabled = loc2;
            }
            return;
        }

        internal function showHideVoiceSettings():void
        {
            var loc1:*=App.voiceChatMgr.isYYS();
            var loc2:*=App.voiceChatMgr.isVOIPEnabledS();
            this.voiceConnectFieldSet.visible = loc2;
            this.enableVoIPCheckbox.visible = loc2 || loc1;
            this.PTTLabel.visible = loc2;
            this.PTTKeyInput.visible = loc2;
            this.captureDeviceLabel.visible = loc2;
            this.captureDeviceDropDown.visible = loc2;
            this.btnCaptureDevicesUpdate.visible = loc2;
            this.vivoxTestlabel.visible = loc2;
            this.btnVivoxTest.visible = loc2;
            this.voiceAnimation.visible = loc2;
            this.voiceAnimationText.text = loc2 ? this.voiceAnimationText.text : "";
            this.masterVivoxVolumeLabel.visible = loc2;
            this.masterVivoxVolumeSlider.visible = loc2;
            this.masterVivoxVolumeValue.visible = loc2;
            this.micVivoxVolumeLabel.visible = loc2;
            this.micVivoxVolumeSlider.visible = loc2;
            this.micVivoxVolumeValue.visible = loc2;
            this.masterFadeVivoxVolumeLabel.visible = loc2;
            this.masterFadeVivoxVolumeSlider.visible = loc2;
            this.masterFadeVivoxVolumeValue.visible = loc2;
            return;
        }

        public override function dispose():void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=null;
            var loc5:*=null;
            this.breakSoundCheck();
            if (this.btnCaptureDevicesUpdate.hasEventListener(scaleform.clik.events.ButtonEvent.CLICK)) 
                this.btnCaptureDevicesUpdate.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onCaptureDevicesBtnClick);
            if (this.btnVivoxTest.hasEventListener(scaleform.clik.events.ButtonEvent.CLICK)) 
                this.btnVivoxTest.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onBtnVivoxTest);
            this.forceFinishVivoxTest();
            var loc6:*=0;
            var loc7:*=_data;
            label417: for (loc1 in loc7) 
            {
                loc2 = net.wg.gui.lobby.settings.vo.SettingsControlProp(_data[loc1]);
                if (!this[loc1 + loc2.type]) 
                    continue;
                var loc8:*=loc2.type;
                switch (loc8) 
                {
                    case net.wg.gui.lobby.settings.SettingsConfig.TYPE_CHECKBOX:
                        loc3 = this[loc1 + loc2.type];
                        if (loc3.hasEventListener(flash.events.Event.SELECT)) 
                            loc3.removeEventListener(flash.events.Event.SELECT, this.onCheckBoxSelected);
                        continue label417;
                    case net.wg.gui.lobby.settings.SettingsConfig.TYPE_SLIDER:
                        if ((loc4 = this[loc1 + loc2.type]).hasEventListener(scaleform.clik.events.SliderEvent.VALUE_CHANGE)) 
                            loc4.removeEventListener(scaleform.clik.events.SliderEvent.VALUE_CHANGE, this.onSliderValueChanged);
                        continue label417;
                    case net.wg.gui.lobby.settings.SettingsConfig.TYPE_DROPDOWN:
                        if ((loc5 = this[loc1 + loc2.type]).hasEventListener(scaleform.clik.events.ListEvent.INDEX_CHANGE)) 
                            loc5.removeEventListener(scaleform.clik.events.ListEvent.INDEX_CHANGE, this.onDropDownChange);
                        continue label417;
                }
            }
            if (this.testAlternativeVoicesButton.hasEventListener(scaleform.clik.events.ButtonEvent.CLICK)) 
                this.testAlternativeVoicesButton.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onTestAlternativeVoicesButtonClick);
            if (this.testAlternativeVoicesButton.hasEventListener(flash.events.MouseEvent.MOUSE_OVER)) 
                this.testAlternativeVoicesButton.removeEventListener(flash.events.MouseEvent.MOUSE_OVER, this.onTestAlternativeVoicesButtonOver);
            if (this.testAlternativeVoicesButton.hasEventListener(flash.events.MouseEvent.MOUSE_OUT)) 
                this.testAlternativeVoicesButton.removeEventListener(flash.events.MouseEvent.MOUSE_OUT, this.onTestAlternativeVoicesButtonOut);
            if (this.PTTKeyInput) 
            {
                if (this.PTTKeyInput.hasEventListener(net.wg.gui.lobby.settings.components.evnts.KeyInputEvents.DISABLE_OVER)) 
                    this.PTTKeyInput.removeEventListener(net.wg.gui.lobby.settings.components.evnts.KeyInputEvents.DISABLE_OVER, this.handleMouseRollOverPTTKey);
                if (this.PTTKeyInput.hasEventListener(net.wg.gui.lobby.settings.components.evnts.KeyInputEvents.DISABLE_OUT)) 
                    this.PTTKeyInput.removeEventListener(net.wg.gui.lobby.settings.components.evnts.KeyInputEvents.DISABLE_OUT, this.handleMouseRollOutPTTKey);
                if (this.PTTKeyInput.hasEventListener(net.wg.gui.lobby.settings.components.evnts.KeyInputEvents.DISABLE_PRESS)) 
                    this.PTTKeyInput.removeEventListener(net.wg.gui.lobby.settings.components.evnts.KeyInputEvents.DISABLE_PRESS, this.handleMousePressPTTKey);
            }
            super.dispose();
            return;
        }

        public function updatePTTControl(arg1:Number):void
        {
            this.PTTKeyInput.key = arg1;
            return;
        }

        internal function showHideAlternativeVoices(arg1:Boolean):void
        {
            this.alternativeVoicesFieldSet.visible = arg1;
            this.alternativeVoicesLabel.visible = arg1;
            this.alternativeVoicesDropDown.visible = arg1;
            this.testAlternativeVoicesButton.visible = arg1;
            return;
        }

        public override function toString():String
        {
            return "[WG SoundSettings " + name + "]";
        }

        internal const UNCHECK_VOICE_TEST_BTN_TIMEOUT:Number=10000;

        internal const LOCALIZATION_PREFIX:String="";

        public var PTTKeyInput:net.wg.gui.lobby.settings.components.KeyInput=null;

        public var captureDeviceLabel:net.wg.gui.components.controls.LabelControl=null;

        public var captureDeviceDropDown:net.wg.gui.components.controls.DropdownMenu=null;

        public var btnCaptureDevicesUpdate:net.wg.gui.components.controls.SoundButtonEx=null;

        public var vivoxTestlabel:net.wg.gui.components.controls.LabelControl=null;

        public var btnVivoxTest:net.wg.gui.components.controls.SoundButtonEx=null;

        public var voiceAnimationText:flash.text.TextField=null;

        public var masterVivoxVolumeLabel:net.wg.gui.components.controls.LabelControl=null;

        public var masterVivoxVolumeSlider:net.wg.gui.components.controls.Slider=null;

        public var voiceVolumeValue:net.wg.gui.components.controls.LabelControl=null;

        public var micVivoxVolumeLabel:net.wg.gui.components.controls.LabelControl=null;

        public var micVivoxVolumeSlider:net.wg.gui.components.controls.Slider=null;

        public var micVivoxVolumeValue:net.wg.gui.components.controls.LabelControl=null;

        public var masterFadeVivoxVolumeLabel:net.wg.gui.components.controls.LabelControl=null;

        public var masterFadeVivoxVolumeSlider:net.wg.gui.components.controls.Slider=null;

        public var masterFadeVivoxVolumeValue:net.wg.gui.components.controls.LabelControl=null;

        public var voiceAnimation:net.wg.gui.lobby.settings.components.SoundVoiceWaves=null;

        internal var isVoiceTestStarted:Boolean=false;

        public var volumeFieldSet:net.wg.gui.components.advanced.FieldSet=null;

        internal var voiceTestTimerID:uint=0;

        internal var vivoxTestTimeLeft:Number=0;

        public var masterVolumeLabel:net.wg.gui.components.controls.LabelControl=null;

        public var masterVolumeSlider:net.wg.gui.components.controls.Slider=null;

        public var masterVolumeValue:net.wg.gui.components.controls.LabelControl=null;

        public var musicVolumeLabel:net.wg.gui.components.controls.LabelControl=null;

        public var musicVolumeSlider:net.wg.gui.components.controls.Slider=null;

        public var musicVolumeValue:net.wg.gui.components.controls.LabelControl=null;

        public var voiceVolumeLabel:net.wg.gui.components.controls.LabelControl=null;

        public var voiceVolumeSlider:net.wg.gui.components.controls.Slider=null;

        public var vehiclesVolumeLabel:net.wg.gui.components.controls.LabelControl=null;

        public var vehiclesVolumeSlider:net.wg.gui.components.controls.Slider=null;

        public var vehiclesVolumeValue:net.wg.gui.components.controls.LabelControl=null;

        public var effectsVolumeLabel:net.wg.gui.components.controls.LabelControl=null;

        public var effectsVolumeSlider:net.wg.gui.components.controls.Slider=null;

        public var effectsVolumeValue:net.wg.gui.components.controls.LabelControl=null;

        public var guiVolumeLabel:net.wg.gui.components.controls.LabelControl=null;

        public var guiVolumeSlider:net.wg.gui.components.controls.Slider=null;

        public var guiVolumeValue:net.wg.gui.components.controls.LabelControl=null;

        public var ambientVolumeLabel:net.wg.gui.components.controls.LabelControl=null;

        public var masterVivoxVolumeValue:net.wg.gui.components.controls.LabelControl=null;

        public var ambientVolumeSlider:net.wg.gui.components.controls.Slider=null;

        public var ambientVolumeValue:net.wg.gui.components.controls.LabelControl=null;

        public var nationalVoicesCheckbox:net.wg.gui.components.controls.CheckBox=null;

        public var alternativeVoicesFieldSet:net.wg.gui.components.advanced.FieldSet=null;

        public var alternativeVoicesLabel:net.wg.gui.components.controls.LabelControl=null;

        public var alternativeVoicesDropDown:net.wg.gui.components.controls.DropdownMenu=null;

        public var testAlternativeVoicesButton:net.wg.gui.components.controls.IconButton=null;

        public var voiceConnectFieldSet:net.wg.gui.components.advanced.FieldSet=null;

        public var enableVoIPCheckbox:net.wg.gui.components.controls.CheckBox=null;

        public var PTTLabel:net.wg.gui.components.controls.LabelControl=null;
    }
}
