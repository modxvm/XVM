package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;

    public interface IEventItemPackTradeMeta extends IEventDispatcher
    {

        function closeViewS() : void;

        function backViewS() : void;

        function onButtonPaymentSetPanelClickS(param1:int) : void;

        function as_setData(param1:Object) : void;
    }
}
