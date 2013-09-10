package net.wg.gui.lobby.profile.pages.statistics 
{
    public class LevelsStatisticChart extends net.wg.gui.lobby.profile.pages.statistics.StatisticsBarChart
    {
        public function LevelsStatisticChart()
        {
            super();
            return;
        }

        protected override function adjustProviderItem(arg1:net.wg.gui.lobby.profile.pages.statistics.StatisticChartInfo, arg2:int):void
        {
            super.adjustProviderItem(arg1, arg2);
            arg1.icon = "../maps/icons/levels/tank_level_" + arg1.xField + ".png";
            return;
        }
    }
}
