package net.wg.gui.components.common.waiting.events
{
   import flash.events.Event;
   
   public class WaitingChangeVisibilityEvent extends Event
   {
      
      public function WaitingChangeVisibilityEvent(param1:String) {
         super(param1,true,false);
      }
      
      public static const WAITING_SHOWN:String = "onWaitingShown";
      
      public static const WAITING_HIDDEN:String = "onWaitingHidden";
   }
}
