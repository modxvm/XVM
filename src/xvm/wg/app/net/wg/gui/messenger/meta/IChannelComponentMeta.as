package net.wg.gui.messenger.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IChannelComponentMeta extends IEventDispatcher
   {
      
      function isJoinedS() : Boolean;
      
      function sendMessageS(param1:String) : Boolean;
      
      function getHistoryS() : String;
      
      function getMessageMaxLengthS() : int;
      
      function as_setJoined(param1:Boolean) : void;
      
      function as_addMessage(param1:String) : void;
   }
}
