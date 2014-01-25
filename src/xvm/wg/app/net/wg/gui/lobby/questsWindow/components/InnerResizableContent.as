package net.wg.gui.lobby.questsWindow.components
{


   public class InnerResizableContent extends EventsResizableContent
   {
          
      public function InnerResizableContent() {
         super();
      }

      private static const HEADER_HEIGHT:int = 25;

      private static const AVAILABLE_WIDTH:int = 365;

      override protected function configUI() : void {
         super.configUI();
         header.height = HEADER_HEIGHT;
         resizableContainer.availableWidth = AVAILABLE_WIDTH;
      }
   }

}