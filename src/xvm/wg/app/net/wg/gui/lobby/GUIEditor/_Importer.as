package net.wg.gui.lobby.GUIEditor
{
   import net.wg.infrastructure.BaseImporter;


   public class _Importer extends BaseImporter
   {
          
      public function _Importer() {
         super();
         importClasses(Vector.<Class>([GEInspectWindow,EditablePropertyListItemRenderer,ChangePropertyEvent]));
      }
   }

}