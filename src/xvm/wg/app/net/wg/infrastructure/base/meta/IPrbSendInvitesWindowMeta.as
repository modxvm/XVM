package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IPrbSendInvitesWindowMeta extends IEventDispatcher
   {
      
      function showErrorS(param1:String) : void;
      
      function searchTokenS(param1:String) : void;
      
      function setOnlineFlagS(param1:Boolean) : void;
      
      function sendInvitesS(param1:Array, param2:String) : void;
      
      function as_onReceiveSendInvitesCooldown(param1:uint) : void;
      
      function as_setDefaultOnlineFlag(param1:Boolean) : void;
      
      function as_showClanOnly(param1:Boolean) : void;
      
      function as_getFriendsDP() : Object;
      
      function as_getClanDP() : Object;
      
      function as_getSearchDP() : Object;
      
      function as_getReceiverDP() : Object;
      
      function as_onSearchResultReceived(param1:Boolean) : void;
      
      function as_setWindowTitle(param1:String) : void;
   }
}
