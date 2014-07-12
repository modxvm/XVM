package net.wg.gui.lobby.fortifications.data
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    
    public class BuildingProgressLblVO extends DAAPIDataClass
    {
        
        public function BuildingProgressLblVO(param1:Object) {
            super(param1);
        }
        
        public var totalValue:String = "";
        
        public var currentValue:String = "";
        
        public var separator:String = "";
    }
}
