package net.wg.infrastructure.events
{
    import flash.events.Event;
    
    public class FocusChainChangeEvent extends Event
    {
        
        public function FocusChainChangeEvent(param1:String)
        {
            super(param1,true,true);
        }
        
        public static var FOCUS_CHAIN_CHANGE:String = "focusChainChange";
    }
}
