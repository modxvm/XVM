package net.wg.gui.lobby.dialogs 
{
    import flash.display.*;
    import net.wg.infrastructure.base.meta.*;
    import net.wg.infrastructure.base.meta.impl.*;
    
    public class IconPriceDialog extends net.wg.infrastructure.base.meta.impl.IconPriceDialogMeta implements net.wg.infrastructure.base.meta.IIconPriceDialogMeta
    {
        public function IconPriceDialog()
        {
            super();
            return;
        }

        protected override function applyLayout():void
        {
            super.applyLayout();
            this.priceMc.y = getBackgroundActualHeight() - this.priceMc.height - PRICE_BOTTOM_OFFSET;
            return;
        }

        protected override function getTextAreaCurrentHeight():Number
        {
            var loc1:*=super.getTextAreaCurrentHeight();
            return loc1 + PRICE_TEXT_OFFSET + this.priceMc.height + PRICE_BOTTOM_OFFSET;
        }

        public function as_setMessagePrice(arg1:String, arg2:String):void
        {
            this.priceMc.priceValue.icon = arg2;
            this.priceMc.priceValue.text = arg1;
            return;
        }

        public function as_setPriceLabel(arg1:String):void
        {
            this.priceMc.textField.text = arg1;
            return;
        }

        protected override function onDispose():void
        {
            var loc1:*=null;
            if (this.priceMc) 
            {
                this.priceMc.dispose();
                loc1 = this.priceMc.parent;
                if (loc1) 
                {
                    loc1.removeChild(this.priceMc);
                }
                this.priceMc = null;
            }
            super.onDispose();
            return;
        }

        public function as_setOperationAllowed(arg1:Boolean):void
        {
            this.priceMc.allowed = arg1;
            return;
        }

        internal static const PRICE_BOTTOM_OFFSET:int=14;

        protected static const PRICE_TEXT_OFFSET:int=13;

        public var priceMc:net.wg.gui.lobby.dialogs.PriceMc;
    }
}
