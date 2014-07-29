package net.wg.gui.lobby.store.inventory
{
    import net.wg.gui.lobby.store.inventory.base.InventoryListItemRenderer;
    import net.wg.gui.components.advanced.TankIcon;
    import net.wg.data.VO.StoreTableData;
    
    public class InventoryVehicleListItemRdr extends InventoryListItemRenderer
    {
        
        public function InventoryVehicleListItemRdr()
        {
            super();
        }
        
        public var vehicleIcon:TankIcon = null;
        
        override protected function update() : void
        {
            var _loc1_:StoreTableData = null;
            super.update();
            if(data)
            {
                _loc1_ = StoreTableData(data);
                this.updateVehicleIcon(_loc1_);
            }
        }
        
        private function updateVehicleIcon(param1:StoreTableData) : void
        {
            getHelper().initVehicleIcon(this.vehicleIcon,param1);
        }
    }
}
