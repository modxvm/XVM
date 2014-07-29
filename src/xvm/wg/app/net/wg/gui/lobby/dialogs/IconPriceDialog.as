package net.wg.gui.lobby.dialogs
{
    import net.wg.infrastructure.base.meta.impl.IconPriceDialogMeta;
    import net.wg.infrastructure.base.meta.IIconPriceDialogMeta;
    import net.wg.gui.components.controls.VO.ActionPriceVO;
    import flash.display.DisplayObjectContainer;
    
    public class IconPriceDialog extends IconPriceDialogMeta implements IIconPriceDialogMeta
    {
        
        public function IconPriceDialog()
        {
            super();
        }
        
        private static var PRICE_BOTTOM_OFFSET:int = 14;
        
        protected static var PRICE_TEXT_OFFSET:int = 13;
        
        public var priceMc:PriceMc;
        
        override protected function applyLayout() : void
        {
            super.applyLayout();
            this.priceMc.y = getBackgroundActualHeight() - this.priceMc.height - PRICE_BOTTOM_OFFSET;
        }
        
        override protected function getTextAreaCurrentHeight() : Number
        {
            var _loc1_:Number = super.getTextAreaCurrentHeight();
            return _loc1_ + PRICE_TEXT_OFFSET + this.priceMc.height + PRICE_BOTTOM_OFFSET;
        }
        
        public function as_setMessagePrice(param1:Number, param2:String, param3:Object) : void
        {
            this.priceMc.currency = param2;
            this.priceMc.price = param1;
            this.priceMc.actionPriceVo = param3?new ActionPriceVO(param3):null;
        }
        
        public function as_setPriceLabel(param1:String) : void
        {
            this.priceMc.textField.text = param1;
        }
        
        override protected function onDispose() : void
        {
            var _loc1_:DisplayObjectContainer = null;
            if(this.priceMc)
            {
                this.priceMc.dispose();
                _loc1_ = this.priceMc.parent;
                if(_loc1_)
                {
                    _loc1_.removeChild(this.priceMc);
                }
                this.priceMc = null;
            }
            super.onDispose();
        }
        
        public function as_setOperationAllowed(param1:Boolean) : void
        {
            this.priceMc.allowed = param1;
        }
    }
}
