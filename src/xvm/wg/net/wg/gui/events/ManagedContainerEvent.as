package net.wg.gui.events 
{
    import flash.events.*;
    
    public class ManagedContainerEvent extends flash.events.Event
    {
        public function ManagedContainerEvent(arg1:String, arg2:Boolean=false, arg3:Boolean=false)
        {
            super(arg1, arg2, arg3);
            return;
        }

        public static const CHILD_REMOVED:String="childRemoved";
    }
}
