package net.wg.infrastructure.managers.utils.impl
{
    import flash.text.TextField;
    import net.wg.infrastructure.interfaces.IUserProps;
    import flash.text.TextFormat;
    import net.wg.data.constants.Values;
    import org.idmedia.as3commons.util.StringUtils;
    import net.wg.data.constants.UserTags;

    public class CommonsLobby extends CommonsBase
    {

        private static const IGR_TYPE_PREMIUM:int = 2;

        private static const MIN_NAME_LENGTH:int = 5;

        public function CommonsLobby()
        {
            super();
        }

        override public function formatPlayerName(param1:TextField, param2:IUserProps) : Boolean
        {
            var _loc14_:* = 0;
            var _loc3_:TextFormat = param1.getTextFormat();
            var _loc4_:Object = _loc3_.size;
            var _loc5_:String = _loc3_.font;
            var _loc6_:String = _loc3_.align;
            var _loc7_:String = param2.clanAbbrev?CLAN_TAG_OPEN + param2.clanAbbrev + CLAN_TAG_CLOSE:Values.EMPTY_STR;
            var _loc8_:String = param2.region?Values.SPACE_STR + param2.region:Values.EMPTY_STR;
            var _loc9_:String = _loc8_ + this.formatIgrStr(param2.tags,param2.igrType,param2.igrVspace) + param2.suffix;
            var _loc10_:String = param2.prefix;
            var _loc11_:String = param2.badgeImgStr;
            if(StringUtils.isNotEmpty(_loc11_))
            {
                _loc10_ = _loc11_ + _loc10_;
            }
            var _loc12_:String = _loc10_ + param2.userName + _loc7_ + _loc9_;
            var _loc13_:* = false;
            applyTextProps(param1,_loc12_,_loc3_,_loc4_,_loc5_,_loc6_);
            if(param1.width < param1.textWidth + TEXT_FIELD_BOUNDS_WIDTH)
            {
                _loc13_ = true;
                _loc12_ = _loc10_ + param2.userName.substr(0,MIN_NAME_LENGTH) + CUT_SYMBOLS_STR + _loc7_ + _loc9_;
                applyTextProps(param1,_loc12_,_loc3_,_loc4_,_loc5_,_loc6_);
                if(param1.width >= param1.textWidth + TEXT_FIELD_BOUNDS_WIDTH)
                {
                    _loc9_ = _loc7_ + _loc9_;
                }
                _loc14_ = param2.userName.length - 1;
                do
                {
                    _loc12_ = _loc10_ + param2.userName.substr(0,_loc14_) + CUT_SYMBOLS_STR + _loc9_;
                    applyTextProps(param1,_loc12_,_loc3_,_loc4_,_loc5_,_loc6_);
                    _loc14_--;
                }
                while(param1.width < param1.textWidth + TEXT_FIELD_BOUNDS_WIDTH && _loc14_ > 0);

            }
            if(!isNaN(param2.rgb))
            {
                param1.textColor = param2.rgb;
            }
            if(param2.isTeamKiller)
            {
                param1.setTextFormat(TEAM_KILLER_FORMAT,_loc10_.length,param1.text.length - _loc9_.length);
            }
            return _loc13_;
        }

        override public function getFullPlayerName(param1:IUserProps) : String
        {
            var _loc2_:String = (param1.igrType == IGR_TYPE_PREMIUM?IMG_TAG_OPEN_PREMIUM:IMG_TAG_OPEN_BASIC) + param1.igrVspace + IMG_TAG_CLOSE;
            return param1.prefix + param1.userName + (param1.clanAbbrev?CLAN_TAG_OPEN + param1.clanAbbrev + CLAN_TAG_CLOSE:Values.EMPTY_STR) + (param1.region?Values.SPACE_STR + param1.region:Values.EMPTY_STR) + (param1.igrType > 0?Values.SPACE_STR + _loc2_:Values.EMPTY_STR) + param1.suffix;
        }

        private function formatIgrStr(param1:Array, param2:int, param3:int) : String
        {
            var _loc4_:String = Values.EMPTY_STR;
            if(param2 > 0)
            {
                _loc4_ = (param2 == IGR_TYPE_PREMIUM?IMG_TAG_OPEN_PREMIUM:IMG_TAG_OPEN_BASIC) + param3;
            }
            else if(UserTags.isBaseIGR(param1))
            {
                _loc4_ = IMG_TAG_OPEN_BASIC + param3;
            }
            else if(UserTags.isPremiumIGR(param1))
            {
                _loc4_ = IMG_TAG_OPEN_PREMIUM + param3;
            }
            else
            {
                return _loc4_;
            }
            return Values.SPACE_STR + _loc4_ + IMG_TAG_CLOSE;
        }
    }
}
