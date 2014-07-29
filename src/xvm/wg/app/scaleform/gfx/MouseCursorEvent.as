package scaleform.gfx
{
    import flash.events.Event;
    
    public final class MouseCursorEvent extends Event
    {
        
        public function MouseCursorEvent()
        {
            super("MouseCursorEvent",false,true);
        }
        
        public static var CURSOR_CHANGE:String = "mouseCursorChange";
        
        public var cursor:String = "auto";
        
        public var mouseIdx:uint = 0;
    }
}
