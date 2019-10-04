package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;

    public interface IBoosterBuyWindowMeta extends IEventDispatcher
    {

        function buyS(param1:uint) : void;

        function setAutoRearmS(param1:Boolean) : void;

        function as_setInitData(param1:Object) : void;

        function as_updateData(param1:Object) : void;
    }
}
