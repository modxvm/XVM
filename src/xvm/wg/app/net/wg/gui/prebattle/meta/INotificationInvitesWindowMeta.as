package net.wg.gui.prebattle.meta 
{
    import flash.events.*;
    
    public interface INotificationInvitesWindowMeta extends flash.events.IEventDispatcher
    {
        function requestInvitesS():void;

        function selectedInviteS(arg1:Object):void;

        function as_setInvites(arg1:Object):void;
    }
}
