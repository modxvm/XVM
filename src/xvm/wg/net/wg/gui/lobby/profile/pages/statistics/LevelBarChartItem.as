package net.wg.gui.lobby.profile.pages.statistics 
{
    import net.wg.data.managers.*;
    
    public class LevelBarChartItem extends net.wg.gui.lobby.profile.pages.statistics.StatisticBarChartItem
    {
        public function LevelBarChartItem()
        {
            super();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            tooltip = PROFILE.SECTION_STATISTICS_CHART_LEVEL_TOOLTIP;
            return;
        }

        protected override function showToolTip(arg1:net.wg.data.managers.IToolTipParams):void
        {
            if (tooltip) 
                net.wg.gui.lobby.profile.pages.statistics.StatisticsChartsUtils.showLevelTooltip(_data, tooltip);
            return;
        }
    }
}
