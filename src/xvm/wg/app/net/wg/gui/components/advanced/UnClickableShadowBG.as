package net.wg.gui.components.advanced
{
   import scaleform.clik.core.UIComponent;
   import flash.display.MovieClip;


   public class UnClickableShadowBG extends UIComponent
   {
          
      public function UnClickableShadowBG() {
         super();
         this.shadow.mouseEnabled = false;
      }

      public var shadow:MovieClip;

      public var hit:MovieClip;
   }

}