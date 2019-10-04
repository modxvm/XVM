package net.wg.gui.lobby.vehicleTradeWnds.sell
{
    import net.wg.infrastructure.base.UIComponentEx;
    import net.wg.gui.components.controls.IconText;
    import flash.text.TextField;

    public class MovingResult extends UIComponentEx
    {

        public var creditsIT:IconText = null;

        public var text:TextField = null;

        public function MovingResult()
        {
            super();
        }

        override protected function configUI() : void
        {
            this.text.text = DIALOGS.CONFIRMMODULEDIALOG_TOTALLABEL;
            this.creditsIT.textFieldYOffset = VehicleSellDialog.ICONS_TEXT_OFFSET;
        }

        override protected function onDispose() : void
        {
            this.creditsIT.dispose();
            this.creditsIT = null;
            this.text = null;
            super.onDispose();
        }
    }
}
