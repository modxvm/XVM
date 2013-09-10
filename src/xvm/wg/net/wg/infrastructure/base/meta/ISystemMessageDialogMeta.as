package net.wg.infrastructure.base.meta 
{
    import flash.events.*;
    
    public interface ISystemMessageDialogMeta extends flash.events.IEventDispatcher
    {
        function as_setInitData(arg1:Object):void;

        function as_setMessageData(arg1:Object):void;
    }
}
