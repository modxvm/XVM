package net.wg.gui.lobby.settings.components
{
   import net.wg.gui.lobby.profile.components.ResizableScrollPane;
   import flash.display.MovieClip;


   public class SettingsScrollPane extends ResizableScrollPane
   {
          
      public function SettingsScrollPane() {
         super();
      }

      private static const SCROLLBAR_MARGIN:int = 10;

      public var topShadow:MovieClip;

      public var bottomShadow:MovieClip;

      override protected function configUI() : void {
         super.configUI();
         this.topShadow.mouseChildren = this.topShadow.mouseEnabled = false;
         this.bottomShadow.mouseChildren = this.bottomShadow.mouseEnabled = false;
      }

      override protected function onDispose() : void {
         this.topShadow = null;
         this.bottomShadow = null;
         super.onDispose();
      }

      override protected function applyTargetChanges() : void {
         super.applyTargetChanges();
         if(target)
         {
            if(getChildIndex(target) > getChildIndex(this.topShadow))
            {
               swapChildren(target,this.topShadow);
            }
            if(getChildIndex(target) > getChildIndex(this.bottomShadow))
            {
               swapChildren(target,this.bottomShadow);
            }
         }
      }

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