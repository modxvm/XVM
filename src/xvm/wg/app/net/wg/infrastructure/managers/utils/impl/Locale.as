package net.wg.infrastructure.managers.utils.impl
{
    import net.wg.utils.ILocale;
    import net.wg.data.constants.EngineMethods;
    import net.wg.infrastructure.interfaces.IFormattedInt;
    import net.wg.data.constants.Values;
    import net.wg.data.utilData.FormattedInteger;
    import net.wg.data.constants.Currencies;
    import net.wg.data.constants.ColorSchemeNames;
    
    public class Locale extends Object implements ILocale
    {
        
        public function Locale() {
            super();
        }
        
        private static var ICON_DEF_PATH:String = "img://gui/maps/icons/library/";
        
        public function gold(param1:Object) : String {
            return this.envokeC(EngineMethods.GET_GOLD_FMT,Number(param1));
        }
        
        public function integer(param1:Object) : String {
            return this.envokeC(EngineMethods.GET_INT_FMT,Number(param1));
        }
        
        public function float(param1:Object) : String {
            return this.envokeC(EngineMethods.GET_FRAC_FMT,Number(param1));
        }
        
        public function niceNumber(param1:Object) : String {
            var _loc2_:* = "Call to deprecated method niceNumber in Locale." + "- it`s a bad name";
            DebugUtils.LOG_DEBUG(_loc2_);
            return this.numberWithoutZeros(param1);
        }
        
        public function numberWithoutZeros(param1:Object) : String {
            return this.envokeC(EngineMethods.GET_NONZERO_FMT,Number(param1));
        }
        
        public function parseFormattedInteger(param1:String) : IFormattedInt {
            var _loc7_:String = null;
            var _loc2_:* = "";
            var _loc3_:String = this.cutCharsBeforeNumber(param1);
            var _loc4_:int = _loc3_.length;
            var _loc5_:Number = 0;
            while(_loc5_ < _loc4_)
            {
                _loc7_ = _loc3_.charAt(_loc5_);
                if(Values.DIGIT.indexOf(_loc7_) == -1)
                {
                    _loc2_ = _loc2_ + _loc7_;
                }
                else if(_loc2_ != "")
                {
                    break;
                }
                
                _loc5_++;
            }
            var _loc6_:String = _loc3_;
            if(_loc2_ != param1)
            {
                _loc6_ = param1.split(_loc2_).join(Values.EMPTY_STR);
            }
            else
            {
                _loc2_ = "";
            }
            return new FormattedInteger(Number(_loc6_),_loc2_);
        }
        
        public function cutCharsBeforeNumber(param1:String) : String {
            var _loc2_:String = param1;
            var _loc3_:Number = _loc2_.length;
            var _loc4_:Number = 0;
            while(_loc4_ < _loc3_)
            {
                if(Values.DIGIT.indexOf(param1.charAt(_loc4_)) != -1)
                {
                    _loc2_ = param1.slice(_loc4_,_loc3_);
                    break;
                }
                _loc4_++;
            }
            return _loc2_;
        }
        
        public function shortTime(param1:Object) : String {
            return this.envokeC(EngineMethods.GET_SHORT_TIME_FMT,Number(param1));
        }
        
        public function longTime(param1:Object) : String {
            return this.envokeC(EngineMethods.GET_LONG_TIME_FMT,Number(param1));
        }
        
        public function shortDate(param1:Object) : String {
            return this.envokeC(EngineMethods.GET_SHORT_DATE_FMT,Number(param1));
        }
        
        public function longDate(param1:Object) : String {
            return this.envokeC(EngineMethods.GET_LONG_DATE_FMT,Number(param1));
        }
        
        public function makeString(param1:String, param2:Object = null) : String {
            if(param2 == null)
            {
                param2 = {};
            }
            return this.envokeCFormatted(EngineMethods.GET_FMTED_LCLZED_STR,param1,App.utils.JSON.encode(param2));
        }
        
        private function envokeC(param1:String, param2:Object) : String {
            return String(App.environment.call(param1,param2));
        }
        
        private function envokeCFormatted(param1:String, param2:Object, param3:Object) : * {
            return App.environment.call(param1,param2,param3);
        }
        
        public function htmlTextWithIcon(param1:String, param2:String) : String {
            var _loc3_:uint = 0;
            if(param2 == Currencies.CREDITS)
            {
                _loc3_ = App.colorSchemeMgr.getRGB(ColorSchemeNames.TEXT_COLOR_CREDITS);
                param2 = "Credits";
            }
            else if(param2 == Currencies.GOLD)
            {
                _loc3_ = App.colorSchemeMgr.getRGB(ColorSchemeNames.TEXT_COLOR_GOLD);
                param2 = "Gold";
            }
            
            return "<font color=\"#" + _loc3_.toString(16) + "\" >" + param1 + "</font>  <img src=\"" + ICON_DEF_PATH + param2 + "Icon-2.png\" width=\"16\" height=\"16\" vspace=\"-4\" hspace=\"0\"/>";
        }
    }
}
