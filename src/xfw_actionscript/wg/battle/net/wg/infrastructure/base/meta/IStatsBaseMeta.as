package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;

    public interface IStatsBaseMeta extends IEventDispatcher
    {

        function acceptSquadS(param1:Number) : void;

        function addToSquadS(param1:Number) : void;

        function as_setIsIntaractive(param1:Boolean) : void;
    }
}
