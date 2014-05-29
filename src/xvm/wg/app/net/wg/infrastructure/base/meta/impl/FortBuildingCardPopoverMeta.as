package net.wg.infrastructure.base.meta.impl
{
   import net.wg.infrastructure.base.SmartPopOverView;
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.fortifications.data.BuildingCardPopoverVO;
   import net.wg.infrastructure.exceptions.AbstractException;


   public class FortBuildingCardPopoverMeta extends SmartPopOverView
   {
          
      public function FortBuildingCardPopoverMeta() {
         super();
      }

      public var openUpgradeWindow:Function = null;

      public var openAssignedPlayersWindow:Function = null;

      public var openDemountBuildingWindow:Function = null;

      public var openDirectionControlWindow:Function = null;

      public var openBuyOrderWindow:Function = null;

      public function openUpgradeWindowS(param1:Object) : void {
         App.utils.asserter.assertNotNull(this.openUpgradeWindow,"openUpgradeWindow" + Errors.CANT_NULL);
         this.openUpgradeWindow(param1);
      }

      public function openAssignedPlayersWindowS(param1:Object) : void {
         App.utils.asserter.assertNotNull(this.openAssignedPlayersWindow,"openAssignedPlayersWindow" + Errors.CANT_NULL);
         this.openAssignedPlayersWindow(param1);
      }

      public function openDemountBuildingWindowS(param1:String) : void {
         App.utils.asserter.assertNotNull(this.openDemountBuildingWindow,"openDemountBuildingWindow" + Errors.CANT_NULL);
         this.openDemountBuildingWindow(param1);
      }

      public function openDirectionControlWindowS() : void {
         App.utils.asserter.assertNotNull(this.openDirectionControlWindow,"openDirectionControlWindow" + Errors.CANT_NULL);
         this.openDirectionControlWindow();
      }

      public function openBuyOrderWindowS() : void {
         App.utils.asserter.assertNotNull(this.openBuyOrderWindow,"openBuyOrderWindow" + Errors.CANT_NULL);
         this.openBuyOrderWindow();
      }

      public function as_setData(param1:Object) : void {
         var _loc2_:BuildingCardPopoverVO = new BuildingCardPopoverVO(param1);
         this.setData(_loc2_);
      }

      protected function setData(param1:BuildingCardPopoverVO) : void {
         var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }

}