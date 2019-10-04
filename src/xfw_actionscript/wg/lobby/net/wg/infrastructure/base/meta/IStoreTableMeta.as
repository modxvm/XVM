package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;

    public interface IStoreTableMeta extends IEventDispatcher
    {

        function refreshStoreTableDataProviderS() : void;

        function as_getTableDataProvider() : Object;

        function as_setData(param1:Object) : void;
    }
}
