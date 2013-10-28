package net.wg.gui.lobby.techtree.data
{
   import net.wg.infrastructure.BaseImporter;


   public class _Importer extends BaseImporter
   {
          
      public function _Importer() {
         super();
         importClasses(Vector.<Class>([AbstractDataProvider,NationVODataProvider,NationXMLDataProvider,ResearchVODataProvider,ResearchXMLDataProvider]));
      }
   }

}