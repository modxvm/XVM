package net.wg.gui.lobby.profile.pages.statistics 
{
    public class NationsStatisticsChart extends net.wg.gui.lobby.profile.pages.statistics.StatisticsBarChart
    {
        public function NationsStatisticsChart()
        {
            super();
            return;
        }

        protected override function adjustProviderItem(arg1:net.wg.gui.lobby.profile.pages.statistics.StatisticChartInfo, arg2:int):void
        {
            super.adjustProviderItem(arg1, arg2);
            arg1.icon = App.utils.nations.getNationIcon(int(arg1.xField));
            return;
        }
    }
}
