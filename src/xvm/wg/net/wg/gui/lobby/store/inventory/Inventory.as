package net.wg.gui.lobby.store.inventory 
{
    import net.wg.data.constants.*;
    import net.wg.gui.lobby.store.*;
    import net.wg.infrastructure.base.meta.*;
    import net.wg.infrastructure.base.meta.impl.*;
    import net.wg.infrastructure.interfaces.*;
    
    public class Inventory extends net.wg.infrastructure.base.meta.impl.InventoryMeta implements net.wg.infrastructure.base.meta.IInventoryMeta
    {
        public function Inventory()
        {
            super();
            return;
        }

        protected override function onPopulate():void
        {
            super.onPopulate();
            storeTable.setModuleRendererLinkage(net.wg.data.constants.Linkages.INVENTORY_MODULE_ITEM_RENDERER);
            storeTable.setVehicleRendererLinkage(net.wg.data.constants.Linkages.INVENTORY_VEHICLE_ITEM_RENDERER);
            storeTable.addEventListener(net.wg.gui.lobby.store.StoreEvent.SELL, this.onSellItemHandler);
            return;
        }

        protected override function onDispose():void
        {
            super.onDispose();
            storeTable.removeEventListener(net.wg.gui.lobby.store.StoreEvent.SELL, this.onSellItemHandler);
            return;
        }

        protected override function onMenuChangeType():void
        {
            var loc1:*=null;
            if (!initializing) 
            {
                loc1 = getCurrentView();
                assertNotNull(loc1, "currentView");
                loc1.setSubFilterData((nationFilter.nation.selectedIndex - 1), subFilterData);
            }
            super.onMenuChangeType();
            return;
        }

        protected override function onMenuChange():void
        {
            if (!initializing) 
                updateTable();
            super.onMenuChange();
            return;
        }

        protected override function getLocalizator():Function
        {
            return MENU.inventory_menu;
        }

        protected override function onViewNeedUpdate(arg1:net.wg.infrastructure.interfaces.IStoreMenuView, arg2:String):void
        {
            super.onViewNeedUpdate(arg1, arg2);
            if (!initializing) 
                arg1.setSubFilterData(nation, subFilterData);
            arg1.update(getViewData(arg2));
            storeTable.updateHeaderCountTitle(MENU.shop_table_header_count(arg1.fittingType));
            return;
        }

        internal function onSellItemHandler(arg1:net.wg.gui.lobby.store.StoreEvent):void
        {
            sellItemS(arg1.data);
            arg1.stopImmediatePropagation();
            return;
        }
    }
}
