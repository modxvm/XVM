package net.wg.gui.events
{
   import flash.events.Event;


   public class NumericStepperEvent extends Event
   {
          
      public function NumericStepperEvent(param1:String, param2:Boolean=false, param3:Boolean=true) {
         super(param1,param2,param3);
      }

      public static const SUBMIT:String = "submit";
   }

}