package net.wg.gui.lobby.settings.vo.config
{
    import net.wg.gui.lobby.settings.vo.base.SettingsDataVo;
    import net.wg.gui.lobby.settings.vo.SettingsControlProp;
    import net.wg.gui.lobby.settings.config.ControlsFactory;
    import net.wg.gui.lobby.settings.config.SettingsConfigHelper;

    public class OtherSettingsDataVo extends SettingsDataVo
    {

        public var vibroIsConnected:SettingsControlProp = null;

        public var vibroGain:SettingsControlProp = null;

        public var vibroEngine:SettingsControlProp = null;

        public var vibroAcceleration:SettingsControlProp = null;

        public var vibroShots:SettingsControlProp = null;

        public var vibroHits:SettingsControlProp = null;

        public var vibroCollisions:SettingsControlProp = null;

        public var vibroDamage:SettingsControlProp = null;

        public var vibroGUI:SettingsControlProp = null;

        public function OtherSettingsDataVo()
        {
            super({
                "vibroIsConnected":createControl(ControlsFactory.TYPE_CHECKBOX).readOnly(true).build(),
                "vibroGain":createSliderWithLabelAndValue().isDependOn(SettingsConfigHelper.VIBRO_IS_CONNECTED).build(),
                "vibroEngine":createSliderWithLabelAndValue().isDependOn(SettingsConfigHelper.VIBRO_IS_CONNECTED).build(),
                "vibroAcceleration":createSliderWithLabelAndValue().isDependOn(SettingsConfigHelper.VIBRO_IS_CONNECTED).build(),
                "vibroShots":createSliderWithLabelAndValue().isDependOn(SettingsConfigHelper.VIBRO_IS_CONNECTED).build(),
                "vibroHits":createSliderWithLabelAndValue().isDependOn(SettingsConfigHelper.VIBRO_IS_CONNECTED).build(),
                "vibroCollisions":createSliderWithLabelAndValue().isDependOn(SettingsConfigHelper.VIBRO_IS_CONNECTED).build(),
                "vibroDamage":createSliderWithLabelAndValue().isDependOn(SettingsConfigHelper.VIBRO_IS_CONNECTED).build(),
                "vibroGUI":createSliderWithLabelAndValue().isDependOn(SettingsConfigHelper.VIBRO_IS_CONNECTED).build()
            });
        }

        override protected function onDispose() : void
        {
            this.vibroIsConnected = null;
            this.vibroGain = null;
            this.vibroEngine = null;
            this.vibroAcceleration = null;
            this.vibroShots = null;
            this.vibroHits = null;
            this.vibroCollisions = null;
            this.vibroDamage = null;
            this.vibroGUI = null;
            super.onDispose();
        }
    }
}
