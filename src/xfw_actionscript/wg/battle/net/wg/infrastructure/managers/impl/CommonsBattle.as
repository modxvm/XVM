package net.wg.infrastructure.managers.impl
{
    import net.wg.infrastructure.managers.utils.impl.CommonsBase;
    import flash.text.TextField;
    import net.wg.infrastructure.interfaces.IUserProps;
    import net.wg.data.constants.Values;
    import net.wg.data.constants.UserTags;
    import flash.geom.Rectangle;

    public class CommonsBattle extends CommonsBase
    {

        public function CommonsBattle()
        {
            super();
        }

        override public function formatPlayerName(param1:TextField, param2:IUserProps) : Boolean
        {
            var _loc10_:* = false;
            var _loc12_:String = null;
            var _loc13_:Vector.<String> = null;
            var _loc14_:* = 0;
            var _loc3_:Array = param2.tags;
            var _loc4_:String = param2.userName;
            var _loc5_:String = param2.clanAbbrev?CLAN_TAG_OPEN + param2.clanAbbrev + CLAN_TAG_CLOSE:Values.EMPTY_STR;
            var _loc6_:String = param2.region?Values.SPACE_STR + param2.region:Values.EMPTY_STR;
            var _loc7_:String = Values.EMPTY_STR;
            var _loc8_:uint = param1.textColor;
            if(_loc3_ && UserTags.isInIGR(_loc3_))
            {
                _loc7_ = Values.SPACE_STR + (UserTags.isBaseIGR(_loc3_)?IMG_TAG_OPEN_BASIC:IMG_TAG_OPEN_PREMIUM) + param2.igrVspace + IMG_TAG_CLOSE;
            }
            var _loc9_:String = _loc4_ + _loc5_ + _loc6_ + _loc7_;
            var _loc11_:Number = param1.width;
            param1.htmlText = _loc9_;
            if(_loc11_ < param1.textWidth + TEXT_FIELD_BOUNDS_WIDTH)
            {
                _loc10_ = true;
                _loc12_ = _loc6_ + _loc7_;
                _loc13_ = new <String>["",_loc5_,_loc7_,_loc12_,_loc5_ + _loc12_];
                _loc14_ = _loc13_.length - 1;
                while(_loc14_ >= 0)
                {
                    if(this.cutPlayerName(param1,_loc4_,_loc13_[_loc14_]))
                    {
                        break;
                    }
                    _loc14_--;
                }
            }
            param1.textColor = _loc8_;
            return _loc10_;
        }

        private function cutPlayerName(param1:TextField, param2:String, param3:String) : Boolean
        {
            var _loc4_:* = 4;
            var _loc5_:uint = param2.length;
            if(_loc5_ <= _loc4_)
            {
                param1.htmlText = param2 + param3;
            }
            else
            {
                param1.htmlText = param2 + CUT_SYMBOLS_STR + param3;
            }
            var _loc6_:Number = param1.width;
            var _loc7_:Number = param1.length - 1;
            var _loc8_:Rectangle = param1.getCharBoundaries(_loc5_ - 1);
            var _loc9_:Rectangle = param1.getCharBoundaries(_loc7_);
            var _loc10_:Number = _loc9_.x + _loc9_.width - (_loc8_.x + _loc8_.width);
            var _loc11_:Rectangle = param1.getCharBoundaries(0);
            if(_loc5_ <= _loc4_)
            {
                return _loc8_.x + _loc8_.width - _loc11_.x + _loc10_ + TEXT_FIELD_BOUNDS_WIDTH <= _loc6_;
            }
            var _loc12_:int = _loc5_;
            while(_loc12_ >= _loc4_)
            {
                _loc8_ = param1.getCharBoundaries(_loc12_ - 1);
                _loc5_ = _loc12_;
                if(_loc8_.x + _loc8_.width - _loc11_.x + _loc10_ + TEXT_FIELD_BOUNDS_WIDTH <= _loc6_)
                {
                    _loc12_--;
                    break;
                }
                _loc12_--;
            }
            param1.htmlText = param2.substr(0,_loc5_) + CUT_SYMBOLS_STR + param3;
            return _loc12_ >= _loc4_;
        }
    }
}
