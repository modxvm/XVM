package net.wg.gui.prebattle.company 
{
    import flash.events.*;
    
    public class CompanyEvent extends flash.events.Event
    {
        public function CompanyEvent(arg1:String, arg2:Boolean=true, arg3:Boolean=false)
        {
            super(arg1, arg2, arg3);
            return;
        }

        public static const SELECTED_ITEM:String="selectedItem";

        public static const DROP_LIST_CLICK:String="listClick";

        public var prbID:int;

        public var isSelected:Boolean;
    }
}
