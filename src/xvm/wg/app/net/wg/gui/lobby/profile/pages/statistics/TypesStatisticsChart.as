package net.wg.gui.lobby.profile.pages.statistics
{
    public class TypesStatisticsChart extends StatisticsBarChart
    {
        
        public function TypesStatisticsChart()
        {
            super();
        }
        
        override protected function adjustProviderItem(param1:StatisticChartInfo, param2:int) : void
        {
            param1.icon = "../maps/icons/filters/tanks/" + param1.xField + ".png";
        }
    }
}
