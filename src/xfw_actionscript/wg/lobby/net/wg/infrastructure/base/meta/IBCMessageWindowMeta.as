package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;

    public interface IBCMessageWindowMeta extends IEventDispatcher
    {

        function onMessageRemovedS() : void;

        function onMessageAppearS(param1:String) : void;

        function onMessageDisappearS(param1:String) : void;

        function onMessageButtonClickedS() : void;

        function as_setMessageData(param1:Array) : void;
    }
}
