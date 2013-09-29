package net.wg.gui.messenger.meta 
{
    import flash.events.*;
    
    public interface ILobbyChannelWindowMeta extends flash.events.IEventDispatcher
    {
        function as_getMembersDP():Object;

        function as_hideMembersList():void;
    }
}
