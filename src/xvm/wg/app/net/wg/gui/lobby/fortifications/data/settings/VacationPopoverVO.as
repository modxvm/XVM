package net.wg.gui.lobby.fortifications.data.settings
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    
    public class VacationPopoverVO extends DAAPIDataClass
    {
        
        public function VacationPopoverVO(param1:Object)
        {
            super(param1);
        }
        
        public var descriptionText:String = "";
        
        public var vacationStart:String = "";
        
        public var vacationDuration:String = "";
        
        public var ofDays:String = "";
        
        public var applyBtnLabel:String = "";
        
        public var cancelBtnLabel:String = "";
        
        public var isAmericanStyle:Boolean = false;
        
        public var startVacation:Number = 0;
        
        public var endVacation:Number = 0;
        
        override protected function onDispose() : void
        {
            this.descriptionText = null;
            this.vacationStart = null;
            this.vacationDuration = null;
            this.ofDays = null;
            this.applyBtnLabel = null;
            this.cancelBtnLabel = null;
        }
    }
}
