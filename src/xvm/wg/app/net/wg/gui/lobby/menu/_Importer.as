package net.wg.gui.lobby.menu
{
   import net.wg.infrastructure.BaseImporter;


   public class _Importer extends BaseImporter
   {
          
      public function _Importer() {
         super();
         importClasses(Vector.<Class>([LobbyMenuForm,LobbyMenu]));
      }
   }

}