package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;

    public interface IBCQuestsViewMeta extends IEventDispatcher
    {

        function onCloseClickedS() : void;

        function as_setData(param1:Object) : void;
    }
}
