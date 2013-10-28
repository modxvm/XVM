package net.wg.gui.components.controls.achievements
{
   import net.wg.infrastructure.BaseImporter;


   public class _Importer extends BaseImporter
   {
          
      public function _Importer() {
         super();
         importClasses(Vector.<Class>([AchievementCounter,CounterComponent,AchievementProgressComponent,AchievementProgressBar,SmallCounter,GreyRibbonCounter,YellowRibbonCounter,RedCounter,BeigeCounter,AchievementProgress,AchievementCommon,AchievementEvent,AchievementCommonVehicle,AchievementDivision,AchievementCounterSmall]));
      }
   }

}