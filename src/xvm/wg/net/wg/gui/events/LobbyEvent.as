package net.wg.gui.events 
{
    import flash.events.*;
    
    public class LobbyEvent extends flash.events.Event
    {
        public function LobbyEvent(arg1:String)
        {
            super(arg1, true, true);
            return;
        }

        public override function clone():flash.events.Event
        {
            return new net.wg.gui.events.LobbyEvent(type);
        }

        public static const REGISTER_DRAGGING:String="registerDragging";

        public static const UNREGISTER_DRAGGING:String="unregisterDragging";
    }
}
