package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;

    public interface IEventQuestsPanelMeta extends IEventDispatcher
    {

        function onQuestPanelClickS() : void;

        function as_setListDataProvider(param1:Array) : void;
    }
}
