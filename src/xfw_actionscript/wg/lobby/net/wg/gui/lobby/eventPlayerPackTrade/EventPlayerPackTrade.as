package net.wg.gui.lobby.eventPlayerPackTrade
{
    import net.wg.infrastructure.base.meta.impl.EventPlayerPackTradeMeta;
    import net.wg.infrastructure.base.meta.IEventPlayerPackTradeMeta;
    import net.wg.gui.lobby.eventPlayerPackTrade.components.EventItemsPanel;
    import net.wg.gui.lobby.eventPlayerPackTrade.components.EventVehiclePanel;
    import flash.text.TextField;
    import net.wg.gui.lobby.eventPlayerPackTrade.data.EventPlayerPackTradeVO;
    import scaleform.clik.constants.InvalidationType;
    import scaleform.clik.events.ButtonEvent;
    import net.wg.gui.lobby.eventItemsTrade.events.PaymentPanelEvent;

    public class EventPlayerPackTrade extends EventPlayerPackTradeMeta implements IEventPlayerPackTradeMeta
    {

        private static const ITEMS_PANEL_Y:int = 280;

        private static const ITEMS_PANEL_MIN_Y:int = 155;

        private static const SEPARATOR_Y:int = 500;

        private static const SEPARATOR_MIN_Y:int = 360;

        private static const VEHICLE_INFO_PANEL_Y:int = 530;

        private static const VEHICLE_INFO_PANEL_MIN_Y:int = 375;

        private static const VEHICLE_PANEL_Y:int = 580;

        private static const VEHICLE_PANEL_MIN_Y:int = 400;

        private static const DESCRIPTION_Y:int = 740;

        private static const DESCRIPTION_MIN_Y:int = 530;

        private static const PAYMENT_SET_PANEL_Y:int = 780;

        private static const PAYMENT_SET_PANEL_MIN_Y:int = 560;

        public var itemsPanel:EventItemsPanel = null;

        public var vehiclePanel:EventVehiclePanel = null;

        public var descriptionTF:TextField = null;

        private var _data:EventPlayerPackTradeVO = null;

        public function EventPlayerPackTrade()
        {
            super();
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.itemsPanel.configUI();
            this.vehiclePanel.configUI();
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
            return VEHICLE_INFO_PANEL_Y;
        }

        override protected function getInfoPanelMinY() : int
        {
            return VEHICLE_INFO_PANEL_MIN_Y;
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
            if(this._data && isInvalid(InvalidationType.DATA))
            {
                backDescriptionTF.text = this._data.backDescription;
                headerTF.text = this._data.header;
                this.itemsPanel.setItem1(this._data.item1);
                this.itemsPanel.setItem2(this._data.item2);
                this.itemsPanel.setItem3(this._data.item3);
                infoPanel.setData(this._data.infoTitle,this._data.infoDescription,this._data.infoTooltip);
                infoPanel.layoutElements();
                this.vehiclePanel.setItem1(this._data.vehicle1);
                this.vehiclePanel.setItem2(this._data.vehicle2);
                this.vehiclePanel.layoutElements();
                this.descriptionTF.text = this._data.description;
                paymentSetPanel.setData(this._data.oldPrice,this._data.newPrice,this._data.percent);
                paymentSetPanel.layoutElements();
                paymentSetPanel.btnLabel = this._data.btnLabel;
                paymentSetPanel.btnEnabled = this._data.btnEnabled;
                paymentSetPanel.btnTooltip = this._data.btnTooltip;
            }
            if(isInvalid(InvalidationType.SIZE))
            {
                this.itemsPanel.x = _width - this.itemsPanel.width >> 1;
                this.vehiclePanel.x = _width - this.vehiclePanel.width >> 1;
                this.descriptionTF.x = _width - this.descriptionTF.width >> 1;
                this.itemsPanel.y = ITEMS_PANEL_Y - getOffsetTop();
                if(this.itemsPanel.y < ITEMS_PANEL_MIN_Y)
                {
                    this.itemsPanel.y = ITEMS_PANEL_MIN_Y;
                }
                this.vehiclePanel.y = VEHICLE_PANEL_Y - getOffsetTop();
                if(this.vehiclePanel.y < VEHICLE_PANEL_MIN_Y)
                {
                    this.vehiclePanel.y = VEHICLE_PANEL_MIN_Y;
                }
                this.descriptionTF.y = DESCRIPTION_Y - getOffsetTop();
                if(this.descriptionTF.y < DESCRIPTION_MIN_Y)
                {
                    this.descriptionTF.y = DESCRIPTION_MIN_Y;
                }
            }
            super.draw();
        }

        override protected function setData(param1:EventPlayerPackTradeVO) : void
        {
            this._data = param1;
            invalidateData();
        }

        override protected function onDispose() : void
        {
            this.itemsPanel.dispose();
            this.itemsPanel = null;
            this.vehiclePanel.dispose();
            this.vehiclePanel = null;
            this.descriptionTF = null;
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
