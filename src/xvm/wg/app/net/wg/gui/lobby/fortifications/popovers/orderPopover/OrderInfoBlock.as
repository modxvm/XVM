package net.wg.gui.lobby.fortifications.popovers.orderPopover
{
    import scaleform.clik.core.UIComponent;
    import flash.events.MouseEvent;
    import flash.text.TextField;
    import net.wg.gui.components.controls.SoundButton;
    import scaleform.clik.constants.InvalidationType;
    
    public class OrderInfoBlock extends UIComponent
    {
        
        public function OrderInfoBlock()
        {
            super();
            this.createOrderBtn.UIID = 95;
        }
        
        private static var INV_PARAM:String = "invParam";
        
        private static var INV_CREATE_ORDER_BTN:String = "invCreateOrderBtn";
        
        private static var TEXT_PADDING:int = 5;
        
        private static var AFTER_BUILDING_PADDING:int = 15;
        
        private static var VERTICAL_PADDING:int = 21;
        
        private static function showTooltip(param1:MouseEvent) : void
        {
            var _loc2_:String = App.utils.locale.makeString(TOOLTIPS.FORTIFICATION_ORDERPOPOVER_LINKBTN);
            App.toolTipMgr.show(_loc2_);
        }
        
        private static function hideTooltip(param1:MouseEvent) : void
        {
            if(param1.type == MouseEvent.CLICK)
            {
                App.eventLogManager.logUIEvent(param1,0);
            }
            App.toolTipMgr.hide();
        }
        
        public var durationValue:TextField;
        
        public var productionTimeValue:TextField;
        
        public var buildingValue:TextField;
        
        public var priceValue:TextField;
        
        public var producedValue:TextField;
        
        public var durationName:TextField;
        
        public var productionTimeName:TextField;
        
        public var buildingName:TextField;
        
        public var priceName:TextField;
        
        public var producedName:TextField;
        
        public var createOrderBtn:SoundButton;
        
        private var _duration:String = "";
        
        private var _productionTime:String = "";
        
        private var _building:String = "";
        
        private var _price:String = "";
        
        private var _producedAmount:String = "";
        
        private var _showCreateOrderBtn:Boolean = true;
        
        public function set duration(param1:String) : void
        {
            this._duration = param1;
            invalidate(INV_PARAM);
        }
        
        public function set productionTime(param1:String) : void
        {
            this._productionTime = param1;
            invalidate(INV_PARAM);
        }
        
        public function set building(param1:String) : void
        {
            this._building = param1;
            invalidate(INV_PARAM);
        }
        
        public function set price(param1:String) : void
        {
            this._price = param1;
            invalidate(INV_PARAM);
        }
        
        public function set producedAmount(param1:String) : void
        {
            this._producedAmount = param1;
            invalidate(INV_PARAM);
        }
        
        public function get showCreateOrderBtn() : Boolean
        {
            return this._showCreateOrderBtn;
        }
        
        public function set showCreateOrderBtn(param1:Boolean) : void
        {
            this._showCreateOrderBtn = param1;
            invalidate(INV_CREATE_ORDER_BTN);
        }
        
        override protected function configUI() : void
        {
            super.configUI();
            this.createOrderBtn.addEventListener(MouseEvent.MOUSE_OVER,showTooltip);
            this.createOrderBtn.addEventListener(MouseEvent.CLICK,hideTooltip);
            this.createOrderBtn.addEventListener(MouseEvent.MOUSE_OUT,hideTooltip);
            this.durationName.text = FORTIFICATIONS.ORDERS_ORDERPOPOVER_DURATIONTIME;
            this.productionTimeName.text = FORTIFICATIONS.ORDERS_ORDERPOPOVER_PRODUCTIONTIME;
            this.buildingName.text = FORTIFICATIONS.ORDERS_ORDERPOPOVER_PRODUCTIONBUILDING;
            this.priceName.text = FORTIFICATIONS.ORDERS_ORDERPOPOVER_ORDERPRICE;
            this.producedName.text = FORTIFICATIONS.ORDERS_ORDERPOPOVER_PRODUCEDAMOUNT;
        }
        
        override protected function draw() : void
        {
            var _loc1_:* = NaN;
            var _loc2_:* = NaN;
            var _loc3_:* = NaN;
            super.draw();
            if(isInvalid(INV_PARAM))
            {
                this.durationValue.htmlText = this._duration;
                this.productionTimeValue.htmlText = this._productionTime;
                this.buildingValue.htmlText = this._building;
                this.priceValue.htmlText = this._price;
                this.producedValue.htmlText = this._producedAmount;
                invalidateSize();
            }
            if(isInvalid(INV_CREATE_ORDER_BTN))
            {
                this.createOrderBtn.visible = this._showCreateOrderBtn;
            }
            if(isInvalid(InvalidationType.SIZE))
            {
                this.buildingValue.height = this.buildingValue.textHeight + TEXT_PADDING;
                this.buildingName.height = this.buildingName.textHeight + TEXT_PADDING;
                _loc1_ = Math.round(this.buildingValue.y + this.buildingValue.height + AFTER_BUILDING_PADDING);
                _loc2_ = Math.round(this.buildingName.y + this.buildingName.height + AFTER_BUILDING_PADDING);
                this.priceValue.y = this.priceName.y = Math.max(_loc1_,_loc2_);
                this.producedValue.y = this.producedName.y = Math.round(this.priceValue.y + VERTICAL_PADDING);
                this.createOrderBtn.y = Math.round(this.producedName.y + (this.producedName.height - this.createOrderBtn.height + 4) / 2);
                this.createOrderBtn.x = Math.round(this.producedName.x + this.producedName.textWidth + TEXT_PADDING * 2);
                _loc3_ = Math.round(this.producedValue.y + this.producedValue.textHeight + TEXT_PADDING);
                setSize(this.width,_loc3_);
            }
        }
        
        override protected function onDispose() : void
        {
            this.durationValue = null;
            this.productionTimeValue = null;
            this.buildingValue = null;
            this.priceValue = null;
            this.producedValue = null;
            this.durationName = null;
            this.productionTimeName = null;
            this.buildingName = null;
            this.priceName = null;
            this.producedName = null;
            if(this.createOrderBtn)
            {
                this.createOrderBtn.removeEventListener(MouseEvent.MOUSE_OVER,showTooltip);
                this.createOrderBtn.removeEventListener(MouseEvent.CLICK,hideTooltip);
                this.createOrderBtn.removeEventListener(MouseEvent.MOUSE_OUT,hideTooltip);
                this.createOrderBtn.dispose();
                this.createOrderBtn = null;
            }
            super.onDispose();
        }
    }
}
