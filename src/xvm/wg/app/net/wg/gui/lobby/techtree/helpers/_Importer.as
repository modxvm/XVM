package net.wg.gui.lobby.techtree.helpers
{
   import net.wg.infrastructure.BaseImporter;


   public class _Importer extends BaseImporter
   {
          
      public function _Importer() {
         super();
         importClasses(Vector.<Class>([Distance,LinesGraphics,NodeIndexFilter,NTGraphics,ResearchGraphics,TitleAppearance]));
      }
   }

}