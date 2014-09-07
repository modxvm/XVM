package net.wg.gui.events
{
    import flash.events.Event;
    
    public class ViewStackContentEvent extends Event
    {
        
        public function ViewStackContentEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
        {
            super(param1,param2,param3);
        }
        
        public static var VIEW_HIDE:String = "viewHide";
    }
}
