package scaleform.gfx
{
    import flash.events.MouseEvent;
    
    public final class MouseEventEx extends MouseEvent
    {
        
        public function MouseEventEx(param1:String) {
            super(param1);
        }
        
        public static var LEFT_BUTTON:uint = 0;
        
        public static var RIGHT_BUTTON:uint = 1;
        
        public static var MIDDLE_BUTTON:uint = 2;
        
        public var mouseIdx:uint = 0;
        
        public var nestingIdx:uint = 0;
        
        public var buttonIdx:uint = 0;
    }
}
