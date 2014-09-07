package net.wg.gui.components.tooltips.VO
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    
    public class ToolTipSettingsButtonVO extends DAAPIDataClass
    {
        
        public function ToolTipSettingsButtonVO(param1:Object)
        {
            super(param1);
        }
        
        public var name:String = "";
        
        public var description:String = "";
        
        public var serverHeader:String = "";
        
        public var serverName:String = "";
        
        public var playersOnServer:String = "";
        
        public var servers:Object = null;
    }
}
