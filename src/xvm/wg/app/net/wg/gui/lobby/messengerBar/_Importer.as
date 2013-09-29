package net.wg.gui.lobby.messengerBar 
{
    import __AS3__.vec.*;
    import net.wg.gui.lobby.messengerBar.carousel.*;
    import net.wg.infrastructure.*;
    
    public class _Importer extends net.wg.infrastructure.BaseImporter
    {
        public function _Importer()
        {
            super();
            importClasses(Vector.<Class>([net.wg.gui.lobby.messengerBar.MessengerBar, net.wg.gui.lobby.messengerBar.NotificationListButton, net.wg.gui.lobby.messengerBar.NotificationInvitesButton, net.wg.gui.lobby.messengerBar.carousel.ChannelCarousel, net.wg.gui.lobby.messengerBar.carousel.ChannelRenderer, net.wg.gui.lobby.messengerBar.carousel.ChannelButton, net.wg.gui.lobby.messengerBar.WindowOffsetsInBar]));
            return;
        }
    }
}
