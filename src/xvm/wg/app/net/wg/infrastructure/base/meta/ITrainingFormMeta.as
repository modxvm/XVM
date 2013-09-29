package net.wg.infrastructure.base.meta 
{
    import flash.events.*;
    
    public interface ITrainingFormMeta extends flash.events.IEventDispatcher
    {
        function joinTrainingRequestS(arg1:String):void;

        function createTrainingRequestS():void;

        function onEscapeS():void;

        function as_setList(arg1:Array, arg2:Number):void;
    }
}
