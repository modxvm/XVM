package net.wg.gui.lobby.dialogs
{
   import net.wg.infrastructure.base.meta.impl.IconDialogMeta;
   import net.wg.infrastructure.base.meta.IIconDialogMeta;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.events.UILoaderEvent;
   import flash.events.Event;


   public class IconDialog extends IconDialogMeta implements IIconDialogMeta
   {
          
      public function IconDialog() {
         super();
      }

      public var icon:UILoaderAlt;

      public function as_setIcon(param1:String) : void {
         this.icon.addEventListener(UILoaderEvent.COMPLETE,this.loadingCompleteHandler,false,0,true);
         this.icon.source = param1;
      }

      private function loadingCompleteHandler(param1:Event) : void {
         invalidateLayout();
      }

      override protected function getBackgroundActualHeight() : Number {
         var _loc1_:Number = this.icon?this.icon.y + this.icon.height:0;
         return Math.max(_loc1_,super.getBackgroundActualHeight());
      }

      override protected function onDispose() : void {
         if(this.icon)
         {
            this.icon.removeEventListener(UILoaderEvent.COMPLETE,this.loadingCompleteHandler);
            this.icon.dispose();
            if(this.icon.parent)
            {
               this.icon.parent.removeChild(this.icon);
            }
            this.icon = null;
         }
         super.onDispose();
      }
   }

}