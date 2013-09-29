package net.wg.gui.messenger.windows 
{
    import __AS3__.vec.*;
    import net.wg.infrastructure.*;
    
    public class _Importer extends net.wg.infrastructure.BaseImporter
    {
        public function _Importer()
        {
            super();
            importClasses(Vector.<Class>([net.wg.gui.messenger.windows.ChannelsManagementWindow, net.wg.gui.messenger.windows.ContactsWindow, net.wg.gui.messenger.windows.ConnectToSecureChannelWindow, net.wg.gui.messenger.windows.FAQWindow, net.wg.gui.messenger.windows.LazyChannelWindow, net.wg.gui.messenger.windows.LobbyChannelWindow]));
            return;
        }
    }
}
