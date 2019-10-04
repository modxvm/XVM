package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;

    public interface IIngameDetailsHelpWindowMeta extends IEventDispatcher
    {

        function requestHelpDataS(param1:int) : void;

        function as_setInitData(param1:Object) : void;

        function as_setHelpData(param1:Object) : void;
    }
}
