package net.wg.gui.lobby.fortifications.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class BuildingModernizationVO extends DAAPIDataClass
   {
      
      public function BuildingModernizationVO(param1:Object) {
         super(param1);
      }
      
      public static const BEFORE_UPGRADE:String = "beforeUpgradeData";
      
      public static const AFTER_UPGRADE:String = "afterUpgradeData";
      
      public var intBuildingID:int = -1;
      
      public var btnToolTip:Object = null;
      
      public var canUpgrade:Boolean = true;
      
      public var condition:String = "";
      
      public var costUpgrade:String = "";
      
      public var costValue:String = "";
      
      public var beforeUpgradeData:ModernizationCmpVO = null;
      
      public var afterUpgradeData:ModernizationCmpVO = null;
      
      public var conditionIcon:String = "";
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean {
         if(param1 == BEFORE_UPGRADE)
         {
            this.beforeUpgradeData = new ModernizationCmpVO(param2);
            return false;
         }
         if(param1 == AFTER_UPGRADE)
         {
            this.afterUpgradeData = new ModernizationCmpVO(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
   }
}
