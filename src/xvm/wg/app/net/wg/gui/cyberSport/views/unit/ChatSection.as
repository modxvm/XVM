package net.wg.gui.cyberSport.views.unit
{
   import net.wg.gui.rally.views.room.BaseChatSection;
   import net.wg.infrastructure.interfaces.entity.IFocusContainer;


   public class ChatSection extends BaseChatSection implements IFocusContainer
   {
          
      public function ChatSection() {
         super();
      }

      override protected function getHeader() : String {
         return CYBERSPORT.WINDOW_UNIT_CHAT;
      }
   }

}