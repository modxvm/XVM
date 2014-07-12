package net.wg.gui.components.controls
{
   import flash.events.Event;
   
   public class ResizableScrollPane extends ScrollPane
   {
      
      public function ResizableScrollPane() {
         super();
      }
      
      override protected function applyTargetChanges() : void {
         if(target)
         {
            target.removeEventListener(Event.RESIZE,this.resizeHandler);
         }
         target.addEventListener(Event.RESIZE,this.resizeHandler,false,0,true);
         super.applyTargetChanges();
      }
      
      private function resizeHandler(param1:Event) : void {
         _scrollPosition = Math.max(0,Math.min(maxScroll,Math.round(_scrollPosition)));
         invalidateSize();
      }
      
      override protected function onDispose() : void {
         if(target)
         {
            target.removeEventListener(Event.RESIZE,this.resizeHandler);
         }
         super.onDispose();
      }
   }
}
