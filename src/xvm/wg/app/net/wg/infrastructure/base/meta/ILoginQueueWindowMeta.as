package net.wg.infrastructure.base.meta 
{
    import flash.events.*;
    
    public interface ILoginQueueWindowMeta extends flash.events.IEventDispatcher
    {
        function onCancelClickS():void;

        function as_setTitle(arg1:String):void;

        function as_setMessage(arg1:String):void;

        function as_setCancelLabel(arg1:String):void;
    }
}
