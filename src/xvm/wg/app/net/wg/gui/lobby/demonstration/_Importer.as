package net.wg.gui.lobby.demonstration
{
   import net.wg.infrastructure.BaseImporter;
   import net.wg.gui.lobby.demonstration.data.DemonstratorVO;
   import net.wg.gui.lobby.demonstration.data.MapItemVO;


   public class _Importer extends BaseImporter
   {
          
      public function _Importer() {
         super();
         importClasses(Vector.<Class>([DemonstratorWindow,MapItemRenderer,DemonstratorVO,MapItemVO]));
      }
   }

}