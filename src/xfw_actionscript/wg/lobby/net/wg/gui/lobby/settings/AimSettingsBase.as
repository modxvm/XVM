package net.wg.gui.lobby.settings
{
    import net.wg.gui.components.advanced.ButtonBarEx;
    import net.wg.gui.components.crosshairPanel.ICrosshair;
    import net.wg.gui.components.crosshairPanel.components.gunMarker.IGunMarker;
    import scaleform.clik.interfaces.IDataProvider;
    import net.wg.gui.lobby.settings.config.SettingsConfigHelper;
    import net.wg.gui.components.crosshairPanel.components.CrosshairClipQuantityBar;
    import net.wg.gui.components.crosshairPanel.constants.CrosshairConsts;

    public class AimSettingsBase extends SettingsBaseView
    {

        protected static const RELOADING_TIME:Number = 4.2;

        protected static const CROSSHAIR_SCALE:Number = 0.14;

        protected static const FORM:String = "Form";

        public var tabs:ButtonBarEx = null;

        public var arcadeForm:SettingsArcadeForm = null;

        public var sniperForm:SettingsSniperForm = null;

        public var arcadeCrosshair:ICrosshair = null;

        public var sniperCrosshair:ICrosshair = null;

        public var gunMarker:IGunMarker = null;

        public function AimSettingsBase()
        {
            super();
        }

        override protected function getButtonBar() : ButtonBarEx
        {
            return this.tabs;
        }

        override protected function getButtonBarDP() : IDataProvider
        {
            return SettingsConfigHelper.instance.cursorTabsDataProvider;
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.arcadeCrosshair.isUseFrameAnimation = false;
            this.arcadeCrosshair.setClipsParam(7,1);
            this.arcadeCrosshair.setAmmoStock(21,7,false,CrosshairClipQuantityBar.STATE_RELOAD_FINISHED,true);
            this.sniperCrosshair.isUseFrameAnimation = false;
            this.sniperCrosshair.setClipsParam(7,1);
            this.sniperCrosshair.setAmmoStock(21,7,false,CrosshairClipQuantityBar.STATE_RELOAD_FINISHED,true);
            this.gunMarker.setMixingScale(CROSSHAIR_SCALE);
            this.gunMarker.setReloadingParams(1,CrosshairConsts.RELOADING_ENDED);
        }

        override protected function onBeforeDispose() : void
        {
            super.onBeforeDispose();
        }

        override protected function onDispose() : void
        {
            this.tabs.dispose();
            this.tabs = null;
            this.gunMarker.dispose();
            this.gunMarker = null;
            this.arcadeCrosshair.dispose();
            this.arcadeCrosshair = null;
            this.sniperCrosshair.dispose();
            this.sniperCrosshair = null;
            this.arcadeForm.dispose();
            this.arcadeForm = null;
            this.sniperForm.dispose();
            this.sniperForm = null;
            super.onDispose();
        }
    }
}
