package scaleform.clik.events 
{
    import flash.events.*;
    import scaleform.clik.ui.*;
    
    public class InputEvent extends flash.events.Event
    {
        public function InputEvent(arg1:String, arg2:scaleform.clik.ui.InputDetails)
        {
            super(arg1, true, true);
            this.details = arg2;
            return;
        }

        public function get handled():Boolean
        {
            return isDefaultPrevented();
        }

        public function set handled(arg1:Boolean):void
        {
            if (arg1) 
                preventDefault();
            return;
        }

        public override function clone():flash.events.Event
        {
            return new scaleform.clik.events.InputEvent(type, this.details);
        }

        public override function toString():String
        {
            return formatToString("InputEvent", "type", "details");
        }

        public static const INPUT:String="input";

        public var details:scaleform.clik.ui.InputDetails;
    }
}
