package scaleform.clik.events
{
    import flash.events.Event;
    
    public class ComponentEvent extends Event
    {
        
        public function ComponentEvent(param1:String, param2:Boolean = false, param3:Boolean = true) {
            super(param1,param2,param3);
        }
        
        public static var STATE_CHANGE:String = "stateChange";
        
        public static var SHOW:String = "show";
        
        public static var HIDE:String = "hide";
    }
}
