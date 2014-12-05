package net.wg.gui.lobby.fortifications.data
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    
    public class PeriodDefenceVO extends DAAPIDataClass
    {
        
        public function PeriodDefenceVO(param1:Object)
        {
            this.skipValues = [];
            super(param1);
        }
        
        public var windowLbl:String = "";
        
        public var headerLbl:String = "";
        
        public var peripheryLbl:String = "";
        
        public var peripheryDescr:String = "";
        
        public var hourDefenceLbl:String = "";
        
        public var hourDefenceDescr:String = "";
        
        public var holidayLbl:String = "";
        
        public var holidayDescr:String = "";
        
        public var acceptBtn:String = "";
        
        public var cancelBtn:String = "";
        
        public var peripheryData:Array = null;
        
        public var peripherySelectedID:int = -1;
        
        public var holidaySelectedID:int = -1;
        
        public var holidayData:Array = null;
        
        public var hour:int = -1;
        
        public var isTwelveHoursFormat:Boolean = false;
        
        public var skipValues:Array;
        
        public var isWrongLocalTime:Boolean = false;
    }
}
