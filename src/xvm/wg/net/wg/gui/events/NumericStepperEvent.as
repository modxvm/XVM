package net.wg.gui.events 
{
    import flash.events.*;
    
    public class NumericStepperEvent extends flash.events.Event
    {
        public function NumericStepperEvent(arg1:String, arg2:Boolean=false, arg3:Boolean=true)
        {
            super(arg1, arg2, arg3);
            return;
        }

        public static const SUBMIT:String="submit";
    }
}
