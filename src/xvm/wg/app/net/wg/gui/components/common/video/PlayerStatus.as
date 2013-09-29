package net.wg.gui.components.common.video 
{
    public class PlayerStatus extends Object
    {
        public function PlayerStatus()
        {
            super();
            return;
        }

        
        {
            STOP = 0;
            LOADING = 1;
            PLAYING = 2;
            PAUSE = 3;
        }

        public static var STOP:uint=0;

        public static var LOADING:uint=1;

        public static var PLAYING:uint=2;

        public static var PAUSE:uint=3;
    }
}
