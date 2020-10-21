package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;

    public interface IEventItemsTradeCongratulationMeta extends IEventDispatcher
    {

        function closeViewS() : void;

        function onButtonConfirmationClickS() : void;

        function as_setData(param1:Object) : void;
    }
}
