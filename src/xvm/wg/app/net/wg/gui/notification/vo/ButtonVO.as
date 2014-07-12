package net.wg.gui.notification.vo
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    
    public class ButtonVO extends DAAPIDataClass
    {
        
        public function ButtonVO(param1:Object) {
            super(param1);
        }
        
        public var type:String = "";
        
        public var label:String = "";
        
        public var action:String = "";
        
        public var width:Number = 122;
    }
}
