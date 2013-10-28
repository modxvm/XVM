package net.wg.gui.lobby.tankman
{
   import scaleform.clik.core.UIComponent;
   import net.wg.infrastructure.interfaces.IViewStackContent;
   import net.wg.gui.components.carousels.AchievementCarousel;
   import flash.display.MovieClip;
   import scaleform.clik.data.DataProvider;
   import net.wg.gui.components.carousels.CarouselBase;


   public class PersonalCaseStats extends UIComponent implements IViewStackContent
   {
          
      public function PersonalCaseStats() {
         super();
      }

      public var blocksArea:PersonalCaseBlocksArea;

      public var achievements:AchievementCarousel;

      public var achivsBg:MovieClip;

      private var data:Object;

      override protected function configUI() : void {
         super.configUI();
         this.achievements.visible = false;
      }

      override public function dispose() : void {
         super.dispose();
         if(this.achievements)
         {
            this.achievements.dispose();
            this.achievements = null;
         }
         if(this.blocksArea)
         {
            this.blocksArea.dispose();
            this.blocksArea = null;
         }
      }

      public function update(param1:Object) : void {
         if(param1 == null)
         {
            return;
         }
         this.data = param1;
         if(param1.achievements.length > 0)
         {
            this.achievements.dataProvider = new DataProvider(this.data.achievements);
            this.achievements.invalidate(CarouselBase.INIT_CAROUSEL);
            this.achivsBg.visible = false;
         }
         this.blocksArea.setData(param1.stats);
      }
   }

}