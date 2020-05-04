package net.wg.gui.lobby.vehiclePreview20.buyingPanel
{
    import net.wg.gui.components.controls.SoundButtonEx;
    import flash.text.TextFieldAutoSize;

    public class VPSecretEventUtils extends Object
    {

        private static const MIN_WIDTH:int = 180;

        private static const BUTTON_PADDING:int = 20;

        public function VPSecretEventUtils()
        {
            super();
        }

        public static function initButton(param1:SoundButtonEx, param2:String, param3:Boolean) : void
        {
            param1.visible = true;
            param1.minWidth = MIN_WIDTH;
            param1.autoSize = TextFieldAutoSize.CENTER;
            param1.label = param2;
            param1.changeSizeOnlyUpwards = true;
            param1.dynamicSizeByText = true;
            param1.paddingHorizontal = BUTTON_PADDING;
            param1.enabled = param3;
        }
    }
}
