package net.wg.gui.lobby.tankman
{
   import scaleform.clik.core.UIComponent;
   import net.wg.gui.components.controls.UILoaderAlt;


   public class RankElement extends UIComponent
   {
          
      public function RankElement() {
         super();
      }

      public var icoLoader:UILoaderAlt;

      override protected function onDispose() : void {
         super.onDispose();
         this.icoLoader.dispose();
      }
   }

}