package net.wg.gui.lobby.fortifications.data.settings
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    
    public class FortSettingsClanInfoVO extends DAAPIDataClass
    {
        
        public function FortSettingsClanInfoVO(param1:Object)
        {
            super(param1);
        }
        
        public var clanIcon:String = "";
        
        public var clanTag:String = "";
        
        public var creationDate:String = "";
        
        public var buildingCount:String = "";
    }
}
