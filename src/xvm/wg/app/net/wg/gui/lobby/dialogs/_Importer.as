package net.wg.gui.lobby.dialogs
{
   import net.wg.infrastructure.BaseImporter;


   public class _Importer extends BaseImporter
   {
          
      public function _Importer() {
         super();
         importClasses(Vector.<Class>([SimpleDialog,IconDialog,IconDialog,IconPriceDialog,DemountDeviceDialog,DestroyDeviceDialog,PriceMc,DismissTankmanDialog,FreeXPInfoWindow]));
      }
   }

}