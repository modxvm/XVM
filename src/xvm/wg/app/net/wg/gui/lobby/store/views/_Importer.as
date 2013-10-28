package net.wg.gui.lobby.store.views
{
   import net.wg.infrastructure.BaseImporter;


   public class _Importer extends BaseImporter
   {
          
      public function _Importer() {
         super();
         importClasses(Vector.<Class>([EquipmentView,ModuleView,OptionalDeviceView,ShellView,VehicleView]));
      }
   }

}