package net.wg.gui.lobby.profile.data
{
    import net.wg.data.gui_items.ItemsUtils;
    
    public class ProfileCommonInfoVO extends ProfileBaseInfoVO
    {
        
        public function ProfileCommonInfoVO(param1:Object)
        {
            super(param1);
        }
        
        public var hitsEfficiency:Number = -1;
        
        public var maxXP:int = -1;
        
        public var avgXP:int = -1;
        
        public function getHitsEfficiencyStr() : String
        {
            return ItemsUtils.floatToPercent(this.hitsEfficiency);
        }
        
        public function getMaxExperienceStr() : String
        {
            return ItemsUtils.formatIntegerStr(this.maxXP);
        }
        
        public function getAvgExperienceStr() : String
        {
            return ItemsUtils.formatIntegerStr(this.avgXP);
        }
    }
}
