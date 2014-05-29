package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;


   public interface INotificationsListMeta extends IEventDispatcher
   {
          
      function onClickActionS(param1:uint, param2:Number, param3:String) : void;

      function onSecuritySettingsLinkClickS() : void;

      function getMessageActualTimeS(param1:Number) : String;

      function as_setInitData(param1:Object) : void;

      function as_setMessagesList(param1:Array) : void;

      function as_appendMessage(param1:Object) : void;

      function as_updateMessage(param1:Object) : void;
   }

}