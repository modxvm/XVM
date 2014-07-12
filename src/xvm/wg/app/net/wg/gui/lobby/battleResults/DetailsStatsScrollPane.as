package net.wg.gui.lobby.battleResults
{
   import net.wg.gui.components.controls.ResizableScrollPane;
   import net.wg.infrastructure.interfaces.IViewStackContent;
   import net.wg.gui.components.controls.ScrollBar;
   import flash.display.MovieClip;
   import flash.display.InteractiveObject;
   import flash.display.DisplayObject;
   
   public class DetailsStatsScrollPane extends ResizableScrollPane implements IViewStackContent
   {
      
      public function DetailsStatsScrollPane() {
         super();
      }
      
      public var detailsScrollBar:ScrollBar;
      
      public var topLip:MovieClip;
      
      public var bottomLip:MovieClip;
      
      override protected function configUI() : void {
         super.configUI();
         this.topLip.mouseEnabled = false;
         this.bottomLip.mouseEnabled = false;
         setSize(width,643);
         scrollStepFactor = 10;
         scrollBar = this.detailsScrollBar;
      }
      
      public function update(param1:Object) : void {
      }
      
      public function getComponentForFocus() : InteractiveObject {
         return null;
      }
      
      override protected function applyScrollBarUpdating() : void {
         super.applyScrollBarUpdating();
         if((_scrollBar) && ((_scrollBar as DisplayObject).visible))
         {
            this.topLip.visible = _scrollBar.position > 0;
            this.bottomLip.visible = _scrollBar.position < maxScroll;
         }
         else
         {
            this.topLip.visible = this.bottomLip.visible = false;
         }
      }
      
      override protected function applyTargetChanges() : void {
         super.applyTargetChanges();
         setChildIndex(this.topLip,numChildren - 1);
         setChildIndex(this.bottomLip,numChildren - 1);
      }
      
      public function canShowAutomatically() : Boolean {
         return true;
      }
   }
}
