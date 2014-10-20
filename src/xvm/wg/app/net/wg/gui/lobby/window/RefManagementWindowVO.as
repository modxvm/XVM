package net.wg.gui.lobby.window
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    
    public class RefManagementWindowVO extends DAAPIDataClass
    {
        
        public function RefManagementWindowVO(param1:Object)
        {
            super(param1);
        }
        
        public var windowTitle:String = "";
        
        public var infoHeaderText:String = "";
        
        public var descriptionText:String = "";
        
        public var invitedPlayersText:String = "";
        
        public var invitesManagementLinkText:String = "";
        
        public var closeBtnLabel:String = "";
        
        public var tableNickText:String = "";
        
        public var tableExpText:String = "";
        
        public var tableExpTT:String = "";
        
        public var tableExpMultiplierText:String = "";
    }
}
