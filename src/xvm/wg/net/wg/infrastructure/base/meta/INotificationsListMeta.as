package net.wg.infrastructure.base.meta 
{
    import flash.events.*;
    
    public interface INotificationsListMeta extends flash.events.IEventDispatcher
    {
        function onWindowCloseS():void;

        function onMessageShowMoreS(arg1:Object):void;

        function onSecuritySettingsLinkClickS():void;

        function as_setInitData(arg1:Object):void;

        function as_setMessagesList(arg1:Array):void;

        function as_appendMessage(arg1:Object):void;

        function as_layoutInfo(arg1:Object):void;
    }
}
