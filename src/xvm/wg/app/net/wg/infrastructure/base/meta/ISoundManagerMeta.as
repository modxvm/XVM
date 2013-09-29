package net.wg.infrastructure.base.meta 
{
    import flash.events.*;
    
    public interface ISoundManagerMeta extends flash.events.IEventDispatcher
    {
        function soundEventHandlerS(arg1:String, arg2:String, arg3:String, arg4:String):void;
    }
}
