package net.wg.gui.lobby.store.inventory
{
   import net.wg.infrastructure.BaseImporter;


   public class _Importer extends BaseImporter
   {
          
      public function _Importer() {
         super();
         importClasses(Vector.<Class>([Inventory,InventoryModuleListItemRenderer,InventoryVehicleListItemRdr]));
      }
   }

}