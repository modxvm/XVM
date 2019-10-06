package net.wg.gui.lobby.store.inventory
{
    import net.wg.gui.lobby.store.inventory.base.InventoryListItemRenderer;
    import net.wg.gui.components.advanced.TankIcon;
    import scaleform.clik.utils.Constraints;
    import net.wg.data.VO.StoreTableData;
    import net.wg.data.constants.generated.CONTEXT_MENU_HANDLER_TYPE;

    public class InventoryVehicleListItemRdr extends InventoryListItemRenderer
    {

        public var vehicleIcon:TankIcon = null;

        public function InventoryVehicleListItemRdr()
        {
            super();
        }

        override protected function configUI() : void
        {
            super.configUI();
            mouseChildren = true;
            constraints.addElement("vehicleIcon",this.vehicleIcon,Constraints.ALL);
        }

        override protected function onDispose() : void
        {
            this.vehicleIcon.dispose();
            this.vehicleIcon = null;
            super.onDispose();
        }

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

        override protected function getVehicleIconWidth() : int
        {
            return this.vehicleIcon.width;
        }

        override protected function onRightButtonClick() : void
        {
            if(compareModeOn)
            {
                App.contextMenuMgr.show(CONTEXT_MENU_HANDLER_TYPE.STORE_VEHICLE,this,{"id":StoreTableData(data).id});
            }
            else
            {
                infoItem();
            }
        }

        private function updateVehicleIcon(param1:StoreTableData) : void
        {
            getHelper().initVehicleIcon(this.vehicleIcon,param1);
        }
    }
}
