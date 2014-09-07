package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;
    
    public interface IAbstractRallyViewMeta extends IEventDispatcher
    {
        
        function as_setPyAlias(param1:String) : void;
        
        function as_getPyAlias() : String;
    }
}
