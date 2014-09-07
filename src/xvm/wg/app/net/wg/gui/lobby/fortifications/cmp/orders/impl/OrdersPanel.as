package net.wg.gui.lobby.fortifications.cmp.orders.impl
{
    import net.wg.infrastructure.base.meta.impl.OrdersPanelMeta;
    import net.wg.gui.lobby.fortifications.cmp.orders.IOrdersPanel;
    import net.wg.gui.components.advanced.ShellButton;
    import net.wg.gui.lobby.fortifications.data.OrderVO;
    import flash.events.MouseEvent;
    import flash.display.DisplayObject;
    import net.wg.data.constants.Errors;
    import net.wg.data.constants.Tooltips;
    import scaleform.clik.events.ButtonEvent;
    import scaleform.clik.constants.InvalidationType;
    import flash.geom.Point;
    import scaleform.gfx.MouseEventEx;
    import net.wg.data.constants.generated.FORTIFICATION_ALIASES;
    
    public class OrdersPanel extends OrdersPanelMeta implements IOrdersPanel
    {
        
        public function OrdersPanel()
        {
            this.ordersData = [];
            super();
            this.orders = Vector.<ShellButton>([this.order1,this.order2,this.order3,this.order4,this.order5,this.order6,this.order7,this.order8]);
            var _loc1_:uint = 0;
            while(_loc1_ < this.orders.length)
            {
                this.orders[_loc1_].UIID = _loc1_ + 88;
                _loc1_++;
            }
        }
        
        private static var INV_ORDER:String = "invString";
        
        private static function setOrderData(param1:ShellButton, param2:OrderVO) : void
        {
            param1.data = param2;
            param1.level = param2.level;
            param1.count = param2.count.toString();
            param1.id = param2.orderID;
            param1.ammunitionIcon = param2.orderIcon;
            param1.highlightCounter(param2.inProgress);
            param1.isPassive = !param2.enabled;
            if(param2.isRecharged)
            {
                param1.playRechargeAnimation();
            }
            if(param2.inCooldown)
            {
                param1.setCoolDownPosAsPercent(param2.cooldownPercent);
                if(!param2.isPermanent)
                {
                    param1.setCooldown(param2.leftTime);
                }
            }
            else
            {
                param1.clearCoolDownTime();
            }
        }
        
        private static function hideTooltip(param1:MouseEvent) : void
        {
            App.toolTipMgr.hide();
        }
        
        public var order1:ShellButton;
        
        public var order2:ShellButton;
        
        public var order3:ShellButton;
        
        public var order4:ShellButton;
        
        public var order5:ShellButton;
        
        public var order6:ShellButton;
        
        public var order7:ShellButton;
        
        public var order8:ShellButton;
        
        private var orders:Vector.<ShellButton> = null;
        
        private var ordersData:Array;
        
        private var invalidData:OrderVO = null;
        
        private var lastClickedBtn:ShellButton = null;
        
        public function as_setOrders(param1:Array) : void
        {
            this.ordersData = param1;
            invalidateData();
        }
        
        public function getTargetButton() : DisplayObject
        {
            App.utils.asserter.assertNotNull(this.lastClickedBtn,"lastClickedBtn" + Errors.CANT_NULL);
            return this.lastClickedBtn;
        }
        
        public function getHitArea() : DisplayObject
        {
            App.utils.asserter.assertNotNull(this.lastClickedBtn,"lastClickedBtn" + Errors.CANT_NULL);
            return this.lastClickedBtn;
        }
        
        override protected function configUI() : void
        {
            var _loc1_:ShellButton = null;
            super.configUI();
            for each(_loc1_ in this.orders)
            {
                _loc1_.isDischarging = true;
                _loc1_.tooltipType = Tooltips.COMPLEX;
                _loc1_.addEventListener(MouseEvent.MOUSE_OVER,this.showTooltip);
                _loc1_.addEventListener(MouseEvent.MOUSE_OUT,hideTooltip);
                _loc1_.addEventListener(ButtonEvent.CLICK,this.handleBtnSelect);
            }
        }
        
        override protected function updateOrder(param1:OrderVO) : void
        {
            this.invalidData = param1;
            invalidate(INV_ORDER);
        }
        
        override protected function onDispose() : void
        {
            var _loc1_:ShellButton = null;
            if(this.orders)
            {
                for each(_loc1_ in this.orders)
                {
                    _loc1_.removeEventListener(MouseEvent.MOUSE_OVER,this.showTooltip);
                    _loc1_.removeEventListener(MouseEvent.MOUSE_OUT,hideTooltip);
                    _loc1_.removeEventListener(ButtonEvent.CLICK,this.handleBtnSelect);
                    _loc1_.dispose();
                    _loc1_ = null;
                }
                this.orders.splice(0,this.orders.length);
                this.orders = null;
            }
            this.lastClickedBtn = null;
            if(this.invalidData)
            {
                this.invalidData.dispose();
                this.invalidData = null;
            }
            super.onDispose();
        }
        
        override protected function draw() : void
        {
            var _loc1_:* = 0;
            var _loc2_:OrderVO = null;
            var _loc3_:ShellButton = null;
            super.draw();
            if(isInvalid(InvalidationType.DATA))
            {
                if(this.ordersData)
                {
                    _loc1_ = 0;
                    while(_loc1_ < this.ordersData.length)
                    {
                        _loc2_ = new OrderVO(this.ordersData[_loc1_]);
                        _loc3_ = this.orders[_loc1_];
                        setOrderData(_loc3_,_loc2_);
                        _loc1_++;
                    }
                }
            }
            if((isInvalid(INV_ORDER)) && (this.invalidData))
            {
                this.invalidateOrder(this.invalidData);
            }
        }
        
        private function invalidateOrder(param1:OrderVO) : void
        {
            var _loc2_:ShellButton = null;
            for each(_loc2_ in this.orders)
            {
                if(_loc2_.id == param1.orderID)
                {
                    setOrderData(_loc2_,param1);
                    break;
                }
            }
        }
        
        private function handleBtnSelect(param1:ButtonEvent) : void
        {
            var _loc2_:ShellButton = null;
            var _loc3_:* = NaN;
            var _loc4_:* = NaN;
            var _loc5_:Point = null;
            App.eventLogManager.logUIEvent(param1,param1.buttonIdx);
            if(param1.buttonIdx == MouseEventEx.LEFT_BUTTON)
            {
                _loc2_ = param1.target as ShellButton;
                if(_loc2_)
                {
                    this.lastClickedBtn = _loc2_;
                    _loc3_ = Math.round(_loc2_.x);
                    _loc4_ = Math.round(_loc2_.y);
                    _loc5_ = localToGlobal(new Point(_loc3_,_loc4_));
                    App.popoverMgr.show(this,FORTIFICATION_ALIASES.FORT_ORDER_POPOVER_EVENT,_loc2_.id);
                }
            }
        }
        
        private function showTooltip(param1:MouseEvent) : void
        {
            var _loc2_:ShellButton = ShellButton(param1.target);
            var _loc3_:String = getOrderTooltipBodyS(_loc2_.id);
            if(_loc3_.length > 0)
            {
                App.toolTipMgr.showComplex(_loc3_);
            }
        }
    }
}
