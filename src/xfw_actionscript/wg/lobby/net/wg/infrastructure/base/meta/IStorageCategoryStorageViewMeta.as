package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;

    public interface IStorageCategoryStorageViewMeta extends IEventDispatcher
    {

        function onOpenTabS(param1:String) : void;

        function as_setTabsData(param1:Array) : void;
    }
}
