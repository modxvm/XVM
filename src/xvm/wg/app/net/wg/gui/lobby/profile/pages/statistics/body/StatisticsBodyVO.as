package net.wg.gui.lobby.profile.pages.statistics.body
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    
    public class StatisticsBodyVO extends DAAPIDataClass
    {
        
        public function StatisticsBodyVO(param1:Object)
        {
            super(param1);
        }
        
        public var dataList:Object;
        
        private var _dataListVO:Vector.<StatisticsLabelDataVO>;
        
        override protected function onDataWrite(param1:String, param2:Object) : Boolean
        {
            var _loc3_:* = 0;
            var _loc4_:Object = null;
            if(param1 == "dataList")
            {
                this._dataListVO = new Vector.<StatisticsLabelDataVO>();
                _loc3_ = 0;
                while(_loc3_ < param2.length)
                {
                    _loc4_ = param2[_loc3_];
                    if(_loc4_.viewType == StatisticsLabelViewTypeDataVO.VIEW_TYPE_TABLES)
                    {
                        this._dataListVO.push(new DetailedLabelDataVO(_loc4_));
                    }
                    else if(_loc4_.viewType == StatisticsLabelViewTypeDataVO.VIEW_TYPE_CHARTS)
                    {
                        this._dataListVO.push(new StatisticsChartsTabDataVO(_loc4_));
                    }
                    
                    _loc3_++;
                }
                return false;
            }
            return this.hasOwnProperty(param1);
        }
        
        public function get dataListVO() : Vector.<StatisticsLabelDataVO>
        {
            return this._dataListVO;
        }
        
        override protected function onDispose() : void
        {
            super.onDispose();
            this.dataList = null;
            this._dataListVO = null;
        }
    }
}
