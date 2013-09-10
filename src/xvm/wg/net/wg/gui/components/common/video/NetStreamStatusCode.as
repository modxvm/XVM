package net.wg.gui.components.common.video 
{
    public class NetStreamStatusCode extends Object
    {
        public function NetStreamStatusCode()
        {
            super();
            return;
        }

        
        {
            START = "NetStream.Play.Start";
            STOP = "NetStream.Play.Stop";
            NOT_FOUND = "NetStream.Play.StreamNotFound";
            SEEK_NOTIFY = "NetStream.Seek.Notify";
        }

        public static var START:String="NetStream.Play.Start";

        public static var STOP:String="NetStream.Play.Stop";

        public static var NOT_FOUND:String="NetStream.Play.StreamNotFound";

        public static var SEEK_NOTIFY:String="NetStream.Seek.Notify";
    }
}
