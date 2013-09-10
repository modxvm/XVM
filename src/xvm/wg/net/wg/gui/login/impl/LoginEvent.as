package net.wg.gui.login.impl 
{
    import flash.events.*;
    
    public final class LoginEvent extends flash.events.Event
    {
        public function LoginEvent(arg1:String, arg2:Boolean=false, arg3:Boolean=false)
        {
            super(arg1, arg2, arg3);
            return;
        }

        public override function clone():flash.events.Event
        {
            return new net.wg.gui.login.impl.LoginEvent(type, bubbles, cancelable);
        }

        public static const TOKEN_RESET:String="eventResetToken";
    }
}
