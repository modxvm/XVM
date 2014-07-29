package net.wg.data.constants
{
    import flash.ui.MouseCursor;
    
    public class Cursors extends Object
    {
        
        public function Cursors()
        {
            super();
        }
        
        public static var ARROW:String = MouseCursor.ARROW;
        
        public static var AUTO:String = MouseCursor.AUTO;
        
        public static var BUTTON:String = MouseCursor.BUTTON;
        
        public static var HAND:String = MouseCursor.HAND;
        
        public static var IBEAM:String = MouseCursor.IBEAM;
        
        public static var ROTATE:String = "rotate";
        
        public static var RESIZE:String = "resize";
        
        public static var MOVE:String = "move";
        
        public static var DRAG_OPEN:String = "dragopen";
        
        public static var DRAG_CLOSE:String = "dragclose";
        
        public static var NUT:String = "nut";
        
        public static var CUSTOMIZED_CURSORS:Vector.<String> = Vector.<String>([ROTATE,RESIZE,MOVE,DRAG_OPEN,DRAG_CLOSE]);
    }
}
