package net.wg.gui.prebattle.company
{
    import flash.events.Event;
    
    public class CompanyEvent extends Event
    {
        
        public function CompanyEvent(param1:String, param2:Boolean = true, param3:Boolean = false) {
            super(param1,param2,param3);
        }
        
        public static var SELECTED_ITEM:String = "selectedItem";
        
        public static var DROP_LIST_CLICK:String = "listClick";
        
        public var prbID:int;
        
        public var isSelected:Boolean;
    }
}
