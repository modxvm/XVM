package net.wg.gui.components.advanced
{
   import scaleform.clik.core.UIComponent;
   import net.wg.gui.components.controls.UILoaderAlt;
   
   public class ScalableIconWrapper extends UIComponent
   {
      
      public function ScalableIconWrapper() {
         super();
      }
      
      public var loader:UILoaderAlt;
      
      override protected function onDispose() : void {
         this.loader.dispose();
         this.loader = null;
         super.onDispose();
      }
   }
}
