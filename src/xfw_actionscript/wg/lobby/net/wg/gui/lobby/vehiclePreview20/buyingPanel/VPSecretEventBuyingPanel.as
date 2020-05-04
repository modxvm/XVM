package net.wg.gui.lobby.vehiclePreview20.buyingPanel
{
    import net.wg.infrastructure.base.meta.impl.VehiclePreviewSecretEventBuyingPanelMeta;
    import net.wg.infrastructure.base.meta.IVehiclePreviewSecretEventBuyingPanelMeta;
    import net.wg.utils.IStageSizeDependComponent;
    import flash.display.Sprite;
    import net.wg.gui.components.controls.SoundButtonEx;
    import flash.text.TextField;
    import net.wg.gui.lobby.vehiclePreview20.data.VPSecretEventBuyingPanelVO;
    import net.wg.infrastructure.managers.ITooltipMgr;
    import flash.events.MouseEvent;
    import flash.text.TextFieldAutoSize;
    import scaleform.gfx.TextFieldEx;
    import scaleform.clik.events.ButtonEvent;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.gui.lobby.vehiclePreview20.utils.VehiclePreviewAdaptive;

    public class VPSecretEventBuyingPanel extends VehiclePreviewSecretEventBuyingPanelMeta implements IVehiclePreviewSecretEventBuyingPanelMeta, IVPBottomPanel, IStageSizeDependComponent
    {

        public var mouseHoverZone:Sprite;

        public var buyBtn:SoundButtonEx;

        public var messageLabel:TextField;

        public var vehicleCost:VehicleCostWithDiscount;

        private var _data:VPSecretEventBuyingPanelVO;

        private var _tooltipMgr:ITooltipMgr;

        public function VPSecretEventBuyingPanel()
        {
            this._tooltipMgr = App.toolTipMgr;
            super();
        }

        override protected function configUI() : void
        {
            super.configUI();
            App.stageSizeMgr.register(this);
            this.mouseHoverZone.addEventListener(MouseEvent.ROLL_OVER,this.onMessageLabelRollOverHandler);
            this.mouseHoverZone.addEventListener(MouseEvent.ROLL_OUT,this.onMessageLabelRollOutHandler);
            this.messageLabel.autoSize = TextFieldAutoSize.CENTER;
            TextFieldEx.setVerticalAlign(this.messageLabel,TextFieldEx.VALIGN_BOTTOM);
            this.buyBtn.mouseEnabledOnDisabled = true;
            this.buyBtn.addEventListener(ButtonEvent.CLICK,this.onBuyButtonClickHandler);
        }

        override protected function setData(param1:VPSecretEventBuyingPanelVO) : void
        {
            this._data = param1;
            invalidateData();
        }

        override protected function onDispose() : void
        {
            this._data = null;
            this.mouseHoverZone.removeEventListener(MouseEvent.ROLL_OVER,this.onMessageLabelRollOverHandler);
            this.mouseHoverZone.removeEventListener(MouseEvent.ROLL_OUT,this.onMessageLabelRollOutHandler);
            this.mouseHoverZone = null;
            this.messageLabel = null;
            this.buyBtn.removeEventListener(ButtonEvent.CLICK,this.onBuyButtonClickHandler);
            this.buyBtn.dispose();
            this.buyBtn = null;
            this._tooltipMgr = null;
            this.vehicleCost.dispose();
            this.vehicleCost = null;
            App.stageSizeMgr.unregister(this);
            super.onDispose();
        }

        override protected function draw() : void
        {
            super.draw();
            if(this._data && isInvalid(InvalidationType.DATA))
            {
                this.messageLabel.htmlText = this._data.messageLabel;
                this.vehicleCost.setData(this._data.vehicleCost);
                VPSecretEventUtils.initButton(this.buyBtn,this._data.buyButtonLabel,this._data.buyButtonEnabled);
                VehiclePreviewAdaptive.tweakMessageTextField(this.messageLabel);
            }
            if(isInvalid(InvalidationType.SIZE))
            {
                VehiclePreviewAdaptive.tweakMessageTextField(this.messageLabel);
            }
        }

        public function getBtn() : SoundButtonEx
        {
            return this.buyBtn;
        }

        public function getTotalHeight() : Number
        {
            return height;
        }

        public function setStateSizeBoundaries(param1:int, param2:int) : void
        {
            invalidateSize();
        }

        private function onMessageLabelRollOverHandler(param1:MouseEvent) : void
        {
            if(this._data != null)
            {
                this._tooltipMgr.showSpecial(this._data.messageTooltip,null);
            }
        }

        private function onMessageLabelRollOutHandler(param1:MouseEvent) : void
        {
            this._tooltipMgr.hide();
        }

        private function onBuyButtonClickHandler(param1:ButtonEvent) : void
        {
            onBuyClickS();
        }
    }
}
