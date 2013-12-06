package net.wg.gui.lobby.questsWindow
{
   import net.wg.gui.lobby.profile.components.ResizableScrollPane;


   public class QuestScrollPane extends ResizableScrollPane
   {
          
      public function QuestScrollPane() {
         super();
      }

      private static const SCROLLBAR_MARGIN:int = 10;

      override protected function drawScrollBar() : void {
         if(!_autoScrollBar)
         {
            return;
         }
         _scrollBar.x = _width - _scrollBar.width - SCROLLBAR_MARGIN;
         _scrollBar.y = SCROLLBAR_MARGIN;
         _scrollBar.height = availableHeight - SCROLLBAR_MARGIN * 2;
         _scrollBar.validateNow();
      }
   }

}