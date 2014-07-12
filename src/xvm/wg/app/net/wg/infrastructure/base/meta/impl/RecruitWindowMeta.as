package net.wg.infrastructure.base.meta.impl
{
   import net.wg.infrastructure.base.AbstractWindowView;
   import net.wg.data.constants.Errors;
   
   public class RecruitWindowMeta extends AbstractWindowView
   {
      
      public function RecruitWindowMeta() {
         super();
      }
      
      public var updateVehicleClassDropdown:Function = null;
      
      public var updateVehicleTypeDropdown:Function = null;
      
      public var updateRoleDropdown:Function = null;
      
      public var updateNationDropdown:Function = null;
      
      public var buyTankman:Function = null;
      
      public var updateAllDropdowns:Function = null;
      
      public function updateVehicleClassDropdownS(param1:Number) : void {
         App.utils.asserter.assertNotNull(this.updateVehicleClassDropdown,"updateVehicleClassDropdown" + Errors.CANT_NULL);
         this.updateVehicleClassDropdown(param1);
      }
      
      public function updateVehicleTypeDropdownS(param1:Number, param2:String) : void {
         App.utils.asserter.assertNotNull(this.updateVehicleTypeDropdown,"updateVehicleTypeDropdown" + Errors.CANT_NULL);
         this.updateVehicleTypeDropdown(param1,param2);
      }
      
      public function updateRoleDropdownS(param1:Number, param2:String, param3:Number) : void {
         App.utils.asserter.assertNotNull(this.updateRoleDropdown,"updateRoleDropdown" + Errors.CANT_NULL);
         this.updateRoleDropdown(param1,param2,param3);
      }
      
      public function updateNationDropdownS() : void {
         App.utils.asserter.assertNotNull(this.updateNationDropdown,"updateNationDropdown" + Errors.CANT_NULL);
         this.updateNationDropdown();
      }
      
      public function buyTankmanS(param1:Number, param2:Number, param3:String, param4:Number, param5:Number) : void {
         App.utils.asserter.assertNotNull(this.buyTankman,"buyTankman" + Errors.CANT_NULL);
         this.buyTankman(param1,param2,param3,param4,param5);
      }
      
      public function updateAllDropdownsS(param1:Number, param2:String, param3:Number, param4:String) : void {
         App.utils.asserter.assertNotNull(this.updateAllDropdowns,"updateAllDropdowns" + Errors.CANT_NULL);
         this.updateAllDropdowns(param1,param2,param3,param4);
      }
   }
}
