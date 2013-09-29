package net.wg.infrastructure.base.meta 
{
    import flash.events.*;
    
    public interface INotificationPopUpViewerMeta extends flash.events.IEventDispatcher
    {
        function setListClearS():void;

        function onMessageHidedS(arg1:Boolean, arg2:Boolean):void;

        function onMessageShowMoreS(arg1:Object):void;

        function onSecuritySettingsLinkClickS():void;

        function as_appendMessage(arg1:Object):void;

        function as_removeAllMessages():void;

        function as_layoutInfo(arg1:Object):void;

        function as_initInfo(arg1:Number, arg2:Number, arg3:Number, arg4:Number):void;
    }
}
