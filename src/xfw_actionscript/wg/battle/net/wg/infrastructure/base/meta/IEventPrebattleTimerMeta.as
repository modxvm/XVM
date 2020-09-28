package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;

    public interface IEventPrebattleTimerMeta extends IEventDispatcher
    {

        function highlightedMessageShownS(param1:String) : void;

        function as_queueHighlightedMessage(param1:Object, param2:Boolean) : void;

        function as_showExtraMessage(param1:String, param2:String) : void;
    }
}
