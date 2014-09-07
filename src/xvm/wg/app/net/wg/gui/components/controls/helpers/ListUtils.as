package net.wg.gui.components.controls.helpers
{
    import scaleform.clik.interfaces.IDataProvider;
    
    public class ListUtils extends Object
    {
        
        public function ListUtils()
        {
            super();
        }
        
        public static function getFirstSelectablePosition(param1:int, param2:int, param3:IDataProvider, param4:Boolean = true, param5:Function = null) : int
        {
            var _loc6_:int = param2;
            var _loc7_:int = param1;
            var _loc8_:int = param3?param3.length:0;
            var _loc9_:int = param4?1:-1;
            while(_loc7_ >= 0 && _loc7_ < _loc8_)
            {
                if(!checkIsItemDisabled(param3.requestItemAt(_loc7_),param5))
                {
                    _loc6_ = _loc7_;
                    break;
                }
                _loc7_ = _loc7_ + _loc9_;
            }
            return _loc6_;
        }
        
        public static function checkIsItemDisabled(param1:Object, param2:Function = null) : Boolean
        {
            var _loc3_:* = false;
            if(param2 != null)
            {
                return param2(param1);
            }
            if(!param1 || (param1.hasOwnProperty("enabled")) && !param1["enabled"])
            {
                _loc3_ = true;
            }
            return _loc3_;
        }
    }
}
