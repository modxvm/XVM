package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;
    
    public interface IAwardWindowMeta extends IEventDispatcher
    {
        
        function onOKClickS() : void;
        
        function as_setData(param1:Object) : void;
    }
}
