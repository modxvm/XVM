package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;

    public interface IEventTankRentMeta extends IEventDispatcher
    {

        function onEventRentClickS() : void;

        function onToQuestsClickS() : void;

        function as_setRentData(param1:Object) : void;

        function as_setVisible(param1:Boolean) : void;
    }
}
