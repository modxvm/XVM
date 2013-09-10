package net.wg.gui.lobby.profile.pages.statistics 
{
    public class AxisPointNations extends net.wg.gui.lobby.profile.pages.statistics.StatisticBarChartAxisPoint
    {
        public function AxisPointNations()
        {
            super();
            tooltip = PROFILE.SECTION_STATISTICS_CHART_NATION_TOOLTIP;
            return;
        }

        protected override function showToolTip():void
        {
            if (tooltip) 
                net.wg.gui.lobby.profile.pages.statistics.StatisticsChartsUtils.showNationTooltip(_data, tooltip);
            return;
        }
    }
}
