package net.wg.gui.ny.ev
{
    import flash.events.Event;

    public class NYSliderEv extends Event
    {

        public static const VALUE_CHANGE:String = "NYCraftValueChange";

        public static const SNAP_VALUE_CHANGE:String = "NYSnapChange";

        public static const DRAGGING_CHANGE:String = "DraggingChange";

        public var index:int;

        public function NYSliderEv(param1:String, param2:int, param3:Boolean = false, param4:Boolean = false)
        {
            this.index = param2;
            super(param1,param3,param4);
        }

        override public function clone() : Event
        {
            return new NYSliderEv(type,this.index,bubbles,cancelable);
        }

        override public function toString() : String
        {
            return formatToString("NYSliderEv","index");
        }
    }
}
