package net.wg.gui.lobby.profile.data
{
    import net.wg.data.gui_items.ItemsUtils;
    
    public class ProfileDossierInfoVO extends ProfileCommonInfoVO
    {
        
        public function ProfileDossierInfoVO(param1:Object)
        {
            super(param1);
        }
        
        public var maxXPByVehicle:String = "";
        
        public var marksOfMastery:int;
        
        public var totalUserVehiclesCount:uint;
        
        public function getMarksOfMasteryCountStr() : String
        {
            return ItemsUtils.formatIntegerStr(this.marksOfMastery);
        }
    }
}
