package net.wg.gui.components.common.waiting
{
   import net.wg.infrastructure.BaseImporter;


   public class _Importer extends BaseImporter
   {
          
      public function _Importer() {
         super();
         importClasses(Vector.<Class>([WaitingView,WaitingMc,WaitingComponent,Waiting]));
      }
   }

}