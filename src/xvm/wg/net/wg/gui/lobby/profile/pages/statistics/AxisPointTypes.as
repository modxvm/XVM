package net.wg.gui.lobby.profile.pages.statistics 
{
    public class AxisPointTypes extends net.wg.gui.lobby.profile.pages.statistics.StatisticBarChartAxisPoint
    {
        public function AxisPointTypes()
        {
            super();
            tooltip = PROFILE.SECTION_STATISTICS_CHART_TYPE_TOOLTIP;
            return;
        }

        protected override function showToolTip():void
        {
            if (tooltip) 
                net.wg.gui.lobby.profile.pages.statistics.StatisticsChartsUtils.showTypeTooltip(_data, tooltip);
            return;
        }
    }
}
