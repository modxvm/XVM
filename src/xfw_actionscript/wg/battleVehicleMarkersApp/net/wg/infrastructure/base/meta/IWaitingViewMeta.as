package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;

    public interface IWaitingViewMeta extends IEventDispatcher
    {

        function as_showWaiting(param1:String) : void;

        function as_hideWaiting() : void;
    }
}
