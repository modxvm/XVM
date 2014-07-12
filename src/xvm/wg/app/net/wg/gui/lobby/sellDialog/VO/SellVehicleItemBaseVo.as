package net.wg.gui.lobby.sellDialog.VO
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class SellVehicleItemBaseVo extends DAAPIDataClass
   {
      
      public function SellVehicleItemBaseVo(param1:Object) {
         super(param1);
      }
      
      public var intCD:Number = -1;
      
      public var toInventory:Boolean = false;
      
      public var sellPrice:Array = null;
      
      public var count:Number = 1;
   }
}
