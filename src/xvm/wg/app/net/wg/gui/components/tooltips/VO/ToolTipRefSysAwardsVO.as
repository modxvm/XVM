package net.wg.gui.components.tooltips.VO
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    
    public class ToolTipRefSysAwardsVO extends DAAPIDataClass
    {
        
        public function ToolTipRefSysAwardsVO(param1:Object)
        {
            super(param1);
        }
        
        public var iconSource:String = "";
        
        public var infoTitle:String = "";
        
        public var infoBody:String = "";
        
        public var conditions:String = "";
        
        public var awardStatus:String = "";
    }
}
