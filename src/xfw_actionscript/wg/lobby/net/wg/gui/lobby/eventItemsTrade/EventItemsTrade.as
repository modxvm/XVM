package net.wg.gui.lobby.eventItemsTrade
{
    import net.wg.infrastructure.base.meta.impl.EventItemsTradeMeta;
    import net.wg.infrastructure.base.meta.IEventItemsTradeMeta;
    import net.wg.gui.components.advanced.BackButton;
    import flash.text.TextField;
    import net.wg.gui.lobby.eventCoins.EventCoins;
    import net.wg.gui.lobby.eventItemsTrade.components.EventPaymentPanel;
    import net.wg.gui.components.controls.UILoaderAlt;
    import flash.display.Sprite;
    import net.wg.gui.lobby.eventItemsTrade.data.EventItemsTradeVO;
    import net.wg.data.constants.generated.HANGAR_ALIASES;
    import scaleform.clik.events.ButtonEvent;
    import net.wg.gui.lobby.eventItemsTrade.events.PaymentPanelEvent;
    import scaleform.clik.constants.InvalidationType;

    public class EventItemsTrade extends EventItemsTradeMeta implements IEventItemsTradeMeta
    {

        private static const SMALL_HEIGHT:int = 900;

        private static const SMALL_WIDTH:int = 1500;

        private static const BACK_DESCRIPTION_OFFSET:int = 2;

        private static const CLOSE_BTN_OFFSET:int = 10;

        private static const HEADER_OFFSET:int = 480;

        private static const ITEM_OFFSET:int = 50;

        private static const MULTIPLIER_OFFSET:int = 363;

        private static const SHADOW_OFFSET:int = 333;

        private static const TITLE_Y:int = 540;

        private static const DESCRIPTION_Y:int = 565;

        private static const ITEM_Y:int = 360;

        private static const SIGN_Y:int = 400;

        private static const MULTIPLIER_Y:int = 600;

        private static const SHADOW_Y:int = 575;

        private static const PAYMENT_PANEL_Y:int = 780;

        private static const CONTENT_WIDTH_BIG:int = 1060;

        private static const CONTENT_WIDTH_SMALL:int = 800;

        private static const COINS_Y:int = 162;

        private static const COINS_OFFSET:int = 62;

        public var backBtn:BackButton = null;

        public var headerTF:TextField = null;

        public var backDescriptionTF:TextField = null;

        public var titleTF:TextField = null;

        public var descriptionTF:TextField = null;

        public var eventCoins:EventCoins = null;

        public var paymentPanel:EventPaymentPanel = null;

        public var item:UILoaderAlt = null;

        public var sign:UILoaderAlt = null;

        public var multiplierTF:TextField = null;

        public var shadow:Sprite = null;

        public var background:Sprite = null;

        private var _data:EventItemsTradeVO = null;

        public function EventItemsTrade()
        {
            super();
        }

        override protected function configUI() : void
        {
            super.configUI();
            closeBtn.label = MENU.VIEWHEADER_CLOSEBTN_LABEL;
            this.backBtn.label = MENU.VIEWHEADER_BACKBTN_LABEL;
            this.paymentPanel.configUI();
            registerFlashComponentS(this.eventCoins,HANGAR_ALIASES.EVENT_COINS_COMPONENT);
            this.backBtn.addEventListener(ButtonEvent.CLICK,this.onBackBtnClickHandler);
            this.paymentPanel.addEventListener(PaymentPanelEvent.PAYMENT_PANEL_BUTTON_CLICK,this.onButtonClickHandler);
        }

        override protected function draw() : void
        {
            var _loc1_:* = 0;
            var _loc2_:* = 0;
            var _loc3_:* = 0;
            var _loc4_:* = false;
            var _loc5_:* = 0;
            var _loc6_:* = 0;
            super.draw();
            if(this._data && isInvalid(InvalidationType.DATA))
            {
                this.backDescriptionTF.text = this._data.backDescription;
                this.headerTF.text = this._data.header;
                this.titleTF.text = this._data.title;
                this.descriptionTF.text = this._data.description;
                this.paymentPanel.setData(this._data.value,this._data.tokens,this._data.availableForPurchase,this._data.count);
                this.paymentPanel.btnLabel = this._data.btnLabel;
                this.paymentPanel.btnTooltip = this._data.btnTooltip;
                this.multiplierTF.text = this._data.multiplier;
                this.item.source = this._data.item;
                this.sign.source = this._data.sign;
            }
            if(isInvalid(InvalidationType.SIZE))
            {
                this.backBtn.validateNow();
                this.backDescriptionTF.x = this.backBtn.x + this.backBtn.hitWidth + BACK_DESCRIPTION_OFFSET;
                closeBtn.validateNow();
                closeBtn.x = _width - closeBtn.width - CLOSE_BTN_OFFSET | 0;
                _loc1_ = _width >> 1;
                _loc2_ = _loc1_ - HEADER_OFFSET;
                this.headerTF.x = _loc2_;
                this.titleTF.x = _loc2_;
                this.descriptionTF.x = _loc2_;
                this.item.x = this.sign.x = _loc1_ + ITEM_OFFSET;
                this.multiplierTF.x = _loc1_ + MULTIPLIER_OFFSET;
                this.shadow.x = _loc1_ + SHADOW_OFFSET;
                this.paymentPanel.x = _width - this.paymentPanel.width >> 1;
                _loc3_ = 0;
                if(_height < SMALL_HEIGHT)
                {
                    _loc3_ = SMALL_HEIGHT - _height;
                }
                this.titleTF.y = TITLE_Y - _loc3_;
                this.descriptionTF.y = DESCRIPTION_Y - _loc3_;
                this.item.y = ITEM_Y - _loc3_;
                this.sign.y = SIGN_Y - _loc3_;
                this.multiplierTF.y = MULTIPLIER_Y - _loc3_;
                this.shadow.y = SHADOW_Y - _loc3_;
                this.paymentPanel.y = PAYMENT_PANEL_Y - _loc3_;
                _loc4_ = _width < SMALL_WIDTH || _height < SMALL_HEIGHT;
                _loc5_ = _loc4_?CONTENT_WIDTH_SMALL:CONTENT_WIDTH_BIG;
                _loc6_ = _loc4_?COINS_OFFSET:0;
                this.eventCoins.x = _width + _loc5_ >> 1;
                this.eventCoins.y = COINS_Y - _loc6_;
                this.background.width = _width;
                this.background.height = _height;
            }
        }

        override protected function setData(param1:EventItemsTradeVO) : void
        {
            this._data = param1;
            invalidateData();
        }

        public function as_updateTokens(param1:int) : void
        {
            this.paymentPanel.updateTokens(param1);
        }

        override protected function onBeforeDispose() : void
        {
            this.paymentPanel.removeEventListener(PaymentPanelEvent.PAYMENT_PANEL_BUTTON_CLICK,this.onButtonClickHandler);
            this.backBtn.removeEventListener(ButtonEvent.CLICK,this.onBackBtnClickHandler);
            super.onBeforeDispose();
        }

        override protected function onDispose() : void
        {
            this.backBtn.dispose();
            this.backBtn = null;
            this.backDescriptionTF = null;
            this.headerTF = null;
            this.titleTF = null;
            this.descriptionTF = null;
            this.eventCoins = null;
            this.paymentPanel.dispose();
            this.paymentPanel = null;
            this.item.dispose();
            this.item = null;
            this.sign.dispose();
            this.sign = null;
            this.multiplierTF = null;
            this.shadow = null;
            this.background = null;
            this._data = null;
            super.onDispose();
        }

        override protected function onCloseBtn() : void
        {
            closeViewS();
        }

        override protected function onEscapeKeyDown() : void
        {
            closeViewS();
        }

        private function onBackBtnClickHandler(param1:ButtonEvent) : void
        {
            backViewS();
        }

        private function onButtonClickHandler(param1:PaymentPanelEvent) : void
        {
            onButtonPaymentPanelClickS(param1.count);
        }
    }
}
