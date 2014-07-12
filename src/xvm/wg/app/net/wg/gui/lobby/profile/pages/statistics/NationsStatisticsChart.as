package net.wg.gui.lobby.profile.pages.statistics
{
   public class NationsStatisticsChart extends StatisticsBarChart
   {
      
      public function NationsStatisticsChart() {
         super();
      }
      
      override protected function adjustProviderItem(param1:StatisticChartInfo, param2:int) : void {
         super.adjustProviderItem(param1,param2);
         param1.icon = App.utils.nations.getNationIcon(int(param1.xField));
      }
   }
}
