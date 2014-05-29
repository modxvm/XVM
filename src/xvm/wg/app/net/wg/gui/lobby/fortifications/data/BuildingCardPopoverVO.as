package net.wg.gui.lobby.fortifications.data
{


   public class BuildingCardPopoverVO extends BuildingPopoverBaseVO
   {
          
      public function BuildingCardPopoverVO(param1:Object) {
         super(param1);
         if((this.buildingHeader) && (this.buildingsIndicators) && (this.defResInfo))
         {
            this.buildingHeader.isCommander = isCommander;
            this.buildingHeader.buildingType = buildingType;
            this.buildingsIndicators.isCommander = isCommander;
            this.buildingsIndicators.buildingType = buildingType;
            this.defResInfo.isCommander = isCommander;
            this.defResInfo.buildingType = buildingType;
            this.actionData.isCommander = isCommander;
            this.actionData.buildingType = buildingType;
         }
      }

      protected static const BUILDING_HEADER:String = "buildingHeader";

      protected static const BUILDING_INDICATORS:String = "buildingIndicators";

      protected static const DEFRES_INFO:String = "defresInfo";

      protected static const ACTION_DATA:String = "actionData";

      public var isTutorial:Boolean = false;

      public var buildingHeader:BuildingPopoverHeaderVO;

      public var buildingsIndicators:BuildingIndicatorsVO;

      public var defResInfo:OrderInfoVO;

      public var actionData:BuildingPopoverActionVO;

      public var assignLbl:String = "";

      public var playerCount:int = -1;

      override protected function onDataWrite(param1:String, param2:Object) : Boolean {
         if(param1 == BUILDING_INDICATORS)
         {
            this.buildingsIndicators = new BuildingIndicatorsVO(param2);
            return false;
         }
         if(param1 == BUILDING_HEADER)
         {
            this.buildingHeader = new BuildingPopoverHeaderVO(param2);
            return false;
         }
         if(param1 == DEFRES_INFO)
         {
            this.defResInfo = new OrderInfoVO(param2);
            return false;
         }
         if(param1 == ACTION_DATA)
         {
            this.actionData = new BuildingPopoverActionVO(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
   }

}