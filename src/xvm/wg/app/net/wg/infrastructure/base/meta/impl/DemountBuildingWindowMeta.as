package net.wg.infrastructure.base.meta.impl
{
   import net.wg.infrastructure.base.AbstractWindowView;
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.fortifications.data.demountBuilding.DemountBuildingVO;
   import net.wg.infrastructure.exceptions.AbstractException;


   public class DemountBuildingWindowMeta extends AbstractWindowView
   {
          
      public function DemountBuildingWindowMeta() {
         super();
      }

      public var applyDemount:Function = null;

      public function applyDemountS() : void {
         App.utils.asserter.assertNotNull(this.applyDemount,"applyDemount" + Errors.CANT_NULL);
         this.applyDemount();
      }

      public function as_setData(param1:Object) : void {
         var _loc2_:DemountBuildingVO = new DemountBuildingVO(param1);
         this.setData(_loc2_);
      }

      protected function setData(param1:DemountBuildingVO) : void {
         var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }

}