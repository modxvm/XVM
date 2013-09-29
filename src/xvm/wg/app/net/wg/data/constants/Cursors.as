package net.wg.data.constants 
{
    import __AS3__.vec.*;
    import flash.ui.*;
    
    public class Cursors extends Object
    {
        public function Cursors()
        {
            super();
            return;
        }

        public static const ARROW:String=flash.ui.MouseCursor.ARROW;

        public static const AUTO:String=flash.ui.MouseCursor.AUTO;

        public static const BUTTON:String=flash.ui.MouseCursor.BUTTON;

        public static const HAND:String=flash.ui.MouseCursor.HAND;

        public static const IBEAM:String=flash.ui.MouseCursor.IBEAM;

        public static const ROTATE:String="rotate";

        public static const RESIZE:String="resize";

        public static const MOVE:String="move";

        public static const DRAG_OPEN:String="dragopen";

        public static const DRAG_CLOSE:String="dragclose";

        public static const CUSTOMIZED_CURSORS:__AS3__.vec.Vector.<String>=Vector.<String>([ROTATE, RESIZE, MOVE, DRAG_OPEN, DRAG_CLOSE]);
    }
}
