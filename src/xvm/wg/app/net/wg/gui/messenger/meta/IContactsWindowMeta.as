package net.wg.gui.messenger.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IContactsWindowMeta extends IEventDispatcher
   {
      
      function searchContactS(param1:String) : void;
      
      function addToFriendsS(param1:Number, param2:String) : void;
      
      function addToIgnoredS(param1:Number, param2:String) : void;
      
      function isEnabledInRoamingS(param1:Number) : Boolean;
      
      function as_getFriendsDP() : Object;
      
      function as_getClanDP() : Object;
      
      function as_getIgnoredDP() : Object;
      
      function as_getMutedDP() : Object;
      
      function as_getSearchDP() : Object;
      
      function as_setSearchResultText(param1:String) : void;
      
      function as_frozenSearchAction(param1:Boolean) : void;
   }
}
