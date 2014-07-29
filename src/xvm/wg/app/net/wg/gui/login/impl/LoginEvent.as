package net.wg.gui.login.impl
{
    import flash.events.Event;
    
    public final class LoginEvent extends Event
    {
        
        public function LoginEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
        {
            super(param1,param2,param3);
        }
        
        public static var TOKEN_RESET:String = "eventResetToken";
        
        override public function clone() : Event
        {
            return new LoginEvent(type,bubbles,cancelable);
        }
    }
}
