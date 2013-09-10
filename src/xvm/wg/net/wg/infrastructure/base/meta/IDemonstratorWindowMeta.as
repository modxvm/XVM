package net.wg.infrastructure.base.meta 
{
    import flash.events.*;
    
    public interface IDemonstratorWindowMeta extends flash.events.IEventDispatcher
    {
        function onMapSelectedS(arg1:Number):void;

        function as_setData(arg1:Object):void;
    }
}
