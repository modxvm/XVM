package net.wg.gui.lobby.profile.pages.statistics.body
{
    public class DetailedStatisticsUnitVO extends StatisticsLabelDataVO
    {
        
        public function DetailedStatisticsUnitVO(param1:Object) {
            super(param1);
        }
        
        private var _itemsList:Array;
        
        override protected function parceData(param1:Object) : void {
            var _loc4_:* = undefined;
            var _loc2_:uint = param1?param1.length:0;
            this._itemsList = [];
            var _loc3_:* = 0;
            while(_loc3_ < _loc2_)
            {
                _loc4_ = param1[_loc3_];
                if(_loc4_)
                {
                    this._itemsList.push(new DetailedStatisticsLabelDataVO(_loc4_));
                }
                else
                {
                    this._itemsList.push(null);
                }
                _loc3_++;
            }
        }
        
        public function get itemsList() : Array {
            return this._itemsList;
        }
    }
}
