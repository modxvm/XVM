package net.wg.gui.lobby.fortifications.cmp.impl
{
   import scaleform.clik.core.UIComponent;
   import net.wg.infrastructure.interfaces.entity.IFocusContainer;
   import flash.display.MovieClip;
   import scaleform.clik.constants.InvalidationType;
   import flash.display.InteractiveObject;


   public class FortWelcomeCommanderView extends UIComponent implements IFocusContainer
   {
          
      public function FortWelcomeCommanderView() {
         super();
      }

      public var background:MovieClip;

      public var content:FortWelcomeCommanderContent;

      override protected function draw() : void {
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            this.content.x = (_width - this.content.width) / 2;
            this.content.y = (_height - this.content.height) / 2;
            this.background.width = _width;
            this.background.height = _height;
         }
      }

      public function getComponentForFocus() : InteractiveObject {
         return this.content.button;
      }

      override protected function onDispose() : void {
         this.background = null;
         this.content.dispose();
         this.content = null;
         super.onDispose();
      }
   }

}