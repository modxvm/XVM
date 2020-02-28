package net.wg.gui.lobby.vehiclePreview20.buyingPanel
{
    import net.wg.infrastructure.base.meta.impl.VehiclePreviewEventProgressionBuyingPanelMeta;
    import net.wg.infrastructure.base.meta.IVehiclePreviewEventProgressionBuyingPanelMeta;
    import flash.text.TextField;
    import net.wg.gui.components.controls.IconTextBigButton;
    import net.wg.gui.lobby.vehiclePreview20.data.VPEventProgressionBuyingPanelVO;
    import flash.text.TextFieldAutoSize;
    import scaleform.clik.events.ButtonEvent;
    import flash.events.Event;
    import net.wg.gui.lobby.vehiclePreview20.VehiclePreview20Event;
    import flash.events.MouseEvent;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.gui.lobby.vehiclePreview20.data.VPSetItemsVO;
    import net.wg.gui.components.controls.SoundButtonEx;
    import net.wg.gui.lobby.vehiclePreview20.data.VPSetItemVO;

    public class VPEventProgressionBuyingPanel extends VehiclePreviewEventProgressionBuyingPanelMeta implements IVehiclePreviewEventProgressionBuyingPanelMeta, IVPBottomPanel
    {

        private static const BTN_GAP:int = 10;

        private static const PRICE_GAP:int = 15;

        private static const LEFT_OFFSET:int = -15;

        private static const BUTTON_TOP_OFFSET:int = 2;

        private static const MIN_BTNS_WIDTH:int = 160;

        public var moneyLabel:TextField;

        public var priceLabel:TextField;

        public var titleLabel:TextField;

        public var buyBtnOrange:IconTextBigButton = null;

        public var setItemsView:SetItemsView = null;

        private var _data:VPEventProgressionBuyingPanelVO;

        public function VPEventProgressionBuyingPanel()
        {
            super();
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.moneyLabel.autoSize = TextFieldAutoSize.LEFT;
            this.priceLabel.autoSize = TextFieldAutoSize.LEFT;
            this.titleLabel.autoSize = TextFieldAutoSize.LEFT;
            this.buyBtnOrange.mouseEnabledOnDisabled = true;
            this.buyBtnOrange.addEventListener(ButtonEvent.CLICK,this.onBuyButtonClickHandler);
            this.setItemsView.addEventListener(Event.RESIZE,this.onContentResizeHandler);
            this.setItemsView.addEventListener(VehiclePreview20Event.SHOW_TOOLTIP,this.onSetItemsViewShowTooltipHandler);
            this.moneyLabel.addEventListener(MouseEvent.ROLL_OUT,this.onPriceLabelRollOutHandler);
            this.moneyLabel.addEventListener(MouseEvent.ROLL_OVER,this.onPriceLabelRollOverHandler);
            this.priceLabel.addEventListener(MouseEvent.ROLL_OUT,this.onPriceLabelRollOutHandler);
            this.priceLabel.addEventListener(MouseEvent.ROLL_OVER,this.onPriceLabelRollOverHandler);
        }

        override protected function draw() : void
        {
            super.draw();
            if(this._data && isInvalid(InvalidationType.DATA))
            {
                this.moneyLabel.htmlText = this._data.money;
                this.priceLabel.htmlText = this._data.price;
                this.titleLabel.htmlText = this._data.title;
                this.buyBtnOrange.visible = true;
                this.buyBtnOrange.enabled = this._data.buyButtonEnabled;
                this.buyBtnOrange.minWidth = MIN_BTNS_WIDTH;
                this.buyBtnOrange.autoSize = TextFieldAutoSize.CENTER;
                this.buyBtnOrange.label = this._data.buyButtonLabel;
                this.buyBtnOrange.tooltip = this._data.buyButtonTooltip;
                this.buyBtnOrange.validateNow();
                invalidateSize();
            }
            if(isInvalid(InvalidationType.SIZE))
            {
                this.titleLabel.x = (this.width >> 1) - (this.titleLabel.width + this.moneyLabel.width >> 1);
                this.moneyLabel.x = this.titleLabel.x + this.titleLabel.width >> 0;
                this.moneyLabel.y = this.titleLabel.y;
                this.setItemsView.x = this.titleLabel.x + LEFT_OFFSET + this.setItemsView.actualWidth + (this.titleLabel.width - this.setItemsView.actualWidth - this.priceLabel.width - this.buyBtnOrange.width - BTN_GAP - PRICE_GAP >> 1);
                this.priceLabel.x = this.setItemsView.x + PRICE_GAP | 0;
                this.buyBtnOrange.x = this.priceLabel.x + this.priceLabel.width + BTN_GAP | 0;
                this.priceLabel.y = this.setItemsView.y + (SetItemsBlock.BLOCK_HEIGHT - this.priceLabel.height >> 1);
                this.buyBtnOrange.y = this.setItemsView.y + (SetItemsBlock.BLOCK_HEIGHT - this.buyBtnOrange.height >> 1) + BUTTON_TOP_OFFSET;
            }
        }

        override protected function onDispose() : void
        {
            this.priceLabel.removeEventListener(MouseEvent.ROLL_OUT,this.onPriceLabelRollOutHandler);
            this.priceLabel.removeEventListener(MouseEvent.ROLL_OVER,this.onPriceLabelRollOverHandler);
            this.moneyLabel.removeEventListener(MouseEvent.ROLL_OUT,this.onPriceLabelRollOutHandler);
            this.moneyLabel.removeEventListener(MouseEvent.ROLL_OVER,this.onPriceLabelRollOverHandler);
            this.setItemsView.removeEventListener(VehiclePreview20Event.SHOW_TOOLTIP,this.onSetItemsViewShowTooltipHandler);
            this.setItemsView.removeEventListener(Event.RESIZE,this.onContentResizeHandler);
            this.buyBtnOrange.removeEventListener(ButtonEvent.CLICK,this.onBuyButtonClickHandler);
            this.priceLabel = null;
            this.moneyLabel = null;
            this.titleLabel = null;
            this._data = null;
            this.setItemsView.dispose();
            this.setItemsView = null;
            this.buyBtnOrange.dispose();
            this.buyBtnOrange = null;
            super.onDispose();
        }

        override protected function setData(param1:VPEventProgressionBuyingPanelVO) : void
        {
            this._data = param1;
            invalidateData();
        }

        override protected function setSetItemsData(param1:VPSetItemsVO) : void
        {
            this.setItemsView.setData(param1.blocks);
        }

        public function getBtn() : SoundButtonEx
        {
            return this.buyBtnOrange;
        }

        public function getTotalHeight() : Number
        {
            return height;
        }

        override public function get width() : Number
        {
            return this.titleLabel.width;
        }

        private function onBuyButtonClickHandler(param1:ButtonEvent) : void
        {
            onBuyClickS();
        }

        private function onSetItemsViewShowTooltipHandler(param1:VehiclePreview20Event) : void
        {
            param1.stopImmediatePropagation();
            var _loc2_:VPSetItemVO = VPSetItemVO(param1.data);
            showTooltipS(_loc2_.id,_loc2_.type);
        }

        private function onContentResizeHandler(param1:Event) : void
        {
            invalidateSize();
        }

        private function onPriceLabelRollOutHandler(param1:MouseEvent) : void
        {
            this.hideTooltip();
        }

        private function onPriceLabelRollOverHandler(param1:MouseEvent) : void
        {
            this.showComplexTooltip(TOOLTIPS.VEHICLEPREVIEW_BUYINGPANEL_EVENTPROGRESSION_PRICE);
        }

        private function showComplexTooltip(param1:String) : void
        {
            App.toolTipMgr.showComplex(param1);
        }

        private function hideTooltip() : void
        {
            App.toolTipMgr.hide();
        }
    }
}
