package net.wg.gui.lobby.profile.pages.statistics
{
   public class LevelsStatisticChart extends StatisticsBarChart
   {
      
      public function LevelsStatisticChart() {
         super();
      }
      
      override protected function adjustProviderItem(param1:StatisticChartInfo, param2:int) : void {
         super.adjustProviderItem(param1,param2);
         param1.icon = "../maps/icons/levels/tank_level_" + param1.xField + ".png";
      }
   }
}
