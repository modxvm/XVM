package net.wg.gui.messenger.meta 
{
    import flash.events.*;
    
    public interface IContactsWindowMeta extends flash.events.IEventDispatcher
    {
        function searchContactS(arg1:String):void;

        function addToFriendsS(arg1:Number, arg2:String):void;

        function addToIgnoredS(arg1:Number, arg2:String):void;

        function as_getFriendsDP():Object;

        function as_getClanDP():Object;

        function as_getIgnoredDP():Object;

        function as_getMutedDP():Object;

        function as_getSearchDP():Object;

        function as_setSearchResultText(arg1:String):void;

        function as_frozenSearchAction(arg1:Boolean):void;
    }
}
