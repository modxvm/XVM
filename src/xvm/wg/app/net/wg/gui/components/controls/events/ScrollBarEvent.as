package net.wg.gui.components.controls.events
{
   import flash.events.Event;


   public class ScrollBarEvent extends Event
   {
          
      public function ScrollBarEvent(param1:String, param2:Boolean=true, param3:Boolean=false) {
         super(param1,param2,param3);
      }

      public static var ON_MOUSE_WHEEL_INSIDE:String = "on_mouse_wheel_inside";

      override public function clone() : Event {
         return new ScrollBarEvent(type,bubbles,cancelable);
      }

      override public function toString() : String {
         return formatToString("ScrollBarEvent","type","bubbles","cancelable","eventPhase");
      }
   }

}