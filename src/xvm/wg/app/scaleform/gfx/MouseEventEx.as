package scaleform.gfx 
{
    import flash.events.*;
    
    public final class MouseEventEx extends flash.events.MouseEvent
    {
        public function MouseEventEx(arg1:String)
        {
            super(arg1);
            return;
        }

        public static const LEFT_BUTTON:uint=0;

        public static const RIGHT_BUTTON:uint=1;

        public static const MIDDLE_BUTTON:uint=2;

        public var mouseIdx:uint=0;

        public var nestingIdx:uint=0;

        public var buttonIdx:uint=0;
    }
}
