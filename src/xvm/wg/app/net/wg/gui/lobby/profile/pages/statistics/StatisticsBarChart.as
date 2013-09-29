package net.wg.gui.lobby.profile.pages.statistics 
{
    import net.wg.gui.lobby.profile.components.chart.*;
    import scaleform.clik.interfaces.*;
    
    public class StatisticsBarChart extends net.wg.gui.lobby.profile.components.chart.AxisChart
    {
        public function StatisticsBarChart()
        {
            super();
            var loc1:*=new net.wg.gui.lobby.profile.pages.statistics.StatisticBarChartLayout();
            loc1.paddingRight = 26;
            loc1.paddingLeft = 27;
            loc1.gap = 18;
            currentLayout = loc1;
            horizontalAxis = this.mainHorizontalAxis;
            return;
        }

        public override function set dataProvider(arg1:scaleform.clik.interfaces.IDataProvider):void
        {
            var loc2:*=null;
            if (!arg1) 
            {
                return;
            }
            var loc1:*=0;
            var loc3:*=arg1.length;
            var loc4:*=0;
            while (loc4 < loc3) 
            {
                loc2 = arg1[loc4];
                if (loc1 < loc2.yField) 
                {
                    loc1 = Number(loc2.yField);
                }
                this.adjustProviderItem(loc2, loc4);
                ++loc4;
            }
            loc4 = 0;
            while (loc4 < loc3) 
            {
                loc2 = arg1[loc4];
                loc2.percentValue = Math.round(Number(loc2.yField) / loc1 * percent100);
                ++loc4;
            }
            super.dataProvider = arg1;
            return;
        }

        protected function adjustProviderItem(arg1:net.wg.gui.lobby.profile.pages.statistics.StatisticChartInfo, arg2:int):void
        {
            return;
        }

        internal static const percent100:uint=100;

        public var mainHorizontalAxis:net.wg.gui.lobby.profile.pages.statistics.StatisticsBarChartAxis;
    }
}
