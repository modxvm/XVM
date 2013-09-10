package net.wg.infrastructure.base.meta.impl 
{
    import net.wg.data.constants.*;
    import net.wg.infrastructure.base.*;
    
    public class BaseExchangeWindowMeta extends net.wg.infrastructure.base.AbstractWindowView
    {
        public function BaseExchangeWindowMeta()
        {
            super();
            return;
        }

        public function exchangeS(arg1:Object):void
        {
            App.utils.asserter.assertNotNull(this.exchange, "exchange" + net.wg.data.constants.Errors.CANT_NULL);
            this.exchange(arg1);
            return;
        }

        public var exchange:Function=null;
    }
}
