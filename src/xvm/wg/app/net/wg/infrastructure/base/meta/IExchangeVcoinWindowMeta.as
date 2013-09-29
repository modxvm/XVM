package net.wg.infrastructure.base.meta 
{
    import flash.events.*;
    
    public interface IExchangeVcoinWindowMeta extends flash.events.IEventDispatcher
    {
        function buyVcoinS():void;

        function as_setTargetCurrencyData(arg1:Object):void;

        function as_setSecondaryCurrency(arg1:Number):void;
    }
}
