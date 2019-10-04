package net.wg.gui.lobby.store.inventory
{
    import net.wg.infrastructure.base.meta.impl.InventoryMeta;
    import net.wg.infrastructure.base.meta.IInventoryMeta;
    import flash.display.InteractiveObject;
    import net.wg.gui.lobby.store.StoreEvent;
    import net.wg.data.constants.generated.STORE_CONSTANTS;
    import net.wg.data.constants.Linkages;

    public class Inventory extends InventoryMeta implements IInventoryMeta
    {

        public function Inventory()
        {
            super();
        }

        override public function getComponentForFocus() : InteractiveObject
        {
            return form;
        }

        override protected function initialize() : void
        {
            super.initialize();
            actionsFilterView.visible = false;
        }

        override protected function onPopulate() : void
        {
            super.onPopulate();
            storeTable.addEventListener(StoreEvent.SELL,this.onStoreTableSellHandler);
        }

        override protected function onDispose() : void
        {
            storeTable.removeEventListener(StoreEvent.SELL,this.onStoreTableSellHandler);
            super.onDispose();
        }

        override protected function getLocalizator() : Function
        {
            return MENU.inventory_menu;
        }

        override protected function getLinkageFromFittingType(param1:String) : String
        {
            if(param1 == STORE_CONSTANTS.VEHICLE)
            {
                return Linkages.INVENTORY_ACCORDION_VEHICLE_VIEW;
            }
            return super.getLinkageFromFittingType(param1);
        }

        override protected function get vehicleItemRendererLinkage() : String
        {
            return Linkages.INVENTORY_VEHICLE_ITEM_RENDERER;
        }

        override protected function get moduleItemRendererLinkage() : String
        {
            return Linkages.INVENTORY_MODULE_ITEM_RENDERER;
        }

        private function onStoreTableSellHandler(param1:StoreEvent) : void
        {
            sellItemS(param1.itemCD);
            param1.stopImmediatePropagation();
        }
    }
}
