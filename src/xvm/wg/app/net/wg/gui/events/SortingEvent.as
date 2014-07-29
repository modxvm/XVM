package net.wg.gui.events
{
    import flash.events.Event;
    
    public class SortingEvent extends Event
    {
        
        public function SortingEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
        {
            super(param1,param2,param3);
        }
        
        public static var SORT_DIRECTION_CHANGED:String = "sortDirectionChanged";
        
        public static var SELECTED_DATA_CHANGED:String = "selDataChanged";
    }
}
