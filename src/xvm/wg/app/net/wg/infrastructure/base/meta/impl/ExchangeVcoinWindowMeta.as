package net.wg.infrastructure.base.meta.impl
{
    import net.wg.data.constants.Errors;
    
    public class ExchangeVcoinWindowMeta extends BaseExchangeWindowMeta
    {
        
        public function ExchangeVcoinWindowMeta()
        {
            super();
        }
        
        public var buyVcoin:Function = null;
        
        public function buyVcoinS() : void
        {
            App.utils.asserter.assertNotNull(this.buyVcoin,"buyVcoin" + Errors.CANT_NULL);
            this.buyVcoin();
        }
    }
}
