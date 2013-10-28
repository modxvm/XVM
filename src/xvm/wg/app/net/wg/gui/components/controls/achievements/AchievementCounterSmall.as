package net.wg.gui.components.controls.achievements
{


   public class AchievementCounterSmall extends AchievementCounter
   {
          
      public function AchievementCounterSmall() {
         super();
      }

      override protected function applyData() : void {
         super.applyData();
         if((data) && (data.hasOwnProperty("value")) && data.value == 0)
         {
            counterType = AchievementCounter.NONE;
         }
         else
         {
            counterType = AchievementCounter.SMALL;
         }
      }

      override protected function applyLayoutChanges() : void {
         if((counter) && (!(loader.width == 0)) && !(loader.height == 0))
         {
            counter.x = _originalWidth - counter.actualWidth ^ 0;
            counter.y = _originalHeight - counter.actualHeight - counter.receiveBottomPadding() ^ 0;
            addChild(counter);
         }
      }
   }

}