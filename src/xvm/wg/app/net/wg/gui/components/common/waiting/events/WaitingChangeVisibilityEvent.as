package net.wg.gui.components.common.waiting.events
{
    import flash.events.Event;
    
    public class WaitingChangeVisibilityEvent extends Event
    {
        
        public function WaitingChangeVisibilityEvent(param1:String) {
            super(param1,true,false);
        }
        
        public static var WAITING_SHOWN:String = "onWaitingShown";
        
        public static var WAITING_HIDDEN:String = "onWaitingHidden";
    }
}
