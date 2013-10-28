package net.wg.gui.login.EULA
{
   import net.wg.infrastructure.BaseImporter;


   public class _Importer extends BaseImporter
   {
          
      public function _Importer() {
         super();
         importClasses(Vector.<Class>([EULADlg,EULAFullDlg]),true);
      }
   }

}