package net.wg.utils
{
    import flash.text.TextField;
    import net.wg.data.constants.Values;

    public class TextFieldUtils extends Object
    {

        private static var _instance:TextFieldUtils = null;

        private static const STR_MORE:String = ">";

        private static const STR_LESS:String = "<";

        private static const REGEXP_WIDTH:RegExp = new RegExp("width=\'(\\d*)\'");

        private static const STR_TWO_DOTS:String = "..";

        public function TextFieldUtils()
        {
            super();
            if(_instance != null)
            {
                throw new Error("Singleton TextFieldUtils can only be accessed through TextFieldUtils.instance");
            }
        }

        public static function get instance() : TextFieldUtils
        {
            if(_instance == null)
            {
                _instance = new TextFieldUtils();
            }
            return _instance;
        }

        public function cutHtmlText(param1:String) : String
        {
            var _loc3_:* = NaN;
            var _loc4_:* = NaN;
            var _loc5_:String = null;
            var _loc2_:String = param1;
            while(true)
            {
                _loc3_ = _loc2_.indexOf(STR_LESS);
                if(_loc3_ < 0)
                {
                    break;
                }
                _loc4_ = _loc2_.indexOf(STR_MORE,_loc3_);
                _loc5_ = _loc2_.substr(_loc3_,_loc4_ - _loc3_ + 1);
                _loc2_ = _loc2_.substr(0,_loc3_) + _loc2_.substr(_loc4_ + 1,_loc2_.length);
            }
            return _loc2_;
        }

        public function truncateHtmlTextMultiline(param1:TextField, param2:String, param3:uint = 1, param4:String = "..") : Boolean
        {
            var _loc5_:* = false;
            var _loc6_:String = param2;
            param1.htmlText = _loc6_;
            while(param1.numLines > param3)
            {
                _loc6_ = _loc6_.substr(0,_loc6_.length - 1);
                param1.htmlText = _loc6_ + param4;
                _loc5_ = true;
            }
            return _loc5_;
        }

        public function truncateTextFieldMultiline(param1:TextField, param2:String, param3:uint, param4:String = "..") : Boolean
        {
            var _loc5_:* = false;
            var _loc6_:String = param2;
            param1.htmlText = _loc6_;
            while(param1.numLines > param3)
            {
                if(!_loc5_)
                {
                    _loc5_ = true;
                    _loc6_ = _loc6_.substr(0,_loc6_.length - param4.length - 1);
                }
                else
                {
                    _loc6_ = _loc6_.substr(0,_loc6_.length - 1);
                }
                param1.htmlText = _loc6_ + param4;
            }
            return _loc5_;
        }

        public function truncateTextFieldText(param1:TextField, param2:String, param3:Boolean = true, param4:Boolean = false, param5:String = "..") : String
        {
            var _loc9_:Array = null;
            var _loc10_:Array = null;
            var _loc11_:* = NaN;
            var _loc12_:* = NaN;
            var _loc13_:String = null;
            var _loc14_:String = null;
            var _loc15_:* = 0;
            var _loc16_:Array = null;
            var _loc17_:uint = 0;
            var _loc18_:* = false;
            var _loc19_:* = 0;
            var _loc20_:* = 0;
            var _loc21_:* = NaN;
            if(param2 == null || param2 == Values.EMPTY_STR)
            {
                param1.text = Values.EMPTY_STR;
                return Values.EMPTY_STR;
            }
            var _loc6_:uint = 4;
            var _loc7_:int = param3?param1.width / param1.scaleX:param1.height / param1.scaleY;
            var _loc8_:String = Values.EMPTY_STR;
            if(param4)
            {
                _loc9_ = [];
                _loc10_ = [];
                _loc14_ = param2;
                _loc15_ = 0;
                _loc16_ = REGEXP_WIDTH.exec(param2);
                if(_loc16_)
                {
                    _loc19_ = _loc16_.length;
                    if(_loc19_ > 1)
                    {
                        _loc20_ = 0;
                        while(_loc20_ != _loc19_)
                        {
                            _loc15_ = _loc15_ + _loc16_[_loc20_];
                            _loc20_++;
                        }
                    }
                }
                while(true)
                {
                    _loc11_ = _loc14_.indexOf(STR_LESS);
                    if(_loc11_ < 0)
                    {
                        break;
                    }
                    _loc12_ = _loc14_.indexOf(STR_MORE,_loc11_);
                    _loc13_ = _loc14_.substr(_loc11_,_loc12_ - _loc11_ + 1);
                    _loc9_.push(_loc13_);
                    _loc10_.push(_loc11_);
                    _loc14_ = _loc14_.substr(0,_loc11_) + _loc14_.substr(_loc12_ + 1,_loc14_.length);
                }
                _loc17_ = _loc14_.length;
                param1.text = _loc14_;
                _loc18_ = param3 && _loc17_ > 0 && param1.textWidth + _loc6_ + _loc15_ > _loc7_ || _loc17_ > 0 && param1.textHeight + _loc6_ > _loc7_;
                if(_loc18_)
                {
                    _loc8_ = this.trunkTextFieldTextProcess(param1,_loc14_,param3,_loc7_,_loc6_ + _loc15_,param5);
                    _loc8_ = _loc8_.slice(0,-param5.length);
                    _loc21_ = _loc9_.length - 1;
                    while(_loc21_ >= 0)
                    {
                        _loc11_ = _loc10_[_loc21_];
                        if(_loc11_ < _loc8_.length)
                        {
                            _loc8_ = _loc8_.substr(0,_loc11_) + _loc9_[_loc21_] + _loc8_.substr(_loc11_);
                        }
                        _loc21_--;
                    }
                    _loc8_ = _loc8_ + param5;
                }
                else
                {
                    _loc8_ = param2;
                }
                param1.htmlText = _loc8_;
            }
            else
            {
                _loc8_ = this.trunkTextFieldTextProcess(param1,param2,param3,_loc7_,_loc6_,param5);
            }
            return _loc8_;
        }

        private function trunkTextFieldTextProcess(param1:TextField, param2:String, param3:Boolean, param4:int, param5:uint, param6:String) : String
        {
            param1.text = param2;
            var _loc7_:uint = param2.length;
            if(param3)
            {
                while(_loc7_ > 0 && param1.textWidth + param5 > param4)
                {
                    _loc7_--;
                    param1.text = param2.substring(0,_loc7_) + param6;
                }
            }
            else
            {
                while(_loc7_ > 0 && param1.textHeight + param5 > param4)
                {
                    _loc7_--;
                    param1.text = param2.substring(0,_loc7_) + param6;
                }
            }
            return param1.text;
        }
    }
}
