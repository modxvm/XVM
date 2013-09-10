package net.wg.gui.messenger.meta 
{
    import flash.events.*;
    
    public interface IChannelComponentMeta extends flash.events.IEventDispatcher
    {
        function isJoinedS():Boolean;

        function sendMessageS(arg1:String):Boolean;

        function getHistoryS():String;

        function getMessageMaxLengthS():int;

        function as_setJoined(arg1:Boolean):void;

        function as_addMessage(arg1:String):void;
    }
}
