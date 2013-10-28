package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;


   public interface IVehicleInfoMeta extends IEventDispatcher
   {
          
      function getVehicleInfoS() : void;

      function onCancelClickS() : void;

      function as_setVehicleInfo(param1:Object) : void;
   }

}