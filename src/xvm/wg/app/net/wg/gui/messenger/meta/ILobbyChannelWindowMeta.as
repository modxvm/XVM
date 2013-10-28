package net.wg.gui.messenger.meta
{
   import flash.events.IEventDispatcher;


   public interface ILobbyChannelWindowMeta extends IEventDispatcher
   {
          
      function as_getMembersDP() : Object;

      function as_hideMembersList() : void;
   }

}