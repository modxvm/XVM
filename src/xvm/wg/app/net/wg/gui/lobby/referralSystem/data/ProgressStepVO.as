package net.wg.gui.lobby.referralSystem.data
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    
    public class ProgressStepVO extends DAAPIDataClass
    {
        
        public function ProgressStepVO(param1:Object)
        {
            super(param1);
        }
        
        public var icon:String = "";
        
        public var id:String = "";
    }
}
