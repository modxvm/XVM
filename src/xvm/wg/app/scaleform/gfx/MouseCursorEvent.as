package scaleform.gfx 
{
    import flash.events.*;
    
    public final class MouseCursorEvent extends flash.events.Event
    {
        public function MouseCursorEvent()
        {
            super("MouseCursorEvent", false, true);
            return;
        }

        public static const CURSOR_CHANGE:String="mouseCursorChange";

        public var cursor:String="auto";

        public var mouseIdx:uint=0;
    }
}
