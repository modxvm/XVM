package net.wg.gui.lobby.profile.headerBar
{
   import net.wg.infrastructure.BaseImporter;


   public class _Importer extends BaseImporter
   {
          
      public function _Importer() {
         super();
         importClasses(Vector.<Class>([ProfileHeaderButtonBar,ProfileTabButton,ProfileTabButtonBg]));
      }
   }

}