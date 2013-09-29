package net.wg.gui.prebattle.squad 
{
    public class UserDataFlags extends Object
    {
        public function UserDataFlags()
        {
            super();
            return;
        }

        
        {
            ROSTER_UNDEFINED = 0;
            ROSTER_FRIEND = 1;
            ROSTER_IGNORED = 2;
            ROSTER_VOICE_MUTED = 4;
        }

        public static var ROSTER_UNDEFINED:uint=0;

        public static var ROSTER_FRIEND:uint=1;

        public static var ROSTER_IGNORED:uint=2;

        public static var ROSTER_VOICE_MUTED:uint=4;
    }
}
