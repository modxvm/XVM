package net.wg.gui.notification.constants
{
    import net.wg.data.constants.Linkages;
    
    public class ButtonType extends Object
    {
        
        public function ButtonType() {
            super();
        }
        
        public static var SUBMIT:String = "submit";
        
        public static var CANCEL:String = "cancel";
        
        public static function getLinkageByType(param1:String) : String {
            var _loc2_:String = null;
            switch(param1)
            {
                case SUBMIT:
                    _loc2_ = Linkages.BUTTON_NORMAL;
                    break;
                case CANCEL:
                    _loc2_ = Linkages.BUTTON_BLACK;
                    break;
                default:
                    DebugUtils.LOG_ERROR("Type of button is not valid.",param1);
            }
            return _loc2_;
        }
    }
}
