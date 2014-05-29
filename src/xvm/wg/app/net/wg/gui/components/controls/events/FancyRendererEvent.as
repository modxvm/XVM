package net.wg.gui.components.controls.events
{
   import flash.events.Event;


   public class FancyRendererEvent extends Event
   {
          
      public function FancyRendererEvent(param1:String, param2:Boolean=false, param3:Boolean=false) {
         super(param1,param2,param3);
      }

      public static const RENDERER_CLICK:String = "btnClick";

      override public function clone() : Event {
         return new FancyRendererEvent(type,bubbles,cancelable);
      }

      override public function toString() : String {
         return formatToString("FancyRendererEvent","type","bubbles","cancelable","eventPhase");
      }
   }

}