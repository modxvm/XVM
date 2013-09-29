package net.wg.infrastructure.base.meta.impl 
{
    import net.wg.data.constants.*;
    import net.wg.infrastructure.base.*;
    
    public class PremiumFormMeta extends net.wg.infrastructure.base.AbstractWindowView
    {
        public function PremiumFormMeta()
        {
            super();
            return;
        }

        public function onPremiumBuyS(arg1:Number, arg2:Number):void
        {
            App.utils.asserter.assertNotNull(this.onPremiumBuy, "onPremiumBuy" + net.wg.data.constants.Errors.CANT_NULL);
            this.onPremiumBuy(arg1, arg2);
            return;
        }

        public function onPremiumDataRequestS():void
        {
            App.utils.asserter.assertNotNull(this.onPremiumDataRequest, "onPremiumDataRequest" + net.wg.data.constants.Errors.CANT_NULL);
            this.onPremiumDataRequest();
            return;
        }

        public var onPremiumBuy:Function=null;

        public var onPremiumDataRequest:Function=null;
    }
}
