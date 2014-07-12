package net.wg.gui.login.impl
{
    public class ErrorStates extends Object
    {
        
        public function ErrorStates() {
            super();
        }
        
        public static var NONE:int = 0;
        
        public static var LOGIN_INVALID:int = 1;
        
        public static var PASSWORD_INVALID:int = 2;
        
        public static var LOGIN_PASSWORD_INVALID:int;
    }
}
