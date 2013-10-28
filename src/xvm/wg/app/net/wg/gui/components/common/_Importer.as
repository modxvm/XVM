package net.wg.gui.components.common
{
   import net.wg.infrastructure.BaseImporter;


   public class _Importer extends BaseImporter
   {
          
      public function _Importer() {
         super();
         importClasses(Vector.<Class>([CursorManagedContainer,ManagedContainer,MainViewContainer]));
      }
   }

}