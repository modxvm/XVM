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
        
        public var vacationStartText:String = "";
        
        public var vacationDurationText:String = "";
        
        public var ofDaysText:String = "";
        
        public var applyBtnLabel:String = "";
        
        public var cancelBtnLabel:String = "";
        
        public var isAmericanStyle:Boolean = false;
        
        public var startVacation:Number = 0;
        
        public var vacationDuration:int = 0;
        
        override protected function onDispose() : void
        {
            this.descriptionText = null;
            this.vacationStartText = null;
            this.vacationDurationText = null;
            this.ofDaysText = null;
            this.applyBtnLabel = null;
            this.cancelBtnLabel = null;
        }
    }
}
