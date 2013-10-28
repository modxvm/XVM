package net.wg.gui.login.impl
{
   import net.wg.infrastructure.BaseImporter;


   public class _Importer extends BaseImporter
   {
          
      public function _Importer() {
         super();
         importClasses(Vector.<Class>([LoginEvent,LoginForm,LoginPage,LoginQueueWindow,Spark,SparksManager,LoginCreateAnAccountWindow]));
      }
   }

}