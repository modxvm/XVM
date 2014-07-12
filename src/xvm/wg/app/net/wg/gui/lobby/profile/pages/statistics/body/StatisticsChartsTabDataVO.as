package net.wg.gui.lobby.profile.pages.statistics.body
{
    public class StatisticsChartsTabDataVO extends StatisticsLabelDataVO
    {
        
        public function StatisticsChartsTabDataVO(param1:Object) {
            super(param1);
        }
        
        public var chartsData:Array;
        
        override protected function parceData(param1:Object) : void {
            this.chartsData = param1.data;
        }
    }
}
