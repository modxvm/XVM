package net.wg.gui.lobby.retrainCrewWindow
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    import net.wg.data.constants.Currencies;
    
    public class RetrainCrewBlockVO extends DAAPIDataClass
    {
        
        public function RetrainCrewBlockVO(param1:Object) {
            super(param1);
        }
        
        public var crew:Object;
        
        public var price:Object;
        
        private var _crewInfoVO:Array;
        
        private var _priceInfo:SelPriceInfo;
        
        override protected function onDataWrite(param1:String, param2:Object) : Boolean {
            var _loc3_:Array = null;
            var _loc4_:uint = 0;
            var _loc5_:* = 0;
            var _loc6_:RetrainTankmanVO = null;
            var _loc7_:Array = null;
            var _loc8_:* = false;
            var _loc9_:String = null;
            var _loc10_:* = NaN;
            if(param1 == "crew")
            {
                this._crewInfoVO = [];
                _loc3_ = param2 as Array;
                _loc4_ = _loc3_.length;
                _loc5_ = 0;
                while(_loc5_ < _loc4_)
                {
                    _loc6_ = new RetrainTankmanVO(_loc3_[_loc5_]);
                    this._crewInfoVO.push(_loc6_);
                    _loc5_++;
                }
                return false;
            }
            if(param1 == "price")
            {
                _loc7_ = param2 as Array;
                _loc8_ = _loc7_[0] > 0;
                _loc9_ = _loc8_?Currencies.GOLD:Currencies.CREDITS;
                _loc10_ = _loc8_?_loc7_[0]:_loc7_[1];
                this._priceInfo = new SelPriceInfo(_loc9_,_loc10_);
            }
            return this.hasOwnProperty(param1);
        }
        
        public function get crewInfoVO() : Array {
            return this._crewInfoVO;
        }
        
        public function get priceInfo() : SelPriceInfo {
            return this._priceInfo;
        }
    }
}
