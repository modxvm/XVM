package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;

    public interface IEventShopConfirmationMeta extends IEventDispatcher
    {

        function onCancelClickS() : void;

        function onBuyClickS() : void;

        function as_setData(param1:Object) : void;
    }
}
