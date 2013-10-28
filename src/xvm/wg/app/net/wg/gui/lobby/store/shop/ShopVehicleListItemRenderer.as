package net.wg.gui.lobby.store.shop
{
   import net.wg.gui.lobby.store.shop.base.ShopTableItemRenderer;
   import net.wg.gui.components.advanced.TankIcon;
   import net.wg.data.VO.StoreTableData;


   public class ShopVehicleListItemRenderer extends ShopTableItemRenderer
   {
          
      public function ShopVehicleListItemRenderer() {
         super();
      }

      public var vehicleIcon:TankIcon = null;

      override protected function update() : void {
         var _loc1_:StoreTableData = null;
         super.update();
         if(data)
         {
            _loc1_ = StoreTableData(data);
            this.updateVehicleIcon(_loc1_);
         }
      }

      private function updateVehicleIcon(param1:StoreTableData) : void {
         getHelper().initVehicleIcon(this.vehicleIcon,param1);
      }
   }

}