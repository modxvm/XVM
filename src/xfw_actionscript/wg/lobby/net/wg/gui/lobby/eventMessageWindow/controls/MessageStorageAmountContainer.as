package net.wg.gui.lobby.eventMessageWindow.controls
{
    import flash.display.MovieClip;
    import flash.text.TextField;

    public class MessageStorageAmountContainer extends MovieClip
    {

        private static const STORAGE_AMOUNT_SPACING:int = 5;

        public var inStorageText:TextField = null;

        public var inStorageAmount:TextField = null;

        public function MessageStorageAmountContainer()
        {
            super();
        }

        public final function dispose() : void
        {
            this.inStorageText = null;
            this.inStorageAmount = null;
        }

        public function updateContent(param1:int) : void
        {
            this.inStorageText.text = EVENT.HANGAR_CREW_BOOSTER_CONFIRM_BUY_INSTORAGE;
            this.inStorageAmount.text = App.utils.locale.integer(param1);
            var _loc2_:* = this.inStorageText.textWidth + STORAGE_AMOUNT_SPACING + this.inStorageAmount.textWidth | 0;
            this.inStorageText.x = -(_loc2_ >> 1);
            this.inStorageAmount.x = this.inStorageText.x + this.inStorageText.textWidth + STORAGE_AMOUNT_SPACING | 0;
        }
    }
}
