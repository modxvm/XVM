package net.wg.gui.lobby.profile.components
{
    import flash.text.TextField;
    import net.wg.data.constants.Values;
    
    public class UserDateFooter extends ProfileFooter
    {
        
        public function UserDateFooter()
        {
            super();
        }
        
        public static function getDateWithDot(param1:String) : String
        {
            var _loc2_:String = param1;
            if(_loc2_.lastIndexOf(".") != _loc2_.length - 1)
            {
                _loc2_ = _loc2_ + ".";
            }
            return _loc2_;
        }
        
        public var textDates:TextField;
        
        override protected function applyDataChanges() : void
        {
            var _loc1_:String = getDateWithDot(initData.registrationDate);
            var _loc2_:String = _loc1_ + this.getSeparator();
            var _loc3_:String = initData.lastBattleDate;
            if(_loc3_ != Values.EMPTY_STR)
            {
                _loc3_ = getDateWithDot(_loc3_);
            }
            _loc2_ = _loc2_ + _loc3_;
            this.textDates.htmlText = _loc2_;
        }
        
        protected function getSeparator() : String
        {
            return " ";
        }
    }
}
