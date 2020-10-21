package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;

    public interface IEventManageCrewMeta extends IEventDispatcher
    {

        function onApplyS() : void;

        function as_setData(param1:Object) : void;

        function as_setVisible(param1:Boolean) : void;
    }
}
