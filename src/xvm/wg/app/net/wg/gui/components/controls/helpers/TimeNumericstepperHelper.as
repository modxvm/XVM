package net.wg.gui.components.controls.helpers
{
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import net.wg.data.constants.Time;
    
    public class TimeNumericstepperHelper extends Object implements IDisposable
    {
        
        public function TimeNumericstepperHelper()
        {
            super();
        }
        
        private static var _instance:TimeNumericstepperHelper;
        
        public static function get instance() : TimeNumericstepperHelper
        {
            if(_instance == null)
            {
                _instance = new TimeNumericstepperHelper();
            }
            return _instance;
        }
        
        public function sortSkipValues(param1:Array) : Array
        {
            var _loc3_:* = 0;
            var _loc4_:* = 0;
            var _loc8_:* = 0;
            var _loc9_:* = false;
            var _loc2_:Array = [];
            var _loc5_:* = 0;
            while(_loc5_ < param1.length)
            {
                _loc3_ = param1[_loc5_];
                _loc4_ = param1[_loc5_ + 1];
                _loc8_ = 0;
                while(_loc8_ <= Time.HOURS_IN_DAY)
                {
                    if(_loc2_[_loc8_] == null || _loc2_[_loc8_] == false)
                    {
                        _loc2_[_loc8_] = _loc3_ < _loc4_ && _loc8_ >= _loc3_ && _loc8_ <= _loc4_;
                        _loc2_[_loc8_] = _loc2_[_loc8_] || _loc3_ > _loc4_ && (_loc8_ >= _loc3_ || _loc8_ <= _loc4_);
                    }
                    _loc8_++;
                }
                _loc5_ = _loc5_ + 2;
            }
            var _loc6_:Array = [];
            var _loc7_:* = false;
            _loc5_ = 0;
            while(_loc5_ < _loc2_.length)
            {
                _loc9_ = _loc2_[_loc5_] == true;
                if((_loc9_) && !_loc7_)
                {
                    _loc3_ = _loc5_;
                    _loc7_ = true;
                }
                else if(!_loc9_ && (_loc7_))
                {
                    _loc4_ = _loc5_ - 1;
                    _loc6_.push(_loc3_,_loc4_);
                    _loc7_ = false;
                }
                else if(_loc5_ == _loc2_.length - 1 && (_loc7_))
                {
                    _loc6_.push(_loc3_,_loc2_.length - 1);
                }
                
                
                _loc5_++;
            }
            return _loc6_;
        }
        
        public function dispose() : void
        {
            _instance = null;
        }
    }
}
