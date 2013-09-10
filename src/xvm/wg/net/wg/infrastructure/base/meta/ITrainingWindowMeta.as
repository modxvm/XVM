package net.wg.infrastructure.base.meta 
{
    import flash.events.*;
    
    public interface ITrainingWindowMeta extends flash.events.IEventDispatcher
    {
        function getInfoS():Object;

        function getMapsDataS():Array;

        function updateTrainingRoomS(arg1:Number, arg2:Number, arg3:int, arg4:String):void;
    }
}
