package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface ITrainingWindowMeta extends IEventDispatcher
   {
      
      function getInfoS() : Object;
      
      function getMapsDataS() : Array;
      
      function updateTrainingRoomS(param1:Number, param2:Number, param3:int, param4:String) : void;
   }
}
