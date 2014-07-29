package net.wg.gui.lobby.fortifications.data
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    
    public class BuildingPopoverBaseVO extends DAAPIDataClass
    {
        
        public function BuildingPopoverBaseVO(param1:Object)
        {
            super(param1);
        }
        
        public var buildingType:String = "";
        
        public var isCommander:Boolean = false;
        
        public var isVisibleDemountBtn:Boolean = false;
    }
}
