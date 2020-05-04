package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;

    public interface IMissionDetailsContainerViewMeta extends IEventDispatcher
    {

        function onTokenBuyClickS(param1:String, param2:String) : void;

        function onToEventClickS() : void;

        function as_showBackButton(param1:String, param2:String) : void;

        function as_hideBackButton() : void;
    }
}
