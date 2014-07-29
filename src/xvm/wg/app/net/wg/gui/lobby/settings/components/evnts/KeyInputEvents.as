package net.wg.gui.lobby.settings.components.evnts
{
    import flash.events.Event;
    
    public class KeyInputEvents extends Event
    {
        
        public function KeyInputEvents(param1:String, param2:Number = undefined, param3:Boolean = false, param4:Boolean = false)
        {
            this.keyCode = param2;
            super(param1,param3,param4);
        }
        
        public static var CHANGE:String = "key_change";
        
        public static var DISABLE_OVER:String = "disable_over";
        
        public static var DISABLE_OUT:String = "disable_out";
        
        public static var DISABLE_PRESS:String = "disable_press";
        
        public var keyCode:Number;
        
        override public function clone() : Event
        {
            return new KeyInputEvents(type,this.keyCode,bubbles,cancelable);
        }
        
        override public function toString() : String
        {
            return formatToString("KeyInputEvents","keyCode","type","bubbles","cancelable","eventPhase");
        }
    }
}
