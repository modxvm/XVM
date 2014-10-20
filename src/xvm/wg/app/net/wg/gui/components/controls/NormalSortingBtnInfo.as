package net.wg.gui.components.controls
{
    import net.wg.gui.components.advanced.SortingButtonInfo;
    import net.wg.data.managers.ITooltipProps;
    
    public class NormalSortingBtnInfo extends SortingButtonInfo
    {
        
        public function NormalSortingBtnInfo()
        {
            super();
        }
        
        public var showSeparator:Boolean = true;
        
        public var showDisabledState:Boolean = false;
        
        public var textAlign:String = "center";
        
        public var toolTipSpecialType:String;
        
        public var toolTipSpecialProps:ITooltipProps;
        
        public var toolTipSpecialArgs:Array;
        
        public function setToolTipSpecial(param1:String, param2:ITooltipProps = null, ... rest) : void
        {
            this.toolTipSpecialType = param1;
            this.toolTipSpecialProps = param2;
            this.toolTipSpecialArgs = rest;
        }
    }
}
