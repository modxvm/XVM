package net.wg.gui.prebattle.meta 
{
    import flash.events.*;
    
    public interface IReceivedInviteWindowMeta extends flash.events.IEventDispatcher
    {
        function acceptInviteS():void;

        function declineInviteS():void;

        function cancelInviteS():void;

        function as_setTitle(arg1:String):void;

        function as_setReceivedInviteInfo(arg1:Object):void;
    }
}
