package net.wg.gui.lobby.store 
{
    public final class STORE_STATUS_COLOR extends Object
    {
        public function STORE_STATUS_COLOR()
        {
            super();
            return;
        }

        public static function getColor(arg1:String):uint
        {
            var loc1:*={"critical":CRITICAL, "warning":WARNING, "info":INFO};
            if (App.instance) 
            {
                App.utils.asserter.assert(loc1.hasOwnProperty(arg1), "unknown status for color: " + arg1);
                return loc1[arg1];
            }
            DebugUtils.LOG_WARNING("App is not available. 0x0 color returned.");
            return 0;
        }

        public static const CRITICAL:uint=16711680;

        public static const WARNING:uint=13814699;

        public static const INFO:uint=4945434;
    }
}
