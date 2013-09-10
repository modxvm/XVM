package net.wg.gui.lobby.store.inventory 
{
    import __AS3__.vec.*;
    import net.wg.infrastructure.*;
    
    public class _Importer extends net.wg.infrastructure.BaseImporter
    {
        public function _Importer()
        {
            super();
            importClasses(Vector.<Class>([net.wg.gui.lobby.store.inventory.Inventory, net.wg.gui.lobby.store.inventory.InventoryModuleListItemRenderer, net.wg.gui.lobby.store.inventory.InventoryVehicleListItemRdr]));
            return;
        }
    }
}
