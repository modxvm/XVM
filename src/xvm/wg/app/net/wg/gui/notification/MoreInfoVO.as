package net.wg.gui.notification 
{
    import net.wg.data.daapi.base.*;
    
    public class MoreInfoVO extends net.wg.data.daapi.base.DAAPIDataClass
    {
        public function MoreInfoVO(arg1:Object)
        {
            super(arg1);
            return;
        }

        public var command:String="";

        public var enabled:Boolean;

        public var param:Object;
    }
}
