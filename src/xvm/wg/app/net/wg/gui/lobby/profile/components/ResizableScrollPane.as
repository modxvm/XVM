package net.wg.gui.lobby.profile.components
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

      override public function dispose() : void {
         if(target)
         {
            target.removeEventListener(Event.RESIZE,this.resizeHandler);
         }
         super.dispose();
      }
   }

}