package net.wg.gui.login.impl 
{
    import flash.display.*;
    
    internal final class LoginUtils extends Object
    {
        public function LoginUtils()
        {
            super();
            return;
        }

        public function initTabIndex(arg1:Array):void
        {
            var loc1:*=0;
            while (loc1 < arg1.length) 
            {
                flash.display.InteractiveObject(arg1[loc1]).tabIndex = loc1 + 1;
                ++loc1;
            }
            return;
        }

        public static function get instance():LoginUtils
        {
            if (ms_instance == null) 
                ms_instance = new LoginUtils();
            return ms_instance;
        }

        
        {
            ms_instance = null;
        }

        internal static var ms_instance:LoginUtils=null;
    }
}
