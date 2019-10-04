package net.wg.gui.lobby.premiumWindow
{
    import net.wg.infrastructure.base.meta.impl.PremiumWindowMeta;
    import net.wg.infrastructure.base.meta.IPremiumWindowMeta;
    import flash.text.TextField;
    import net.wg.gui.lobby.premiumWindow.events.PremiumWindowEvent;
    import flash.text.TextFieldAutoSize;
    import flash.geom.Rectangle;
    import net.wg.gui.lobby.premiumWindow.data.PremiumWindowRatesVO;
    import net.wg.gui.components.windows.SimpleWindow;
    import scaleform.gfx.TextFieldEx;

    public class PremiumWindow extends PremiumWindowMeta implements IPremiumWindowMeta
    {

        private static const CONTENT_MARGIN_BOTTOM:int = 40;

        private static const RATES_TOP_MARGIN:int = 13;

        private static const BTN_ACTION_BUY:String = "buyAction";

        public var prcTf:TextField = null;

        public var bonus1Tf:TextField = null;

        public var premiumBody:PremiumBody = null;

        public function PremiumWindow()
        {
            super();
            contentBottomMargin = CONTENT_MARGIN_BOTTOM;
            TextFieldEx.setForceVector(this.prcTf,true);
        }

        override protected function onDispose() : void
        {
            this.premiumBody.removeEventListener(PremiumWindowEvent.PREMIUM_RENDERER_DOUBLE_CLICK,this.onPremiumRendererDoubleClickHandler);
            this.prcTf = null;
            this.bonus1Tf = null;
            this.premiumBody.dispose();
            this.premiumBody = null;
            super.onDispose();
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.premiumBody.addEventListener(PremiumWindowEvent.PREMIUM_RENDERER_DOUBLE_CLICK,this.onPremiumRendererDoubleClickHandler);
        }

        override protected function initTexts() : void
        {
            this.bonus1Tf.autoSize = TextFieldAutoSize.LEFT;
        }

        override protected function updateCustomLayout(param1:Number, param2:Number) : Rectangle
        {
            this.premiumBody.y = param2 + RATES_TOP_MARGIN;
            var param2:Number = this.premiumBody.y + this.premiumBody.height;
            return new Rectangle(0,0,param1,param2);
        }

        override protected function isBtnHasCustomAction(param1:String) : Boolean
        {
            if(param1 == BTN_ACTION_BUY)
            {
                this.requestForBuy();
                return true;
            }
            return super.isBtnHasCustomAction(param1);
        }

        override protected function setRates(param1:PremiumWindowRatesVO) : void
        {
            this.premiumBody.setData(param1);
            invalidate(SimpleWindow.INVALID_LAYOUT);
        }

        public function as_setHeader(param1:String, param2:String) : void
        {
            this.prcTf.text = param1;
            this.bonus1Tf.text = param2;
        }

        private function requestForBuy() : void
        {
            var _loc1_:String = this.premiumBody.getSelectedRate();
            onRateClickS(_loc1_);
        }

        private function onPremiumRendererDoubleClickHandler(param1:PremiumWindowEvent) : void
        {
            this.requestForBuy();
        }
    }
}
