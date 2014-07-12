package net.wg.gui.lobby.fortifications.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class ModernizationCmpVO extends DAAPIDataClass
   {
      
      public function ModernizationCmpVO(param1:Object) {
         super(param1);
      }
      
      private static const BUILDING_INDICATORS:String = "buildingIndicators";
      
      private static const DEFRES_INFO:String = "defResInfo";
      
      public var buildingLevel:int = -1;
      
      public var buildingType:String = "";
      
      public var buildingIndicators:BuildingIndicatorsVO = null;
      
      public var defResInfo:OrderInfoVO = null;
      
      public var titleText:String = "";
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean {
         if(param1 == BUILDING_INDICATORS)
         {
            if(param2 is BuildingIndicatorsVO)
            {
               this.buildingIndicators = BuildingIndicatorsVO(param2);
            }
            else
            {
               this.buildingIndicators = new BuildingIndicatorsVO(param2);
            }
            return false;
         }
         if(param1 == DEFRES_INFO)
         {
            if(param2 is OrderInfoVO)
            {
               this.defResInfo = OrderInfoVO(param2);
            }
            else
            {
               this.defResInfo = new OrderInfoVO(param2);
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
   }
}
