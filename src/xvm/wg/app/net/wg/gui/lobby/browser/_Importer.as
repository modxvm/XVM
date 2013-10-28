package net.wg.gui.lobby.browser
{
   import net.wg.infrastructure.BaseImporter;


   public class _Importer extends BaseImporter
   {
          
      public function _Importer() {
         super();
         importClasses(Vector.<Class>([BrowserActionBtn,BrowserEvent,BrowserHitArea,BrowserWindow]));
      }
   }

}