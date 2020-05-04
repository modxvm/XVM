package net.wg.gui.lobby.vehiclePreview20.buyingPanel
{
    import net.wg.infrastructure.base.UIComponentEx;
    import flash.text.TextField;
    import net.wg.gui.components.controls.price.Discount;
    import flash.display.Sprite;
    import net.wg.gui.lobby.vehiclePreview20.data.VPVehicleCostWithDiscountVO;
    import flash.text.TextFieldAutoSize;
    import scaleform.gfx.TextFieldEx;
    import scaleform.clik.constants.InvalidationType;
    import org.idmedia.as3commons.util.StringUtils;
    import net.wg.gui.components.controls.VO.PriceVO;
    import net.wg.data.constants.generated.CURRENCIES_CONSTANTS;

    public class VehicleCostWithDiscount extends UIComponentEx
    {

        private static const STRIKE_LEFT_MARGIN:int = 4;

        private static const STRIKE_RIGHT_MARGIN:int = 1;

        private static const STRIKE_BOTTOM_MARGIN:int = 9;

        private static const DISCOUNT_MARGIN:int = -3;

        public var buyValueLabel:TextField;

        public var buyValueOldLabel:TextField;

        public var discount:Discount;

        public var strike:Sprite;

        private var _valueLeft:int;

        private var _valueBetween:int;

        private var _valueWidth:int;

        private var _data:VPVehicleCostWithDiscountVO;

        public function VehicleCostWithDiscount()
        {
            super();
        }

        override protected function configUI() : void
        {
            super.configUI();
            this._valueLeft = this.buyValueOldLabel.x;
            this._valueBetween = this.buyValueLabel.x - this.buyValueOldLabel.x - this.buyValueOldLabel.width;
            this._valueWidth = this.buyValueOldLabel.width + this.buyValueLabel.width + this._valueBetween;
            this.buyValueLabel.autoSize = TextFieldAutoSize.LEFT;
            TextFieldEx.setVerticalAlign(this.buyValueLabel,TextFieldEx.VALIGN_BOTTOM);
            this.buyValueOldLabel.autoSize = TextFieldAutoSize.LEFT;
            TextFieldEx.setVerticalAlign(this.buyValueOldLabel,TextFieldEx.VALIGN_BOTTOM);
        }

        override protected function draw() : void
        {
            var _loc1_:* = 0;
            var _loc2_:* = 0;
            if(this._data != null && isInvalid(InvalidationType.DATA))
            {
                this.buyValueLabel.htmlText = this._data.buyValueLabel;
                this.buyValueOldLabel.htmlText = this._data.buyValueOldLabel;
                this.strike.visible = StringUtils.isNotEmpty(this._data.buyValueOldLabel);
                this.discount.state = Discount.WITH_VALUE_STATE;
                this.discount.data = new PriceVO([CURRENCIES_CONSTANTS.GOLD,-this._data.discount]);
                _loc1_ = this.buyValueOldLabel.width + this.buyValueLabel.width + this._valueBetween;
                _loc2_ = this._valueWidth - _loc1_ >> 1;
                this.buyValueOldLabel.x = this._valueLeft + _loc2_;
                this.buyValueLabel.x = this.buyValueOldLabel.x + this.buyValueOldLabel.width + this._valueBetween | 0;
                this.buyValueOldLabel.y = this.buyValueLabel.y + this.buyValueLabel.getLineMetrics(0).ascent - this.buyValueOldLabel.getLineMetrics(0).ascent | 0;
                this.discount.x = this.buyValueLabel.x + this.buyValueLabel.width + DISCOUNT_MARGIN | 0;
                this.strike.y = this.buyValueOldLabel.y + this.buyValueOldLabel.height - STRIKE_BOTTOM_MARGIN | 0;
                this.strike.x = this.buyValueOldLabel.x + STRIKE_RIGHT_MARGIN;
                this.strike.width = this.buyValueOldLabel.width - STRIKE_RIGHT_MARGIN - STRIKE_LEFT_MARGIN | 0;
            }
        }

        override protected function onDispose() : void
        {
            this.buyValueLabel = null;
            this.buyValueOldLabel = null;
            this.discount.dispose();
            this.discount = null;
            this.strike = null;
            this._data = null;
            super.onDispose();
        }

        public function setData(param1:VPVehicleCostWithDiscountVO) : void
        {
            this._data = param1;
            invalidateData();
        }
    }
}
