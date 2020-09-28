package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;

    public interface IWTEventPlayerLivesMeta extends IEventDispatcher
    {

        function as_setCountLives(param1:int, param2:int) : void;
    }
}
