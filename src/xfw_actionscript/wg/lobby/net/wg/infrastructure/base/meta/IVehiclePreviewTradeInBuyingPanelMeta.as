package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;

    public interface IVehiclePreviewTradeInBuyingPanelMeta extends IEventDispatcher
    {

        function onBuyClickS() : void;

        function as_setData(param1:Object) : void;
    }
}
