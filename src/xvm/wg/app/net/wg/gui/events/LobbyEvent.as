package net.wg.gui.events
{
   import flash.events.Event;
   
   public class LobbyEvent extends Event
   {
      
      public function LobbyEvent(param1:String) {
         super(param1,true,true);
      }
      
      public static const REGISTER_DRAGGING:String = "registerDragging";
      
      public static const UNREGISTER_DRAGGING:String = "unregisterDragging";
      
      override public function clone() : Event {
         return new LobbyEvent(type);
      }
   }
}
