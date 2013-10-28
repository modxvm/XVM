package net.wg.gui.messenger.forms
{
   import net.wg.infrastructure.BaseImporter;


   public class _Importer extends BaseImporter
   {
          
      public function _Importer() {
         super();
         importClasses(Vector.<Class>([ChannelsCreateForm,ChannelsSearchForm,ContactsListForm,ContactsSearchForm]));
      }
   }

}