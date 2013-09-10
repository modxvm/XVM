package net.wg.infrastructure.base.meta 
{
    import flash.events.*;
    
    public interface IPrbSendInvitesWindowMeta extends flash.events.IEventDispatcher
    {
        function showErrorS(arg1:String):void;

        function searchTokenS(arg1:String):void;

        function setOnlineFlagS(arg1:Boolean):void;

        function sendInvitesS(arg1:Array, arg2:String):void;

        function as_onReceiveSendInvitesCooldown(arg1:uint):void;

        function as_setDefaultOnlineFlag(arg1:Boolean):void;

        function as_getFriendsDP():Object;

        function as_getClanDP():Object;

        function as_getSearchDP():Object;

        function as_getReceiverDP():Object;

        function as_onSearchResultReceived(arg1:Boolean):void;

        function as_setWindowTitle(arg1:String):void;
    }
}
