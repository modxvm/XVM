package net.wg.gui.utils
{
    import flash.display.Graphics;

    public class GraphicsUtilities extends Object
    {

        public function GraphicsUtilities()
        {
            super();
        }

        public static function drawArc(param1:Graphics, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number) : void
        {
            var _loc7_:* = NaN;
            var _loc8_:* = NaN;
            var _loc9_:* = NaN;
            var _loc10_:* = NaN;
            var _loc11_:* = NaN;
            var _loc12_:* = NaN;
            var _loc13_:* = NaN;
            var _loc14_:* = NaN;
            var _loc15_:* = NaN;
            var _loc16_:* = NaN;
            var _loc17_:* = NaN;
            var _loc18_:uint = 0;
            if(Math.abs(param5) >= 2 * Math.PI)
            {
                param1.drawCircle(param2,param3,param6);
                return;
            }
            _loc11_ = Math.ceil(Math.abs(param5) / (Math.PI / 4));
            _loc7_ = param5 / _loc11_;
            _loc8_ = -_loc7_;
            _loc9_ = -param4;
            if(_loc11_ > 0)
            {
                _loc12_ = param2 + Math.cos(param4) * param6;
                _loc13_ = param3 + Math.sin(-param4) * param6;
                param1.moveTo(_loc12_,_loc13_);
                _loc18_ = 0;
                while(_loc18_ < _loc11_)
                {
                    _loc9_ = _loc9_ + _loc8_;
                    _loc10_ = _loc9_ - _loc8_ / 2;
                    _loc14_ = param2 + Math.cos(_loc9_) * param6;
                    _loc15_ = param3 + Math.sin(_loc9_) * param6;
                    _loc16_ = param2 + Math.cos(_loc10_) * param6 / Math.cos(_loc8_ / 2);
                    _loc17_ = param3 + Math.sin(_loc10_) * param6 / Math.cos(_loc8_ / 2);
                    param1.curveTo(_loc16_,_loc17_,_loc14_,_loc15_);
                    _loc18_++;
                }
            }
        }
    }
}
