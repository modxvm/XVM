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
    
    public class SoundSettingsBase extends SettingsBaseView
    {
        
        public function SoundSettingsBase()
        {
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
        
        override protected function configUI() : void
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
            super.configUI();
        }
    }
}
