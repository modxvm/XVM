package net.wg.gui.lobby.profile.pages.statistics.body
{
    import net.wg.gui.components.common.containers.Group;
    import net.wg.gui.lobby.profile.pages.statistics.StatisticChartInfo;
    import scaleform.clik.data.DataProvider;
    import net.wg.gui.lobby.profile.pages.statistics.TypesStatisticsChart;
    import net.wg.gui.lobby.profile.pages.statistics.NationsStatisticsChart;
    import net.wg.gui.lobby.profile.pages.statistics.LevelsStatisticChart;
    import net.wg.gui.lobby.profile.pages.statistics.AxisPointTypes;
    import net.wg.gui.lobby.profile.pages.statistics.AxisPointNations;
    import net.wg.gui.lobby.profile.pages.statistics.AxisPointLevels;
    import net.wg.utils.ILocale;
    import net.wg.gui.lobby.profile.pages.statistics.StatisticsBarChart;
    
    public class ChartsStatisticsGroup extends Group
    {
        
        public function ChartsStatisticsGroup()
        {
            super();
        }
        
        private static function formTypeChartItem(param1:Object, param2:String) : StatisticChartInfo
        {
            var _loc3_:StatisticChartInfo = new StatisticChartInfo();
            _loc3_.xField = param2;
            _loc3_.yField = param1[param2];
            return _loc3_;
        }
        
        private static function formChartItemProvider(param1:Array) : DataProvider
        {
            var _loc3_:StatisticChartInfo = null;
            var _loc5_:Object = null;
            var _loc6_:* = undefined;
            var _loc2_:Array = [];
            var _loc4_:* = 0;
            while(_loc4_ < param1.length)
            {
                _loc5_ = param1[_loc4_];
                for(_loc6_ in _loc5_)
                {
                    _loc3_ = new StatisticChartInfo();
                    _loc3_.xField = _loc6_;
                    _loc3_.yField = _loc5_[_loc6_];
                    _loc2_.push(_loc3_);
                }
                _loc4_++;
            }
            return new DataProvider(_loc2_);
        }
        
        public var typeChart:TypesStatisticsChart;
        
        public var nationChart:NationsStatisticsChart;
        
        public var levelChart:LevelsStatisticChart;
        
        override protected function configUI() : void
        {
            super.configUI();
            this.typeChart.mainHorizontalAxis.pointClass = AxisPointTypes;
            this.nationChart.mainHorizontalAxis.pointClass = AxisPointNations;
            this.levelChart.mainHorizontalAxis.pointClass = AxisPointLevels;
            var _loc1_:ILocale = App.utils.locale;
            this.typeChart.mainHorizontalAxis.lineText.text = _loc1_.makeString(PROFILE.SECTION_STATISTICS_CHARTS_BYTYPELABEL);
            this.nationChart.mainHorizontalAxis.lineText.text = _loc1_.makeString(PROFILE.SECTION_STATISTICS_CHARTS_BYNATIONLABEL);
            this.levelChart.mainHorizontalAxis.lineText.text = _loc1_.makeString(PROFILE.SECTION_STATISTICS_CHARTS_BYLEVELLABEL);
        }
        
        public function setDossierData(param1:Array) : void
        {
            var _loc2_:Vector.<StatisticsBarChart> = new Vector.<StatisticsBarChart>();
            _loc2_.push(this.typeChart);
            _loc2_.push(this.nationChart);
            _loc2_.push(this.levelChart);
            var _loc3_:* = 0;
            while(_loc3_ < _loc2_.length)
            {
                _loc2_[_loc3_].dataProvider = formChartItemProvider(param1[_loc3_]);
                _loc3_++;
            }
        }
        
        override protected function onDispose() : void
        {
            this.typeChart = null;
            this.nationChart = null;
            this.levelChart = null;
            super.onDispose();
        }
    }
}
