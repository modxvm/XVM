package net.wg.infrastructure.base.meta 
{
    import flash.events.*;
    
    public interface INotificationListButtonMeta extends flash.events.IEventDispatcher
    {
        function handleClickS():void;

        function as_setState(arg1:Boolean):void;
    }
}
