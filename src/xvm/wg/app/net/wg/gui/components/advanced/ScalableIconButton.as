package net.wg.gui.components.advanced
{
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.events.UILoaderEvent;
   import scaleform.clik.constants.InvalidationType;


   public class ScalableIconButton extends SoundButtonEx
   {
          
      public function ScalableIconButton() {
         super();
      }

      public static const ICON_LOADER_CONSTRAINT_NAME:String = "mcLoader";

      public var loader:UILoaderAlt;

      private var _iconSource:String;

      private var isIconSourceChanged:Boolean;

      private var inv:Boolean;

      override public function dispose() : void {
         this.loader.removeEventListener(UILoaderEvent.COMPLETE,this.iconLoadingCompleteHandler);
         this.loader.dispose();
         this.loader = null;
         super.dispose();
      }

      override protected function configUI() : void {
         super.configUI();
         this.loader.addEventListener(UILoaderEvent.COMPLETE,this.iconLoadingCompleteHandler);
      }

      private function iconLoadingCompleteHandler(param1:UILoaderEvent) : void {
         this.inv = true;
         invalidate();
         this.loader.x = (_width - this.loader.width) / 2;
         this.loader.y = (_height - this.loader.height) / 2;
      }

      override protected function draw() : void {
         if(this.isIconSourceChanged)
         {
            this.isIconSourceChanged = false;
            this.loader.source = this._iconSource;
            invalidate(InvalidationType.SIZE);
         }
         super.draw();
      }

      public function get iconSource() : String {
         return this._iconSource;
      }

      public function set iconSource(param1:String) : void {
         if(this._iconSource != param1)
         {
            this._iconSource = param1;
            this.isIconSourceChanged = true;
            invalidate();
         }
      }
   }

}