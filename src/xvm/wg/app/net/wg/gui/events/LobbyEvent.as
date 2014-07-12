package net.wg.gui.events
{
    import flash.events.Event;
    
    public class LobbyEvent extends Event
    {
        
        public function LobbyEvent(param1:String) {
            super(param1,true,true);
        }
        
        public static var REGISTER_DRAGGING:String = "registerDragging";
        
        public static var UNREGISTER_DRAGGING:String = "unregisterDragging";
        
        override public function clone() : Event {
            return new LobbyEvent(type);
        }
    }
}
