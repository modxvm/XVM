package net.wg.gui.events
{
   import scaleform.clik.events.ComponentEvent;
   import flash.events.Event;


   public class StateManagerEvent extends ComponentEvent
   {
          
      public function StateManagerEvent(param1:String, param2:String, param3:Boolean=false, param4:Boolean=false) {
         this._state = param2;
         super(param1,param3,param4);
      }

      private var _state:String = "";

      override public function clone() : Event {
         return new StateManagerEvent(type,this._state,bubbles,cancelable);
      }

      override public function toString() : String {
         return formatToString("StateManagerEvent","_state","type","bubbles","cancelable","eventPhase");
      }
   }

}