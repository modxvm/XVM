package net.wg.gui.events
{
   import flash.events.Event;
   
   public class ManagedContainerEvent extends Event
   {
      
      public function ManagedContainerEvent(param1:String, param2:Boolean = false, param3:Boolean = false) {
         super(param1,param2,param3);
      }
      
      public static const CHILD_REMOVED:String = "childRemoved";
   }
}
