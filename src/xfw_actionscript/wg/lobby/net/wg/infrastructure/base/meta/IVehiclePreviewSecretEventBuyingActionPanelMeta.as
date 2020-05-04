package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;

    public interface IVehiclePreviewSecretEventBuyingActionPanelMeta extends IEventDispatcher
    {

        function onActionClickS() : void;

        function as_setActionData(param1:Object) : void;
    }
}
