package net.wg.gui.messenger.windows
{
   import net.wg.infrastructure.BaseImporter;


   public class _Importer extends BaseImporter
   {
          
      public function _Importer() {
         super();
         importClasses(Vector.<Class>([ChannelsManagementWindow,ContactsWindow,ConnectToSecureChannelWindow,FAQWindow,LazyChannelWindow,LobbyChannelWindow]));
      }
   }

}