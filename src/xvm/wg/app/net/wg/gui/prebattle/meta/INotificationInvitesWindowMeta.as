package net.wg.gui.prebattle.meta
{
   import flash.events.IEventDispatcher;


   public interface INotificationInvitesWindowMeta extends IEventDispatcher
   {
          
      function requestInvitesS() : void;

      function selectedInviteS(param1:Object) : void;

      function as_setInvites(param1:Object) : void;
   }

}