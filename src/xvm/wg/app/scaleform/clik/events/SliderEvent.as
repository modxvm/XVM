package scaleform.clik.events
{
   import flash.events.Event;


   public class SliderEvent extends Event
   {
          
      public function SliderEvent(param1:String, param2:Boolean=false, param3:Boolean=true, param4:Number=undefined) {
         super(param1,param2,param3);
         this.value = param4;
      }

      public static const FIRST_VALUE_CHANGE:String = "firstValueChange";

      public static const VALUE_CHANGE:String = "valueChange";

      public var value:Number = -1;

      override public function clone() : Event {
         return new SliderEvent(type,bubbles,cancelable,this.value);
      }

      override public function toString() : String {
         return formatToString("SliderEvent","type","bubbles","cancelable","value");
      }
   }

}