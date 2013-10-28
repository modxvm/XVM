package net.wg.gui.lobby.store.shop
{
   import net.wg.infrastructure.BaseImporter;


   public class _Importer extends BaseImporter
   {
          
      public function _Importer() {
         super();
         importClasses(Vector.<Class>([Shop,ShopModuleListItemRenderer,ShopVehicleListItemRenderer]));
      }
   }

}