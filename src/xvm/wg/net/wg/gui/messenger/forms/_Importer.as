package net.wg.gui.messenger.forms 
{
    import __AS3__.vec.*;
    import net.wg.infrastructure.*;
    
    public class _Importer extends net.wg.infrastructure.BaseImporter
    {
        public function _Importer()
        {
            super();
            importClasses(Vector.<Class>([net.wg.gui.messenger.forms.ChannelsCreateForm, net.wg.gui.messenger.forms.ChannelsSearchForm, net.wg.gui.messenger.forms.ContactsListForm, net.wg.gui.messenger.forms.ContactsSearchForm]));
            return;
        }
    }
}
