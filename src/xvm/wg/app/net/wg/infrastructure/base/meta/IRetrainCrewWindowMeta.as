package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;
    
    public interface IRetrainCrewWindowMeta extends IEventDispatcher
    {
        
        function submitS(param1:Object) : void;
        
        function changeRetrainTypeS(param1:Number) : Object;
        
        function as_setCommonData(param1:Object) : void;
        
        function as_updateData(param1:Object) : void;
    }
}
