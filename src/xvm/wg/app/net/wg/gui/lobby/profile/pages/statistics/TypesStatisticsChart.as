package net.wg.gui.lobby.profile.pages.statistics 
{
    public class TypesStatisticsChart extends net.wg.gui.lobby.profile.pages.statistics.StatisticsBarChart
    {
        public function TypesStatisticsChart()
        {
            super();
            return;
        }

        protected override function adjustProviderItem(arg1:net.wg.gui.lobby.profile.pages.statistics.StatisticChartInfo, arg2:int):void
        {
            arg1.icon = "../maps/icons/filters/tanks/" + arg1.xField + ".png";
            return;
        }
    }
}
