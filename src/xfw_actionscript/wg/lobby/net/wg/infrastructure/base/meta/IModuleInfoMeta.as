package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;

    public interface IModuleInfoMeta extends IEventDispatcher
    {

        function onCancelClickS() : void;

        function onActionButtonClickS() : void;

        function as_setModuleInfo(param1:Object) : void;

        function as_setActionButton(param1:Object) : void;
    }
}
