package net.wg.gui.lobby.profile.pages.statistics 
{
    import flash.geom.*;
    import net.wg.gui.lobby.profile.components.chart.layout.*;
    
    public class StatisticBarChartLayout extends net.wg.gui.lobby.profile.components.chart.layout.LayoutBase
    {
        public function StatisticBarChartLayout()
        {
            super();
            return;
        }

        public override function layout(arg1:uint, arg2:Object):void
        {
            var loc1:*=net.wg.gui.lobby.profile.pages.statistics.StatisticBarChartItem(arg2);
            var loc2:*=loc1.getThumbDimensions();
            loc1.x = Math.round(paddingLeft + arg1 * (gap + loc2.x));
            loc1.y = loc1.y - loc2.y;
            return;
        }
    }
}
