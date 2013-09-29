package net.wg.gui.lobby.dialogs 
{
    public class DemountDeviceDialog extends net.wg.gui.lobby.dialogs.IconPriceDialog
    {
        public function DemountDeviceDialog()
        {
            super();
            return;
        }

        protected override function applyLayout():void
        {
            super.applyLayout();
            textField.y = (priceMc.y - textField.height) / 2;
            return;
        }

        protected override function getTextAreaCurrentHeight():Number
        {
            return textField.textHeight + ADDITIONAL_MULTI_LINE_PADDING;
        }
    }
}
