package net.wg.gui.lobby.battleloading.interfaces
{
   import scaleform.clik.interfaces.IDataProvider;
   import flash.events.IEventDispatcher;


   public interface IVehiclesDataProvider extends IDataProvider, IEventDispatcher
   {
          
      function setSource(param1:Array) : void;

      function setVehicleStatus(param1:Number, param2:Number) : Boolean;

      function setPlayerStatus(param1:Number, param2:Number) : Boolean;

      function addVehicleInfo(param1:Object, param2:Array) : Boolean;

      function updateVehicleInfo(param1:Object) : Boolean;

      function setSorting(param1:Array) : Boolean;
   }

}