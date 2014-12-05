package net.wg.gui.lobby.profile.pages.technique.data
{
    import net.wg.gui.lobby.profile.data.ProfileCommonInfoVO;
    import net.wg.gui.lobby.profile.data.AchievementProfileVO;
    import net.wg.gui.lobby.profile.pages.statistics.body.DetailedStatisticsUnitVO;
    
    public class ProfileVehicleDossierVO extends ProfileCommonInfoVO
    {
        
        public function ProfileVehicleDossierVO(param1:Object)
        {
            super(param1);
        }
        
        public var achievements:Array;
        
        private var _achievementsVOs:Array;
        
        public var detailedData:Object;
        
        private var _detailedDataList:Array;
        
        override protected function onDataWrite(param1:String, param2:Object) : Boolean
        {
            var _loc3_:Array = null;
            var _loc4_:uint = 0;
            var _loc5_:AchievementProfileVO = null;
            var _loc6_:uint = 0;
            var _loc7_:Array = null;
            var _loc8_:Array = null;
            var _loc9_:uint = 0;
            var _loc10_:uint = 0;
            var _loc11_:* = 0;
            var _loc12_:Array = null;
            var _loc13_:* = 0;
            if(param1 == "achievements" && (param2))
            {
                _loc3_ = param2 as Array;
                _loc4_ = _loc3_.length;
                this._achievementsVOs = [];
                _loc6_ = 0;
                while(_loc6_ < _loc4_)
                {
                    _loc7_ = [];
                    _loc8_ = _loc3_[_loc6_];
                    _loc9_ = 0;
                    _loc10_ = _loc8_.length;
                    _loc11_ = 0;
                    while(_loc11_ < _loc10_)
                    {
                        _loc5_ = new AchievementProfileVO(_loc8_[_loc11_]);
                        _loc7_.push(_loc5_);
                        _loc11_++;
                    }
                    this._achievementsVOs.push(_loc7_);
                    _loc6_++;
                }
                return false;
            }
            if(param1 == "detailedData")
            {
                this._detailedDataList = [];
                _loc12_ = param2 as Array;
                _loc13_ = 0;
                while(_loc13_ < _loc12_.length)
                {
                    this._detailedDataList.push(new DetailedStatisticsUnitVO(_loc12_[_loc13_]));
                    _loc13_++;
                }
                return false;
            }
            return this.hasOwnProperty(param1);
        }
        
        public function get achievementsVOs() : Array
        {
            return this._achievementsVOs;
        }
        
        public function get detailedDataList() : Array
        {
            return this._detailedDataList;
        }
    }
}
