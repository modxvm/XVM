package net.wg.gui.lobby.fortifications.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class FortChoiceDivisionSelectorVO extends DAAPIDataClass
   {
      
      public function FortChoiceDivisionSelectorVO(param1:Object) {
         super(param1);
      }
      
      public var divisionID:int = -1;
      
      public var divisionName:String = "";
      
      public var divisionProfit:String = "";
      
      public var vehicleLevel:String = "";
      
      public var playerRange:String = "";
   }
}
