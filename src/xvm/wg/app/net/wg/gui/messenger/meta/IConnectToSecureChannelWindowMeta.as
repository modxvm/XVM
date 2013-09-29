package net.wg.gui.messenger.meta 
{
    import flash.events.*;
    
    public interface IConnectToSecureChannelWindowMeta extends flash.events.IEventDispatcher
    {
        function sendPasswordS(arg1:String):void;

        function cancelPasswordS():void;

        function as_infoMessage(arg1:String):void;
    }
}
