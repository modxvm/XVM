package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;

    public interface IGetPremiumPopoverMeta extends IEventDispatcher
    {

        function onActionBtnClickS(param1:Number) : void;

        function as_setData(param1:Object) : void;
    }
}
