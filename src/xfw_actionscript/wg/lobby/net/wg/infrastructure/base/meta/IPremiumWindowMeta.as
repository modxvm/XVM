package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;

    public interface IPremiumWindowMeta extends IEventDispatcher
    {

        function onRateClickS(param1:String) : void;

        function as_setHeader(param1:String, param2:String) : void;

        function as_setRates(param1:Object) : void;
    }
}
