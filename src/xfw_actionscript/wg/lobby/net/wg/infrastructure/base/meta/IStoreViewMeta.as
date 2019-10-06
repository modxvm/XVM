package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;

    public interface IStoreViewMeta extends IEventDispatcher
    {

        function onCloseS() : void;

        function onTabChangeS(param1:String) : void;

        function onBackButtonClickS() : void;

        function as_showStorePage(param1:String) : void;

        function as_init(param1:Object) : void;

        function as_showBackButton(param1:String, param2:String) : void;

        function as_hideBackButton() : void;

        function as_setBtnTabCounters(param1:Array) : void;

        function as_removeBtnTabCounters(param1:Array) : void;
    }
}
