package net.wg.gui.login.impl.components
{
    import flash.events.Event;
    
    public class CopyrightEvent extends Event
    {
        
        public function CopyrightEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
        {
            super(param1,param2,param3);
        }
        
        public static var TO_LEGAL:String = "toLegal";
        
        override public function clone() : Event
        {
            return new CopyrightEvent(type,bubbles,cancelable);
        }
    }
}
