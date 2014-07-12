package net.wg.gui.lobby.fortifications.data
{
    public class BuildingPopoverHeaderVO extends BuildingPopoverBaseVO
    {
        
        public function BuildingPopoverHeaderVO(param1:Object) {
            super(param1);
        }
        
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
    }
}
