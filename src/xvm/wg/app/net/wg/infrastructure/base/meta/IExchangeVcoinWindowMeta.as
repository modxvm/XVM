package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;
    
    public interface IExchangeVcoinWindowMeta extends IEventDispatcher
    {
        
        function buyVcoinS() : void;
        
        function as_setTargetCurrencyData(param1:Object) : void;
        
        function as_setSecondaryCurrency(param1:Number) : void;
    }
}
