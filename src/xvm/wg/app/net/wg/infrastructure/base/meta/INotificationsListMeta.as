package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;


   public interface INotificationsListMeta extends IEventDispatcher
   {
          
      function onWindowCloseS() : void;

      function onMessageShowMoreS(param1:Object) : void;

      function onSecuritySettingsLinkClickS() : void;

      function as_setInitData(param1:Object) : void;

      function as_setMessagesList(param1:Array) : void;

      function as_appendMessage(param1:Object) : void;

      function as_layoutInfo(param1:Object) : void;
   }

}