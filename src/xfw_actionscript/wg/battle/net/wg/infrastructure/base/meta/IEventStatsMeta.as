package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;

    public interface IEventStatsMeta extends IEventDispatcher
    {

        function as_updatePlayerStats(param1:Object, param2:uint) : void;
    }
}
