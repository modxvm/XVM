package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;

    public interface IEventPlayerLivesMeta extends IEventDispatcher
    {

        function as_setCountLives(param1:int, param2:int, param3:int) : void;
    }
}
