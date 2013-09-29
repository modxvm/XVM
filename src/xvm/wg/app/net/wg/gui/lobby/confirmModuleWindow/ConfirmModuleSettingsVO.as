package net.wg.gui.lobby.confirmModuleWindow 
{
    import net.wg.data.daapi.base.*;
    
    public class ConfirmModuleSettingsVO extends net.wg.data.daapi.base.DAAPIDataClass
    {
        public function ConfirmModuleSettingsVO(arg1:Object)
        {
            super(arg1);
            return;
        }

        public var title:String="";

        public var submitBtnLabel:String="";

        public var cancelBtnLabel:String="";
    }
}
