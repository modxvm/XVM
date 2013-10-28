package net.wg.gui.lobby.messengerBar
{
   import net.wg.infrastructure.BaseImporter;
   import net.wg.gui.lobby.messengerBar.carousel.ChannelCarousel;
   import net.wg.gui.lobby.messengerBar.carousel.ChannelRenderer;
   import net.wg.gui.lobby.messengerBar.carousel.ChannelButton;


   public class _Importer extends BaseImporter
   {
          
      public function _Importer() {
         super();
         importClasses(Vector.<Class>([MessengerBar,NotificationListButton,NotificationInvitesButton,ChannelCarousel,ChannelRenderer,ChannelButton,WindowOffsetsInBar]));
      }
   }

}