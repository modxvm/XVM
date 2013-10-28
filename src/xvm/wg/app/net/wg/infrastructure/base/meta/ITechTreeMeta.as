package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;


   public interface ITechTreeMeta extends IEventDispatcher
   {
          
      function requestNationTreeDataS() : void;

      function getNationTreeDataS(param1:String) : Object;

      function goToNextVehicleS(param1:Number) : void;

      function onCloseTechTreeS() : void;

      function as_setAvailableNations(param1:Array) : void;

      function as_setSelectedNation(param1:String) : void;

      function as_refreshNationTreeData(param1:String) : void;

      function as_setUnlockProps(param1:Array) : void;
   }

}