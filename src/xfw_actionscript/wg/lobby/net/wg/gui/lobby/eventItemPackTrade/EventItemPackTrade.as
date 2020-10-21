package net.wg.gui.lobby.eventItemPackTrade
{
    import net.wg.infrastructure.base.meta.impl.EventItemPackTradeMeta;
    import net.wg.infrastructure.base.meta.IEventItemPackTradeMeta;
    import net.wg.gui.lobby.eventItemPackTrade.components.EventItemsPackPanel;
    import net.wg.gui.lobby.eventItemPackTrade.data.EventItemPackTradeVO;
    import scaleform.clik.constants.InvalidationType;
    import scaleform.clik.events.ButtonEvent;
    import net.wg.gui.lobby.eventItemsTrade.events.PaymentPanelEvent;

    public class EventItemPackTrade extends EventItemPackTradeMeta implements IEventItemPackTradeMeta
    {

        private static const ITEMS_PACK_PANEL_Y:int = 260;

        private static const ITEMS_PACK_PANEL_MIN_Y:int = 150;

        private static const ITEMS_PACK_PANEL_OFFSET:int = 90;

        private static const SEPARATOR_Y:int = 400;

        private static const SEPARATOR_MIN_Y:int = 240;

        private static const STYLES_INFO_PANEL_Y:int = 430;

        private static const STYLES_INFO_PANEL_MIN_Y:int = 255;

        private static const STYLES_PANEL_Y:int = 480;

        private static const STYLES_PANEL_MIN_Y:int = 280;

        private static const PAYMENT_SET_PANEL_Y:int = 600;

        private static const PAYMENT_SET_PANEL_MIN_Y:int = 370;

        public var itemsPackPanel:EventItemsPackPanel = null;

        public var stylesPanel:EventItemsPackPanel = null;

        private var _data:EventItemPackTradeVO = null;

        public function EventItemPackTrade()
        {
            super();
        }

        override protected function getSeparatorY() : int
        {
            return SEPARATOR_Y;
        }

        override protected function getSeparatorMinY() : int
        {
            return SEPARATOR_MIN_Y;
        }

        override protected function getInfoPanelY() : int
        {
            return STYLES_INFO_PANEL_Y;
        }

        override protected function getInfoPanelMinY() : int
        {
            return STYLES_INFO_PANEL_MIN_Y;
        }

        override protected function getPaymentSetPanelY() : int
        {
            return PAYMENT_SET_PANEL_Y;
        }

        override protected function getPaymentSetPanelMinY() : int
        {
            return PAYMENT_SET_PANEL_MIN_Y;
        }

        override protected function draw() : void
        {
            var _loc1_:* = 0;
            if(this._data && isInvalid(InvalidationType.DATA))
            {
                backDescriptionTF.text = this._data.backDescription;
                headerTF.text = this._data.header;
                this.itemsPackPanel.setData(this._data.items);
                this.itemsPackPanel.layoutElements();
                infoPanel.setData(this._data.infoTitle,this._data.infoDescription,this._data.infoTooltip);
                infoPanel.layoutElements();
                this.stylesPanel.setData(this._data.styles);
                this.stylesPanel.layoutElements();
                paymentSetPanel.setData(this._data.oldPrice,this._data.newPrice,this._data.percent);
                paymentSetPanel.layoutElements();
                paymentSetPanel.btnLabel = this._data.btnLabel;
                paymentSetPanel.btnEnabled = this._data.btnEnabled;
                paymentSetPanel.btnTooltip = this._data.btnTooltip;
            }
            super.draw();
            if(isInvalid(InvalidationType.SIZE))
            {
                this.itemsPackPanel.x = _width - this.itemsPackPanel.width >> 1;
                this.stylesPanel.x = _width - this.stylesPanel.width >> 1;
                this.itemsPackPanel.y = ITEMS_PACK_PANEL_Y - getOffsetTop();
                if(this.itemsPackPanel.y < ITEMS_PACK_PANEL_MIN_Y)
                {
                    this.itemsPackPanel.y = ITEMS_PACK_PANEL_MIN_Y;
                }
                this.stylesPanel.y = STYLES_PANEL_Y - getOffsetTop();
                if(this.stylesPanel.y < STYLES_PANEL_MIN_Y)
                {
                    this.stylesPanel.y = STYLES_PANEL_MIN_Y;
                }
                _loc1_ = this.itemsPackPanel.countLines * ITEMS_PACK_PANEL_OFFSET;
                separator.y = separator.y + _loc1_;
                infoPanel.y = infoPanel.y + _loc1_;
                this.stylesPanel.y = this.stylesPanel.y + _loc1_;
                paymentSetPanel.y = paymentSetPanel.y + _loc1_;
            }
        }

        override protected function setData(param1:EventItemPackTradeVO) : void
        {
            this._data = param1;
            invalidateData();
        }

        override protected function onDispose() : void
        {
            this.itemsPackPanel.dispose();
            this.itemsPackPanel = null;
            this.stylesPanel.dispose();
            this.stylesPanel = null;
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

        override protected function backBtnClickHandler(param1:ButtonEvent) : void
        {
            backViewS();
        }

        override protected function buttonClickHandler(param1:PaymentPanelEvent) : void
        {
            onButtonPaymentSetPanelClickS(param1.count);
        }
    }
}
