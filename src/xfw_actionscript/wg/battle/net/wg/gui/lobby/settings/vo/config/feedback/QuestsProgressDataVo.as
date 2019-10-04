package net.wg.gui.lobby.settings.vo.config.feedback
{
    import net.wg.gui.lobby.settings.vo.base.SettingsDataVo;
    import net.wg.gui.lobby.settings.vo.SettingsControlProp;
    import net.wg.gui.lobby.settings.config.ControlsFactory;

    public class QuestsProgressDataVo extends SettingsDataVo
    {

        public var progressViewType:SettingsControlProp = null;

        public var progressViewConditions:SettingsControlProp = null;

        public function QuestsProgressDataVo()
        {
            super({
                "progressViewType":createControl(ControlsFactory.TYPE_BUTTON_BAR).build(),
                "progressViewConditions":createControl(ControlsFactory.TYPE_BUTTON_BAR).build()
            });
        }

        override protected function onDispose() : void
        {
            this.progressViewType = null;
            this.progressViewConditions = null;
            super.onDispose();
        }
    }
}
