package net.wg.gui.lobby.fortifications.data
{
    import net.wg.gui.components.tooltips.VO.MapVO;
    
    public class BuildingPopoverHeaderVO extends BuildingPopoverBaseVO
    {
        
        public function BuildingPopoverHeaderVO(param1:Object)
        {
            super(param1);
        }
        
        private static var TOOLTIP_DATA:String = "tooltipData";
        
        public var upgradeButtonToolTip:String = "";
        
        public var buildingName:String = "";
        
        public var buildingIcon:String = "";
        
        public var buildLevel:String = "";
        
        public var titleStatus:String = "";
        
        public var bodyStatus:String = "";
        
        public var showUpgradeButton:Boolean = false;
        
        public var enableUpgradeBtn:Boolean = false;
        
        public var demountBtnTooltip:String = "";
        
        public var enableDemountBtn:Boolean = false;
        
        public var glowColor:Number = 0;
        
        public var isModernization:Boolean = false;
        
        public var canDeleteBuilding:Boolean = false;
        
        public var mapInfo:String = "";
        
        public var tooltipData:MapVO = null;
        
        public var isToolTipSpecial:Boolean = false;
        
        override protected function onDataWrite(param1:String, param2:Object) : Boolean
        {
            if(param1 == TOOLTIP_DATA)
            {
                this[param1] = new MapVO(param2);
                return false;
            }
            return super.onDataWrite(param1,param2);
        }
        
        override protected function onDispose() : void
        {
            if(this.tooltipData)
            {
                this.tooltipData.dispose();
                this.tooltipData = null;
            }
            super.onDispose();
        }
    }
}
