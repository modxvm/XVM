package net.wg.gui.components.advanced.events
{
    import flash.events.Event;
    
    public class CalendarEvent extends Event
    {
        
        public function CalendarEvent(param1:String, param2:Date, param3:Date, param4:Boolean = false, param5:Boolean = false)
        {
            this.displayDate = param2;
            this.selectedDate = param3;
            super(param1,param4,param5);
        }
        
        public static var DAY_SELECTED:String = "dateSelected";
        
        public static var MONTH_CHANGED:String = "monthChanged";
        
        public var displayDate:Date = null;
        
        public var selectedDate:Date = null;
    }
}
