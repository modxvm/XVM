package net.wg.gui.lobby.fortifications.popovers.impl
{
   import flash.display.MovieClip;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.gui.lobby.fortifications.cmp.build.impl.OrderInfoCmp;
   import flash.text.TextField;
   import net.wg.gui.lobby.fortifications.data.OrderInfoVO;
   import net.wg.gui.lobby.fortifications.data.FortBuildingConstants;


   public class FortPopoverBody extends MovieClip implements IDisposable
   {
          
      public function FortPopoverBody() {
         super();
      }

      private static const DEFRES_INFO_STATE:String = "defresInfoState";

      private static const BASE_BUILDING_STATE:String = "baseBuildingState";

      public var orderInfo:OrderInfoCmp;

      public var title:TextField;

      public var description:TextField;

      private var model:OrderInfoVO;

      public function dispose() : void {
         this.orderInfo.dispose();
         this.orderInfo = null;
         this.model.dispose();
         this.model = null;
      }

      public function setData(param1:OrderInfoVO) : void {
         this.model = param1;
         if(this.model.buildingType == FortBuildingConstants.BASE_BUILDING)
         {
            gotoAndStop(BASE_BUILDING_STATE);
            this.title.htmlText = this.model.title;
            this.description.htmlText = this.model.description;
         }
         else
         {
            gotoAndStop(DEFRES_INFO_STATE);
            this.orderInfo.setData(this.model);
         }
         this.updateState(this.model.buildingType == FortBuildingConstants.BASE_BUILDING);
      }

      private function updateState(param1:Boolean) : void {
         this.title.visible = param1;
         this.description.visible = param1;
      }
   }

}