package net.wg.gui.lobby.fortifications.data.settings
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    
    public class DayOffPopoverVO extends DAAPIDataClass
    {
        
        public function DayOffPopoverVO(param1:Object)
        {
            super(param1);
        }
        
        public var currentDayOff:int = -1;
        
        public var daysList:Array = null;
    }
}
