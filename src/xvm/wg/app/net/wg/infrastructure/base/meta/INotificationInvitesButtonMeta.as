package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;


   public interface INotificationInvitesButtonMeta extends IEventDispatcher
   {
          
      function handleClickS() : void;

      function as_setState(param1:Boolean) : void;
   }

}