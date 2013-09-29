package net.wg.gui.notification 
{
    import net.wg.data.daapi.base.*;
    
    public class NotificationDialogInitInfoVO extends net.wg.data.daapi.base.DAAPIDataClass
    {
        public function NotificationDialogInitInfoVO(arg1:Object)
        {
            super(arg1);
            return;
        }

        public var title:String="";

        public var closeBtnTitle:String="";
    }
}
