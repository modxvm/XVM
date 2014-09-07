package net.wg.gui.lobby.fortifications.data.settings
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    
    public class FortSettingsBlockVO extends DAAPIDataClass
    {
        
        public function FortSettingsBlockVO(param1:Object)
        {
            super(param1);
        }
        
        public var blockBtnEnabled:Boolean = true;
        
        public var blockBtnToolTip:String = "";
        
        public var dayAfterVacation:int = -1;
        
        public var blockCondition:String = "";
        
        public var alertMessage:String = "";
        
        public var blockDescr:String = "";
    }
}
