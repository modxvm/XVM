package net.wg.gui.lobby.store
{
   import net.wg.infrastructure.BaseImporter;


   public class _Importer extends BaseImporter
   {
          
      public function _Importer() {
         super();
         importClasses(Vector.<Class>([ComplexListItemRenderer,ModuleRendererCredits,NationFilter,Store,StoreListItemRenderer,StoreTable,TableHeader,TableHeaderInfo]));
      }
   }

}