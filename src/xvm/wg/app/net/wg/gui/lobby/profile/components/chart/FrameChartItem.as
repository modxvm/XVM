package net.wg.gui.lobby.profile.components.chart 
{
    public class FrameChartItem extends net.wg.gui.lobby.profile.components.chart.ChartItem
    {
        public function FrameChartItem()
        {
            super();
            return;
        }

        protected override function applyValueChange():void
        {
            this.gotoAndStop(value);
            return;
        }
    }
}
