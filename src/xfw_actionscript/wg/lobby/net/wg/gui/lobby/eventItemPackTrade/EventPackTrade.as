package net.wg.gui.lobby.eventItemPackTrade
{
    import net.wg.infrastructure.base.AbstractScreen;
    import net.wg.gui.components.advanced.BackButton;
    import flash.text.TextField;
    import net.wg.gui.lobby.eventCoins.EventCoins;
    import flash.display.Sprite;
    import net.wg.gui.lobby.eventPlayerPackTrade.components.EventVehicleInfoPanel;
    import net.wg.gui.lobby.eventPlayerPackTrade.components.EventPaymentSetPanel;
    import scaleform.clik.events.ButtonEvent;
    import net.wg.gui.lobby.eventItemsTrade.events.PaymentPanelEvent;
    import net.wg.data.constants.generated.HANGAR_ALIASES;
    import scaleform.clik.constants.InvalidationType;

    public class EventPackTrade extends AbstractScreen
    {

        private static const SMALL_HEIGHT:int = 900;

        private static const SMALL_WIDTH:int = 1500;

        private static const HEIGHT_OFFSET:int = 20;

        private static const BACK_DESCRIPTION_OFFSET:int = 2;

        private static const CLOSE_BTN_OFFSET:int = 10;

        private static const CONTENT_WIDTH_BIG:int = 1060;

        private static const CONTENT_WIDTH_SMALL:int = 800;

        private static const COINS_Y:int = 162;

        private static const COINS_OFFSET:int = 62;

        private static const HEADER_Y:int = 175;

        private static const HEADER_MIN_Y:int = 100;

        public var backBtn:BackButton = null;

        public var headerTF:TextField = null;

        public var backDescriptionTF:TextField = null;

        public var eventCoins:EventCoins = null;

        public var separator:Sprite = null;

        public var infoPanel:EventVehicleInfoPanel = null;

        public var paymentSetPanel:EventPaymentSetPanel = null;

        public var background:Sprite = null;

        public function EventPackTrade()
        {
            super();
        }

        override protected function configUI() : void
        {
            super.configUI();
            closeBtn.label = MENU.VIEWHEADER_CLOSEBTN_LABEL;
            this.backBtn.label = MENU.VIEWHEADER_BACKBTN_LABEL;
            this.backBtn.addEventListener(ButtonEvent.CLICK,this.onBackBtnClickHandler);
            this.paymentSetPanel.addEventListener(PaymentPanelEvent.PAYMENT_PANEL_BUTTON_CLICK,this.onButtonClickHandler);
            this.infoPanel.configUI();
            this.paymentSetPanel.configUI();
            registerFlashComponentS(this.eventCoins,HANGAR_ALIASES.EVENT_COINS_COMPONENT);
        }

        protected function getOffsetTop() : int
        {
            var _loc1_:* = 0;
            if(_height < SMALL_HEIGHT)
            {
                _loc1_ = SMALL_HEIGHT - _height;
            }
            else
            {
                _loc1_ = HEIGHT_OFFSET - (_height - SMALL_HEIGHT >> 1);
            }
            return _loc1_;
        }

        protected function getSeparatorY() : int
        {
            return 0;
        }

        protected function getSeparatorMinY() : int
        {
            return 0;
        }

        protected function getInfoPanelY() : int
        {
            return 0;
        }

        protected function getInfoPanelMinY() : int
        {
            return 0;
        }

        protected function getPaymentSetPanelY() : int
        {
            return 0;
        }

        protected function getPaymentSetPanelMinY() : int
        {
            return 0;
        }

        override protected function draw() : void
        {
            var _loc1_:* = false;
            var _loc2_:* = 0;
            var _loc3_:* = 0;
            super.draw();
            if(isInvalid(InvalidationType.SIZE))
            {
                this.backBtn.validateNow();
                this.backDescriptionTF.x = this.backBtn.x + this.backBtn.hitWidth + BACK_DESCRIPTION_OFFSET;
                closeBtn.validateNow();
                closeBtn.x = _width - closeBtn.width - CLOSE_BTN_OFFSET | 0;
                this.headerTF.x = _width - this.headerTF.width >> 1;
                this.separator.x = _width - this.separator.width >> 1;
                this.infoPanel.x = _width - this.infoPanel.infoWidth >> 1;
                this.paymentSetPanel.x = _width - this.paymentSetPanel.width >> 1;
                this.headerTF.y = HEADER_Y - this.getOffsetTop();
                if(this.headerTF.y < HEADER_MIN_Y)
                {
                    this.headerTF.y = HEADER_MIN_Y;
                }
                this.separator.y = this.getSeparatorY() - this.getOffsetTop();
                if(this.separator.y < this.getSeparatorMinY())
                {
                    this.separator.y = this.getSeparatorMinY();
                }
                this.infoPanel.y = this.getInfoPanelY() - this.getOffsetTop();
                if(this.infoPanel.y < this.getInfoPanelMinY())
                {
                    this.infoPanel.y = this.getInfoPanelMinY();
                }
                this.paymentSetPanel.y = this.getPaymentSetPanelY() - this.getOffsetTop();
                if(this.paymentSetPanel.y < this.getPaymentSetPanelMinY())
                {
                    this.paymentSetPanel.y = this.getPaymentSetPanelMinY();
                }
                _loc1_ = _width < SMALL_WIDTH || _height < SMALL_HEIGHT;
                _loc2_ = _loc1_?CONTENT_WIDTH_SMALL:CONTENT_WIDTH_BIG;
                _loc3_ = _loc1_?COINS_OFFSET:0;
                this.eventCoins.x = _width + _loc2_ >> 1;
                this.eventCoins.y = COINS_Y - _loc3_;
                this.background.width = _width;
                this.background.height = _height;
            }
        }

        override protected function onBeforeDispose() : void
        {
            this.paymentSetPanel.removeEventListener(PaymentPanelEvent.PAYMENT_PANEL_BUTTON_CLICK,this.onButtonClickHandler);
            this.backBtn.removeEventListener(ButtonEvent.CLICK,this.onBackBtnClickHandler);
            super.onBeforeDispose();
        }

        override protected function onDispose() : void
        {
            this.backBtn.dispose();
            this.backBtn = null;
            this.backDescriptionTF = null;
            this.headerTF = null;
            this.eventCoins = null;
            this.separator = null;
            this.infoPanel.dispose();
            this.infoPanel = null;
            this.paymentSetPanel.dispose();
            this.paymentSetPanel = null;
            this.background = null;
            super.onDispose();
        }

        protected function backBtnClickHandler(param1:ButtonEvent) : void
        {
        }

        private function onBackBtnClickHandler(param1:ButtonEvent) : void
        {
            this.backBtnClickHandler(param1);
        }

        protected function buttonClickHandler(param1:PaymentPanelEvent) : void
        {
        }

        private function onButtonClickHandler(param1:PaymentPanelEvent) : void
        {
            this.buttonClickHandler(param1);
        }
    }
}
