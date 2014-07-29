package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.AbstractWindowView;
    import net.wg.data.constants.Errors;
    
    public class BaseExchangeWindowMeta extends AbstractWindowView
    {
        
        public function BaseExchangeWindowMeta()
        {
            super();
        }
        
        public var exchange:Function = null;
        
        public function exchangeS(param1:Object) : void
        {
            App.utils.asserter.assertNotNull(this.exchange,"exchange" + Errors.CANT_NULL);
            this.exchange(param1);
        }
    }
}
