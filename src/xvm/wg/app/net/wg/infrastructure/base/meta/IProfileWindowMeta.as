package net.wg.infrastructure.base.meta 
{
    import flash.events.*;
    
    public interface IProfileWindowMeta extends flash.events.IEventDispatcher
    {
        function as_setInitData(arg1:Object):void;

        function as_update(arg1:Object):void;
    }
}
