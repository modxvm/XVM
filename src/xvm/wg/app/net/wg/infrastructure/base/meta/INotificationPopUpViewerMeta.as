package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;


   public interface INotificationPopUpViewerMeta extends IEventDispatcher
   {
          
      function setListClearS() : void;

      function onMessageHidedS(param1:Boolean, param2:Boolean) : void;

      function onMessageShowMoreS(param1:Object) : void;

      function onSecuritySettingsLinkClickS() : void;

      function as_appendMessage(param1:Object) : void;

      function as_removeAllMessages() : void;

      function as_layoutInfo(param1:Object) : void;

      function as_initInfo(param1:Number, param2:Number, param3:Number, param4:Number) : void;
   }

}