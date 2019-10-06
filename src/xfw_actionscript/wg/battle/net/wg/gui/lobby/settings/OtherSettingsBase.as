package net.wg.gui.lobby.settings
{
    import net.wg.gui.components.advanced.FieldSet;
    import flash.text.TextField;
    import net.wg.gui.components.controls.Slider;
    import net.wg.gui.components.controls.LabelControl;

    public class OtherSettingsBase extends SettingsBaseView
    {

        public var fieldSetVibro:FieldSet = null;

        public var vibroDeviceConnectionStateField:TextField = null;

        public var vibroGainLabel:TextField = null;

        public var vibroGainSlider:Slider = null;

        public var vibroGainValue:LabelControl = null;

        public var vibroEngineLabel:TextField = null;

        public var vibroEngineSlider:Slider = null;

        public var vibroEngineValue:LabelControl = null;

        public var vibroAccelerationLabel:TextField = null;

        public var vibroAccelerationSlider:Slider = null;

        public var vibroAccelerationValue:LabelControl = null;

        public var vibroShotsLabel:TextField = null;

        public var vibroShotsSlider:Slider = null;

        public var vibroShotsValue:LabelControl = null;

        public var vibroHitsLabel:TextField = null;

        public var vibroHitsSlider:Slider = null;

        public var vibroHitsValue:LabelControl = null;

        public var vibroCollisionsLabel:TextField = null;

        public var vibroCollisionsSlider:Slider = null;

        public var vibroCollisionsValue:LabelControl = null;

        public var vibroDamageLabel:TextField = null;

        public var vibroDamageSlider:Slider = null;

        public var vibroDamageValue:LabelControl = null;

        public var vibroGUILabel:TextField = null;

        public var vibroGUISlider:Slider = null;

        public var vibroGUIValue:LabelControl = null;

        public function OtherSettingsBase()
        {
            super();
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.vibroDeviceConnectionStateField.text = SETTINGS.VIBRO_DEVICE_STATE_NOTCONNECTED;
            this.vibroGainLabel.text = SETTINGS.VIBRO_LABELS_GAIN;
            this.vibroEngineLabel.text = SETTINGS.VIBRO_LABELS_ENGINE;
            this.vibroAccelerationLabel.text = SETTINGS.VIBRO_LABELS_ACCELERATION;
            this.vibroShotsLabel.text = SETTINGS.VIBRO_LABELS_SHOTS;
            this.vibroHitsLabel.text = SETTINGS.VIBRO_LABELS_HITS;
            this.vibroCollisionsLabel.text = SETTINGS.VIBRO_LABELS_COLLISIONS;
            this.vibroDamageLabel.text = SETTINGS.VIBRO_LABELS_DAMAGE;
            this.vibroGUILabel.text = SETTINGS.VIBRO_LABELS_GUI;
            this.fieldSetVibro.label = SETTINGS.VIBRO_FIELDSET_HEADER;
        }

        override protected function onDispose() : void
        {
            this.fieldSetVibro.dispose();
            this.fieldSetVibro = null;
            this.vibroDeviceConnectionStateField = null;
            this.vibroGainLabel = null;
            this.vibroGainSlider.dispose();
            this.vibroGainSlider = null;
            this.vibroGainValue.dispose();
            this.vibroGainValue = null;
            this.vibroEngineLabel = null;
            this.vibroEngineSlider.dispose();
            this.vibroEngineSlider = null;
            this.vibroEngineValue.dispose();
            this.vibroEngineValue = null;
            this.vibroAccelerationLabel = null;
            this.vibroAccelerationSlider.dispose();
            this.vibroAccelerationSlider = null;
            this.vibroAccelerationValue.dispose();
            this.vibroAccelerationValue = null;
            this.vibroShotsLabel = null;
            this.vibroShotsSlider.dispose();
            this.vibroShotsSlider = null;
            this.vibroShotsValue.dispose();
            this.vibroShotsValue = null;
            this.vibroHitsLabel = null;
            this.vibroHitsSlider.dispose();
            this.vibroHitsSlider = null;
            this.vibroHitsValue.dispose();
            this.vibroHitsValue = null;
            this.vibroCollisionsLabel = null;
            this.vibroCollisionsSlider.dispose();
            this.vibroCollisionsSlider = null;
            this.vibroCollisionsValue.dispose();
            this.vibroCollisionsValue = null;
            this.vibroDamageLabel = null;
            this.vibroDamageSlider.dispose();
            this.vibroDamageSlider = null;
            this.vibroDamageValue.dispose();
            this.vibroDamageValue = null;
            this.vibroGUILabel = null;
            this.vibroGUISlider.dispose();
            this.vibroGUISlider = null;
            this.vibroGUIValue.dispose();
            this.vibroGUIValue = null;
            super.onDispose();
        }
    }
}
