package net.wg.infrastructure.base.meta.impl
{
   import net.wg.infrastructure.base.AbstractWindowView;
   import net.wg.data.constants.Errors;


   public class TechnicalMaintenanceMeta extends AbstractWindowView
   {
          
      public function TechnicalMaintenanceMeta() {
         super();
      }

      public var getEquipment:Function = null;

      public var repair:Function = null;

      public var setRefillSettings:Function = null;

      public var showModuleInfo:Function = null;

      public var fillVehicle:Function = null;

      public var updateEquipmentCurrency:Function = null;

      public function getEquipmentS(param1:String, param2:String, param3:String, param4:String, param5:String, param6:String, param7:int) : void {
         App.utils.asserter.assertNotNull(this.getEquipment,"getEquipment" + Errors.CANT_NULL);
         this.getEquipment(param1,param2,param3,param4,param5,param6,param7);
      }

      public function repairS() : void {
         App.utils.asserter.assertNotNull(this.repair,"repair" + Errors.CANT_NULL);
         this.repair();
      }

      public function setRefillSettingsS(param1:String, param2:Boolean, param3:Boolean, param4:Boolean) : void {
         App.utils.asserter.assertNotNull(this.setRefillSettings,"setRefillSettings" + Errors.CANT_NULL);
         this.setRefillSettings(param1,param2,param3,param4);
      }

      public function showModuleInfoS(param1:String) : void {
         App.utils.asserter.assertNotNull(this.showModuleInfo,"showModuleInfo" + Errors.CANT_NULL);
         this.showModuleInfo(param1);
      }

      public function fillVehicleS(param1:Boolean, param2:Boolean, param3:Boolean, param4:Boolean, param5:Boolean, param6:Boolean, param7:Array, param8:Array) : void {
         App.utils.asserter.assertNotNull(this.fillVehicle,"fillVehicle" + Errors.CANT_NULL);
         this.fillVehicle(param1,param2,param3,param4,param5,param6,param7,param8);
      }

      public function updateEquipmentCurrencyS(param1:Number, param2:String) : void {
         App.utils.asserter.assertNotNull(this.updateEquipmentCurrency,"updateEquipmentCurrency" + Errors.CANT_NULL);
         this.updateEquipmentCurrency(param1,param2);
      }
   }

}