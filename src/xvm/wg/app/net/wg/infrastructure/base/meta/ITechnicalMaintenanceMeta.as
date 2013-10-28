package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;


   public interface ITechnicalMaintenanceMeta extends IEventDispatcher
   {
          
      function getEquipmentS(param1:String, param2:String, param3:String, param4:String, param5:String, param6:String, param7:int) : void;

      function repairS() : void;

      function setRefillSettingsS(param1:String, param2:Boolean, param3:Boolean, param4:Boolean) : void;

      function showModuleInfoS(param1:String) : void;

      function fillVehicleS(param1:Boolean, param2:Boolean, param3:Boolean, param4:Boolean, param5:Boolean, param6:Boolean, param7:Array, param8:Array) : void;

      function as_setData(param1:Object) : void;

      function as_setEquipment(param1:Array, param2:Array, param3:Array) : void;

      function as_onAmmoInstall() : void;

      function as_setCredits(param1:Number) : void;

      function as_setGold(param1:Number) : void;
   }

}