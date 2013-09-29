package net.wg.infrastructure.base.meta 
{
    import flash.events.*;
    
    public interface IModuleInfoMeta extends flash.events.IEventDispatcher
    {
        function onCancelClickS():void;

        function as_setModuleInfo(arg1:Object):void;
    }
}
