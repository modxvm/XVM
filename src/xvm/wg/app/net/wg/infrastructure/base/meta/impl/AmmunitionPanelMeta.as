package net.wg.infrastructure.base.meta.impl
{
   import net.wg.infrastructure.base.BaseDAAPIComponent;
   import net.wg.data.constants.Errors;


   public class AmmunitionPanelMeta extends BaseDAAPIComponent
   {
          
      public function AmmunitionPanelMeta() {
         super();
      }

      public var setVehicleModule:Function = null;

      public var showModuleInfo:Function = null;

      public var showTechnicalMaintenance:Function = null;

      public var showCustomization:Function = null;

      public var highlightParams:Function = null;

      public function setVehicleModuleS(param1:String, param2:int, param3:String, param4:Boolean) : void {
         App.utils.asserter.assertNotNull(this.setVehicleModule,"setVehicleModule" + Errors.CANT_NULL);
         this.setVehicleModule(param1,param2,param3,param4);
      }

      public function showModuleInfoS(param1:String) : void {
         App.utils.asserter.assertNotNull(this.showModuleInfo,"showModuleInfo" + Errors.CANT_NULL);
         this.showModuleInfo(param1);
      }

      public function showTechnicalMaintenanceS() : void {
         App.utils.asserter.assertNotNull(this.showTechnicalMaintenance,"showTechnicalMaintenance" + Errors.CANT_NULL);
         this.showTechnicalMaintenance();
      }

      public function showCustomizationS() : void {
         App.utils.asserter.assertNotNull(this.showCustomization,"showCustomization" + Errors.CANT_NULL);
         this.showCustomization();
      }

      public function highlightParamsS(param1:String) : void {
         App.utils.asserter.assertNotNull(this.highlightParams,"highlightParams" + Errors.CANT_NULL);
         this.highlightParams(param1);
      }
   }

}