package net.wg.gui.lobby.dialogs 
{
    public class DestroyDeviceDialog extends net.wg.gui.lobby.dialogs.IconDialog
    {
        public function DestroyDeviceDialog()
        {
            super();
            return;
        }

        protected override function applyLayout():void
        {
            super.applyLayout();
            textField.y = (ALLOWED_AREA_HEIGHT - textField.height) / 2;
            return;
        }

        protected override function getTextAreaCurrentHeight():Number
        {
            return textField.textHeight + ADDITIONAL_MULTI_LINE_PADDING;
        }

        public static const ALLOWED_AREA_HEIGHT:uint=80;
    }
}
