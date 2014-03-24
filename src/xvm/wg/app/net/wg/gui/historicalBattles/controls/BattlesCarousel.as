package net.wg.gui.historicalBattles.controls
{
   import net.wg.gui.components.carousels.CarouselBase;
   import flash.display.MovieClip;
   import scaleform.clik.controls.ButtonGroup;
   import scaleform.clik.interfaces.IDataProvider;
   import scaleform.clik.interfaces.IListItemRenderer;
   import scaleform.clik.controls.Button;


   public class BattlesCarousel extends CarouselBase
   {
          
      public function BattlesCarousel() {
         super();
      }

      public var carouselBG:MovieClip;

      private var buttonGroup:ButtonGroup;

      override protected function configUI() : void {
         super.configUI();
         this.buttonGroup = ButtonGroup.getGroup("renderersGroup",this);
      }

      override protected function initPosition() : void {
         super.initPosition();
         if(this.carouselBG)
         {
            this.carouselBG.x = renderersMask.x;
            this.carouselBG.y = leftArrow.y;
            this.carouselBG.width = renderersMask.width;
            this.carouselBG.height = leftArrow.height;
         }
      }

      override public function set dataProvider(param1:IDataProvider) : void {
         super.dataProvider = param1;
         invalidate(INIT_CAROUSEL);
      }

      override protected function updateContainerPosition() : void {
         super.updateContainerPosition();
         this.carouselBG.visible = leftArrow.visible;
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