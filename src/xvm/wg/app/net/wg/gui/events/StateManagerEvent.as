package net.wg.gui.events 
{
    import flash.events.*;
    import scaleform.clik.events.*;
    
    public class StateManagerEvent extends scaleform.clik.events.ComponentEvent
    {
        public function StateManagerEvent(arg1:String, arg2:String, arg3:Boolean=false, arg4:Boolean=false)
        {
            this._state = arg2;
            super(arg1, arg3, arg4);
            return;
        }

        public override function clone():flash.events.Event
        {
            return new net.wg.gui.events.StateManagerEvent(type, this._state, bubbles, cancelable);
        }

        public override function toString():String
        {
            return formatToString("StateManagerEvent", "_state", "type", "bubbles", "cancelable", "eventPhase");
        }

        internal var _state:String="";
    }
}
