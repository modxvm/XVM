package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;
    
    public interface IDemonstratorWindowMeta extends IEventDispatcher
    {
        
        function onMapSelectedS(param1:Number) : void;
        
        function as_setData(param1:Object) : void;
    }
}
