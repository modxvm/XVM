package net.wg.data.constants 
{
    import __AS3__.vec.*;
    
    public class Directions extends Object
    {
        public function Directions()
        {
            super();
            return;
        }

        public static const TOP:String="T";

        public static const BOTTOM:String="B";

        public static const RIGHT:String="R";

        public static const LEFT:String="L";

        public static const LAYOUT_DIRECTIONS:__AS3__.vec.Vector.<String>=Vector.<String>([TOP, BOTTOM, RIGHT, LEFT]);
    }
}
