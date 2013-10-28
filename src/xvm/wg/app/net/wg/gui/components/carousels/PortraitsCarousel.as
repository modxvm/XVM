package net.wg.gui.components.carousels
{
   import flash.display.MovieClip;
   import scaleform.clik.controls.ButtonGroup;
   import scaleform.clik.interfaces.IListItemRenderer;
   import scaleform.clik.controls.Button;


   public class PortraitsCarousel extends CarouselBase
   {
          
      public function PortraitsCarousel() {
         super();
      }

      private static const CORRECTED_POSITION:uint = 2;

      public var carouselBG:MovieClip;

      private var buttonGroup:ButtonGroup;

      override protected function configUI() : void {
         super.configUI();
         this.buttonGroup = ButtonGroup.getGroup("portraitGroup",this);
      }

      override protected function draw() : void {
         super.draw();
      }

      override protected function initPosition() : void {
         super.initPosition();
         if(this.carouselBG)
         {
            this.carouselBG.x = renderersMask.x;
            this.carouselBG.y = renderersMask.y;
            this.carouselBG.width = renderersMask.width;
            this.carouselBG.height = renderersMask.height + 1;
         }
      }

      override protected function updateRenderPosition(param1:IListItemRenderer, param2:uint, param3:int, param4:Number) : void {
         super.updateRenderPosition(param1,param2,param3,param4);
         if(!this.buttonGroup.hasButton(Button(param1)))
         {
            this.buttonGroup.addButton(Button(param1));
         }
      }
   }

}