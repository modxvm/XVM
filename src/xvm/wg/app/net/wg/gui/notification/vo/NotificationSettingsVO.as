package net.wg.gui.notification.vo
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    
    public class NotificationSettingsVO extends DAAPIDataClass
    {
        
        public function NotificationSettingsVO(param1:Object)
        {
            super(param1);
        }
        
        public var timeout:int = -1;
    }
}
