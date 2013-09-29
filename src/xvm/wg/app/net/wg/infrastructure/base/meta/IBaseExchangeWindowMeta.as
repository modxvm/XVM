package net.wg.infrastructure.base.meta 
{
    import flash.events.*;
    
    public interface IBaseExchangeWindowMeta extends flash.events.IEventDispatcher
    {
        function exchangeS(arg1:Object):void;

        function as_setPrimaryCurrency(arg1:Number):void;

        function as_exchangeRate(arg1:Number, arg2:Number):void;
    }
}
