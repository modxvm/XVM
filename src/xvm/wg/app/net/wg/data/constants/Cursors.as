package net.wg.data.constants
{
   import __AS3__.vec.Vector;
   import flash.ui.MouseCursor;


   public class Cursors extends Object
   {
          
      public function Cursors() {
         super();
      }

      public static const ARROW:String = MouseCursor.ARROW;

      public static const AUTO:String = MouseCursor.AUTO;

      public static const BUTTON:String = MouseCursor.BUTTON;

      public static const HAND:String = MouseCursor.HAND;

      public static const IBEAM:String = MouseCursor.IBEAM;

      public static const ROTATE:String = "rotate";

      public static const RESIZE:String = "resize";

      public static const MOVE:String = "move";

      public static const DRAG_OPEN:String = "dragopen";

      public static const DRAG_CLOSE:String = "dragclose";

      public static const CUSTOMIZED_CURSORS:Vector.<String> = Vector.<String>([ROTATE,RESIZE,MOVE,DRAG_OPEN,DRAG_CLOSE]);
   }

}