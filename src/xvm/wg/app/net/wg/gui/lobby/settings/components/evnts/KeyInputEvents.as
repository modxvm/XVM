package net.wg.gui.lobby.settings.components.evnts 
{
    import flash.events.*;
    
    public class KeyInputEvents extends flash.events.Event
    {
        public function KeyInputEvents(arg1:String, arg2:Number=NaN, arg3:Boolean=false, arg4:Boolean=false)
        {
            this.keyCode = arg2;
            super(arg1, arg3, arg4);
            return;
        }

        public override function clone():flash.events.Event
        {
            return new net.wg.gui.lobby.settings.components.evnts.KeyInputEvents(type, this.keyCode, bubbles, cancelable);
        }

        public override function toString():String
        {
            return formatToString("KeyInputEvents", "keyCode", "type", "bubbles", "cancelable", "eventPhase");
        }

        public static const CHANGE:String="key_change";

        public static const DISABLE_OVER:String="disable_over";

        public static const DISABLE_OUT:String="disable_out";

        public static const DISABLE_PRESS:String="disable_press";

        public var keyCode:Number;
    }
}
