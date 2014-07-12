package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;
    
    public interface ITrainingFormMeta extends IEventDispatcher
    {
        
        function joinTrainingRequestS(param1:String) : void;
        
        function createTrainingRequestS() : void;
        
        function onEscapeS() : void;
        
        function as_setList(param1:Array, param2:Number) : void;
    }
}
