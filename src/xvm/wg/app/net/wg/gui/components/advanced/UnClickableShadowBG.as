package net.wg.gui.components.advanced
{
   import scaleform.clik.core.UIComponent;
   import flash.display.MovieClip;
   
   public class UnClickableShadowBG extends UIComponent
   {
      
      public function UnClickableShadowBG() {
         super();
         this.shadow.buttonMode = true;
         this.shadow.hitArea = this.hit;
      }
      
      public var shadow:MovieClip;
      
      public var hit:MovieClip;
   }
}
