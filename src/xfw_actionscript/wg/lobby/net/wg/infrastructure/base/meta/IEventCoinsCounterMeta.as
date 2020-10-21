package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;

    public interface IEventCoinsCounterMeta extends IEventDispatcher
    {

        function as_setCoinsCount(param1:int) : void;

        function as_setCoinsTooltip(param1:Object) : void;
    }
}
