package net.wg.infrastructure.base.meta 
{
    import flash.events.*;
    
    public interface IParamsMeta extends flash.events.IEventDispatcher
    {
        function as_setValues(arg1:Array):void;

        function as_highlightParams(arg1:String):void;
    }
}
