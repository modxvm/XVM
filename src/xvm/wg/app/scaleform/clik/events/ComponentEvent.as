package scaleform.clik.events 
{
    import flash.events.*;
    
    public class ComponentEvent extends flash.events.Event
    {
        public function ComponentEvent(arg1:String, arg2:Boolean=false, arg3:Boolean=true)
        {
            super(arg1, arg2, arg3);
            return;
        }

        public static const STATE_CHANGE:String="stateChange";

        public static const SHOW:String="show";

        public static const HIDE:String="hide";
    }
}
