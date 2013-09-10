package net.wg.gui.lobby.profile.pages.statistics 
{
    import net.wg.data.managers.*;
    
    public class TypeBarChartItem extends net.wg.gui.lobby.profile.pages.statistics.StatisticBarChartItem
    {
        public function TypeBarChartItem()
        {
            super();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            tooltip = PROFILE.SECTION_STATISTICS_CHART_TYPE_TOOLTIP;
            return;
        }

        protected override function showToolTip(arg1:net.wg.data.managers.IToolTipParams):void
        {
            if (tooltip) 
            {
                net.wg.gui.lobby.profile.pages.statistics.StatisticsChartsUtils.showTypeTooltip(_data, tooltip);
            }
            return;
        }
    }
}
