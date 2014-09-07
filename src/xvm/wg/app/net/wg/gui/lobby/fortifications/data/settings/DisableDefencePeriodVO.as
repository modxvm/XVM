package net.wg.gui.lobby.fortifications.data.settings
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    
    public class DisableDefencePeriodVO extends DAAPIDataClass
    {
        
        public function DisableDefencePeriodVO(param1:Object)
        {
            super(param1);
        }
        
        public var titleText:String = "";
        
        public var bodyText:String = "";
    }
}
