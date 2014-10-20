package net.wg.gui.lobby.store.shop
{
    import net.wg.gui.lobby.store.shop.base.ShopTableItemRenderer;
    import net.wg.gui.components.advanced.TankIcon;
    import net.wg.data.VO.StoreTableData;
    import net.wg.data.constants.Values;
    
    public class ShopVehicleListItemRenderer extends ShopTableItemRenderer
    {
        
        public function ShopVehicleListItemRenderer()
        {
            super();
        }
        
        public var vehicleIcon:TankIcon = null;
        
        public var rent:ShopRent = null;
        
        override protected function update() : void
        {
            var _loc1_:StoreTableData = null;
            super.update();
            if(data)
            {
                _loc1_ = StoreTableData(data);
                this.updateVehicleIcon(_loc1_);
                this.updateRent(_loc1_);
            }
        }
        
        private function updateRent(param1:StoreTableData) : void
        {
            if(!param1.rentLeft || param1.rentLeft == Values.EMPTY_STR)
            {
                this.rent.visible = false;
            }
            else
            {
                this.rent.updateText(param1.rentLeft);
                this.rent.y = descField.y + descField.textHeight ^ 0;
                this.rent.visible = true;
            }
        }
        
        private function updateVehicleIcon(param1:StoreTableData) : void
        {
            getHelper().initVehicleIcon(this.vehicleIcon,param1);
        }
    }
}
