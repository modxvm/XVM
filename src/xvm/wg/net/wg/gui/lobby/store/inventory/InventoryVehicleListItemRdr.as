package net.wg.gui.lobby.store.inventory 
{
    import net.wg.data.VO.*;
    import net.wg.gui.components.advanced.*;
    import net.wg.gui.lobby.store.inventory.base.*;
    
    public class InventoryVehicleListItemRdr extends net.wg.gui.lobby.store.inventory.base.InventoryListItemRenderer
    {
        public function InventoryVehicleListItemRdr()
        {
            super();
            return;
        }

        protected override function update():void
        {
            var loc1:*=null;
            super.update();
            if (data) 
            {
                loc1 = net.wg.data.VO.StoreTableData(data);
                this.updateVehicleIcon(loc1);
            }
            return;
        }

        internal function updateVehicleIcon(arg1:net.wg.data.VO.StoreTableData):void
        {
            getHelper().initVehicleIcon(this.vehicleIcon, arg1);
            return;
        }

        public var vehicleIcon:net.wg.gui.components.advanced.TankIcon=null;
    }
}
