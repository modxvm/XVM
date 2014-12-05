package net.wg.gui.lobby.fortifications.data.settings
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    
    public class DefenceHourPopoverVO extends DAAPIDataClass
    {
        
        public function DefenceHourPopoverVO(param1:Object)
        {
            this.skipValues = [];
            super(param1);
        }
        
        public var descriptionText:String = "";
        
        public var defenceHourText:String = "";
        
        public var applyBtnLabel:String = "";
        
        public var cancelBtnLabel:String = "";
        
        public var hour:int = -1;
        
        public var isAmericanStyle:Boolean = false;
        
        public var skipValues:Array;
        
        public var isWrongLocalTime:Boolean = false;
        
        override protected function onDispose() : void
        {
            this.descriptionText = null;
            this.defenceHourText = null;
            this.applyBtnLabel = null;
            this.cancelBtnLabel = null;
        }
    }
}
