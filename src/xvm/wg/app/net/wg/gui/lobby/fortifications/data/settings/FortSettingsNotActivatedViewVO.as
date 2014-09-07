package net.wg.gui.lobby.fortifications.data.settings
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    
    public class FortSettingsNotActivatedViewVO extends DAAPIDataClass
    {
        
        public function FortSettingsNotActivatedViewVO(param1:Object)
        {
            super(param1);
        }
        
        public var description:String = "";
        
        public var conditionTitle:String = "";
        
        public var firstCondition:String = "";
        
        public var secondCondition:String = "";
        
        public var isBtnEnabled:Boolean = false;
        
        public var firstStatus:String = "";
        
        public var secondStatus:String = "";
        
        public var btnToolTipData:String = "";
        
        override protected function onDispose() : void
        {
            this.description = null;
            this.conditionTitle = null;
            this.firstCondition = null;
            this.secondCondition = null;
            this.firstStatus = null;
            this.secondStatus = null;
            this.btnToolTipData = null;
            super.onDispose();
        }
    }
}
