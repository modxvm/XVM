package net.wg.gui.lobby.vehiclePreview.controls
{
    import net.wg.infrastructure.base.UIComponentEx;
    import net.wg.gui.lobby.vehiclePreview.interfaces.IVehPreviewBuyingPanel;
    import net.wg.gui.components.controls.price.CompoundPrice;
    import flash.display.Sprite;
    import net.wg.gui.components.controls.IconTextBigButton;
    import net.wg.gui.interfaces.ISoundButtonEx;
    import net.wg.gui.lobby.vehiclePreview.data.VehPreviewBuyingPanelDataVO;
    import scaleform.clik.events.ButtonEvent;
    import flash.events.MouseEvent;
    import net.wg.gui.data.VehCompareEntrypointVO;
    import net.wg.gui.components.controls.VO.PriceVO;
    import flash.events.Event;
    import net.wg.gui.lobby.vehiclePreview.events.VehPreviewEvent;

    public class VehPreviewBuyingPanel extends UIComponentEx implements IVehPreviewBuyingPanel
    {

        private static const BUTTON_GAP:int = 13;

        private static const BUY_BUTTON_OFFSET:int = 20;

        private static const DATA_INVALID:String = "bDataInvalid";

        public var compoundPrice:CompoundPrice;

        public var glow:Sprite;

        private var _addToCompareBtn:IconTextBigButton;

        private var _buyBtn:ISoundButtonEx;

        private var _buyingData:VehPreviewBuyingPanelDataVO;

        private var _compareBtnEnabled:Boolean = false;

        private var _isBuyingAvailable:Boolean = false;

        public function VehPreviewBuyingPanel()
        {
            super();
        }

        override protected function configUI() : void
        {
            super.configUI();
            this._buyBtn.addEventListener(ButtonEvent.CLICK,this.onBuyButtonClickHandler);
            this._addToCompareBtn.addEventListener(MouseEvent.CLICK,this.onCompareBtnClickHandler);
            this._buyBtn.mouseEnabledOnDisabled = true;
            this.compoundPrice.visible = false;
            this.compoundPrice.bigFonts = true;
            this.compoundPrice.actionState = CompoundPrice.ACTION_STATE_SHOW_VALUE;
            this.compoundPrice.itemsDirection = CompoundPrice.DIRECTION_RIGHT;
            this.compoundPrice.oldPriceVisible = true;
            this.compoundPrice.oldPriceAlign = CompoundPrice.OLD_PRICE_ALIGN_LEFT;
            mouseEnabled = this.glow.mouseEnabled = false;
        }

        override protected function onBeforeDispose() : void
        {
            this._addToCompareBtn.removeEventListener(MouseEvent.CLICK,this.onCompareBtnClickHandler);
            this._buyBtn.removeEventListener(ButtonEvent.CLICK,this.onBuyButtonClickHandler);
            super.onBeforeDispose();
        }

        override protected function onDispose() : void
        {
            this.compoundPrice.dispose();
            this.compoundPrice = null;
            this._addToCompareBtn.dispose();
            this._addToCompareBtn = null;
            this._buyBtn.dispose();
            this._buyBtn = null;
            this._buyingData = null;
            this.glow = null;
            super.onDispose();
        }

        override protected function draw() : void
        {
            super.draw();
            if(this._buyingData != null && isInvalid(DATA_INVALID))
            {
                this.compoundPrice.visible = this._isBuyingAvailable;
                this.layout();
            }
        }

        public function update(param1:VehCompareEntrypointVO, param2:String, param3:Boolean) : void
        {
            if(param1 && param2)
            {
                this._compareBtnEnabled = param1.btnEnabled;
                this._addToCompareBtn.enabled = param1.btnEnabled;
                this._addToCompareBtn.tooltip = param1.btnTooltip;
                this._addToCompareBtn.htmlIconStr = param2;
                this._addToCompareBtn.visible = true;
            }
            else
            {
                this._addToCompareBtn.visible = false;
            }
            this._isBuyingAvailable = param3;
        }

        public function updateData(param1:VehPreviewBuyingPanelDataVO) : void
        {
            var _loc2_:String = null;
            this._buyingData = param1;
            this._buyBtn.enabled = this._buyingData.buyButtonEnabled;
            this._buyBtn.label = this._buyingData.buyButtonLabel;
            this._buyBtn.tooltip = this._buyingData.buyButtonTooltip;
            if(this._isBuyingAvailable)
            {
                this.compoundPrice.setData(this._buyingData.itemPrice);
                _loc2_ = this._buyingData.itemPrice.price.getPriceVO().name;
                this.compoundPrice.updateEnoughStatuses(new <PriceVO>[new PriceVO([_loc2_,int(this._buyingData.isMoneyEnough)])]);
                this.compoundPrice.actionTooltip = this._buyingData.showAction;
            }
            invalidate(DATA_INVALID);
        }

        private function layout() : void
        {
            if(this._isBuyingAvailable)
            {
                this._buyBtn.x = this.compoundPrice.y + this.compoundPrice.contentWidth + BUY_BUTTON_OFFSET | 0;
            }
            else
            {
                this._buyBtn.x = 0;
            }
            if(this._buyingData.showGlow)
            {
                this.glow.x = this._buyBtn.x - (this.glow.width - this._buyBtn.width >> 1);
            }
            this.glow.visible = this._buyingData.showGlow;
            this._addToCompareBtn.x = this._buyBtn.x + this._buyBtn.width + BUTTON_GAP | 0;
            width = actualWidth;
            dispatchEvent(new Event(Event.RESIZE));
        }

        public function get buyBtn() : ISoundButtonEx
        {
            return this._buyBtn;
        }

        public function set buyBtn(param1:ISoundButtonEx) : void
        {
            this._buyBtn = param1;
        }

        public function get addToCompareBtn() : IconTextBigButton
        {
            return this._addToCompareBtn;
        }

        public function set addToCompareBtn(param1:IconTextBigButton) : void
        {
            this._addToCompareBtn = param1;
        }

        private function onCompareBtnClickHandler(param1:Event) : void
        {
            if(this._compareBtnEnabled)
            {
                dispatchEvent(new VehPreviewEvent(VehPreviewEvent.COMPARE_CLICK,true));
            }
        }

        private function onBuyButtonClickHandler(param1:ButtonEvent) : void
        {
            dispatchEvent(new VehPreviewEvent(VehPreviewEvent.BUY_CLICK,true));
        }
    }
}
