package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;


   public interface ITankCarouselMeta extends IEventDispatcher
   {
          
      function showVehicleInfoS(param1:String) : void;

      function toResearchS(param1:String) : void;

      function vehicleSellS(param1:String) : void;

      function vehicleChangeS(param1:String) : void;

      function buySlotS() : void;

      function buyTankClickS() : void;

      function setVehiclesFilterS(param1:Number, param2:String, param3:Boolean) : void;

      function favoriteVehicleS(param1:String, param2:Boolean) : void;

      function getVehicleTypeProviderS() : Array;

      function as_vehiclesResponse(param1:Object) : void;

      function as_setCarouselFilter(param1:Object) : void;

      function as_changeVehicleByCompDescr(param1:Number) : void;
   }

}