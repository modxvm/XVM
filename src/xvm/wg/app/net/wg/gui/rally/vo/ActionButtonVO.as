package net.wg.gui.rally.vo
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    
    public class ActionButtonVO extends DAAPIDataClass
    {
        
        public function ActionButtonVO(param1:Object) {
            super(param1);
        }
        
        public var stateString:String = "";
        
        public var label:String = "";
        
        public var isEnabled:Boolean = false;
        
        public var isReady:Boolean = false;
    }
}
