package scaleform.clik.events 
{
    import flash.events.*;
    
    public final class FocusHandlerEvent extends flash.events.Event
    {
        public function FocusHandlerEvent(arg1:String, arg2:Boolean=true, arg3:Boolean=false, arg4:uint=0)
        {
            super(arg1, arg2, arg3);
            this.controllerIdx = arg4;
            return;
        }

        public override function clone():flash.events.Event
        {
            return new scaleform.clik.events.FocusHandlerEvent(type, bubbles, cancelable, this.controllerIdx);
        }

        public override function toString():String
        {
            return formatToString("FocusHandlerEvent", "type", "bubbles", "cancelable", "controllerIdx");
        }

        public static const FOCUS_IN:String="CLIK_focusIn";

        public static const FOCUS_OUT:String="CLIK_focusOut";

        public var controllerIdx:uint=0;
    }
}
