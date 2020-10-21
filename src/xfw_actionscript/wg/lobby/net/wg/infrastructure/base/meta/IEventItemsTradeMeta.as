package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;

    public interface IEventItemsTradeMeta extends IEventDispatcher
    {

        function closeViewS() : void;

        function backViewS() : void;

        function onButtonPaymentPanelClickS(param1:int) : void;

        function as_setData(param1:Object) : void;

        function as_updateTokens(param1:int) : void;
    }
}
