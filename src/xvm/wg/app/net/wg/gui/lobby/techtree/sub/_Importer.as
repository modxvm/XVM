package net.wg.gui.lobby.techtree.sub
{
   import net.wg.infrastructure.BaseImporter;


   public class _Importer extends BaseImporter
   {
          
      public function _Importer() {
         super();
         importClasses(Vector.<Class>([NationTree,ResearchItems]));
      }
   }

}