package net.wg.gui.lobby.eventStylesTrade.components
{
    import net.wg.infrastructure.base.UIComponentEx;
    import flash.text.TextField;
    import flash.display.MovieClip;
    import net.wg.gui.lobby.eventStylesShopTab.components.ShopTabBanners;
    import net.wg.gui.components.controls.CloseButtonText;
    import net.wg.gui.lobby.eventStylesTrade.data.EventStylesTradeDataVO;
    import flash.events.MouseEvent;
    import net.wg.gui.lobby.eventStylesTrade.events.StylesTradeEvent;

    public class NotEnough extends UIComponentEx
    {

        private static const PRICE_OFFSET:int = 8;

        private static const CLOSE_OFFSET_X:int = 50;

        private static const CLOSE_OFFSET_Y:int = 60;

        public var titleTF:TextField = null;

        public var priceTF:TextField = null;

        public var icon:MovieClip = null;

        public var banners:ShopTabBanners = null;

        public var cancelBtn:CloseButtonText = null;

        public function NotEnough()
        {
            super();
        }

        public function updateClosePosition(param1:Number, param2:Number) : void
        {
            this.cancelBtn.x = param1 - this.cancelBtn.width - CLOSE_OFFSET_X;
            this.cancelBtn.y = param2 + CLOSE_OFFSET_Y;
        }

        public function setData(param1:EventStylesTradeDataVO, param2:int) : void
        {
            this.titleTF.text = EVENT.TRADESTYLES_NOTENOUGH;
            this.priceTF.text = param1.skins[param2].notEnoughCount.toString();
            App.utils.commons.updateTextFieldSize(this.titleTF,true,false);
            App.utils.commons.updateTextFieldSize(this.priceTF,true,false);
            this.titleTF.x = -this.titleTF.width - this.priceTF.width - PRICE_OFFSET - this.icon.width >> 1;
            this.priceTF.x = this.titleTF.x + this.titleTF.width + PRICE_OFFSET >> 0;
            this.icon.x = this.priceTF.x + this.priceTF.width >> 0;
            this.banners.setData(param1.banners);
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.cancelBtn.label = EVENT.TRADESTYLES_CLOSE;
            this.cancelBtn.addEventListener(MouseEvent.CLICK,this.onCancelClickHandler);
        }

        override protected function onBeforeDispose() : void
        {
            this.cancelBtn.removeEventListener(MouseEvent.CLICK,this.onCancelClickHandler);
            super.onBeforeDispose();
        }

        override protected function onDispose() : void
        {
            this.titleTF = null;
            this.priceTF = null;
            this.icon = null;
            this.banners.dispose();
            this.banners = null;
            this.cancelBtn.dispose();
            this.cancelBtn = null;
            super.onDispose();
        }

        private function onCancelClickHandler(param1:MouseEvent) : void
        {
            dispatchEvent(new StylesTradeEvent(StylesTradeEvent.BUY_CANCEL_CLICK));
        }
    }
}
