package net.wg.infrastructure.base.meta.impl
{
   import net.wg.infrastructure.base.BaseDAAPIComponent;
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.fortifications.data.BuildingsComponentVO;
   import net.wg.infrastructure.exceptions.AbstractException;
   import net.wg.gui.lobby.fortifications.data.BuildingVO;


   public class FortBuildingComponentMeta extends BaseDAAPIComponent
   {
          
      public function FortBuildingComponentMeta() {
         super();
      }

      public var onTransportingRequest:Function = null;

      public var requestBuildingProcess:Function = null;

      public var upgradeVisitedBuilding:Function = null;

      public var getBuildingTooltipData:Function = null;

      public function onTransportingRequestS(param1:String, param2:String) : void {
         App.utils.asserter.assertNotNull(this.onTransportingRequest,"onTransportingRequest" + Errors.CANT_NULL);
         this.onTransportingRequest(param1,param2);
      }

      public function requestBuildingProcessS(param1:int, param2:int) : void {
         App.utils.asserter.assertNotNull(this.requestBuildingProcess,"requestBuildingProcess" + Errors.CANT_NULL);
         this.requestBuildingProcess(param1,param2);
      }

      public function upgradeVisitedBuildingS(param1:String) : void {
         App.utils.asserter.assertNotNull(this.upgradeVisitedBuilding,"upgradeVisitedBuilding" + Errors.CANT_NULL);
         this.upgradeVisitedBuilding(param1);
      }

      public function getBuildingTooltipDataS(param1:String) : Array {
         App.utils.asserter.assertNotNull(this.getBuildingTooltipData,"getBuildingTooltipData" + Errors.CANT_NULL);
         return this.getBuildingTooltipData(param1);
      }

      public function as_setData(param1:Object) : void {
         var _loc2_:BuildingsComponentVO = new BuildingsComponentVO(param1);
         this.setData(_loc2_);
      }

      protected function setData(param1:BuildingsComponentVO) : void {
         var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }

      public function as_setBuildingData(param1:Object) : void {
         var _loc2_:BuildingVO = new BuildingVO(param1);
         this.setBuildingData(_loc2_);
      }

      protected function setBuildingData(param1:BuildingVO) : void {
         var _loc2_:String = "as_setBuildingData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }

}