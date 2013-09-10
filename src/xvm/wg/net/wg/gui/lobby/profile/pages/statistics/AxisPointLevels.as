package net.wg.gui.lobby.profile.pages.statistics 
{
    public class AxisPointLevels extends net.wg.gui.lobby.profile.pages.statistics.StatisticBarChartAxisPoint
    {
        public function AxisPointLevels()
        {
            super();
            tooltip = PROFILE.SECTION_STATISTICS_CHART_LEVEL_TOOLTIP;
            return;
        }

        protected override function showToolTip():void
        {
            if (tooltip) 
                net.wg.gui.lobby.profile.pages.statistics.StatisticsChartsUtils.showLevelTooltip(_data, tooltip);
            return;
        }
    }
}
