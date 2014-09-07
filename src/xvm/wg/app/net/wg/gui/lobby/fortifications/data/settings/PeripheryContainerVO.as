package net.wg.gui.lobby.fortifications.data.settings
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    
    public class PeripheryContainerVO extends DAAPIDataClass
    {
        
        public function PeripheryContainerVO(param1:Object)
        {
            super(param1);
        }
        
        public var peripheryTitle:String = "";
        
        public var peripheryName:String = "";
    }
}
