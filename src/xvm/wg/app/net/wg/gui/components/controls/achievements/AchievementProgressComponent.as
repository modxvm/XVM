package net.wg.gui.components.controls.achievements
{
   import scaleform.clik.core.UIComponent;
   import flash.text.TextField;


   public class AchievementProgressComponent extends UIComponent
   {
          
      public function AchievementProgressComponent() {
         super();
      }

      public var progressBar:AchievementProgressBar;

      public var progressTextField:TextField;

      override protected function configUI() : void {
         super.configUI();
         this.progressBar.setActualSize(_originalWidth,this.progressBar.height);
      }
   }

}