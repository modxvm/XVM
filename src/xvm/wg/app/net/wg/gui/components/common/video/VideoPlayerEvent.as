package net.wg.gui.components.common.video
{
    import flash.events.Event;
    
    public class VideoPlayerEvent extends Event
    {
        
        public function VideoPlayerEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
        {
            super(param1,param2,param3);
        }
        
        public static var META_DATA_CHANGED:String = "metaDataChanged";
        
        public static var SUBTITLE_CHANGED:String = "subtitleChanged";
        
        public static var VOLUME_CHANGED:String = "volumeChanged";
        
        public static var SEEK_START:String = "seekStart";
        
        public static var SEEK_COMPLETE:String = "seekComplete";
        
        public static var PLAYBACK_STOPPED:String = "playbackStopped";
        
        override public function clone() : Event
        {
            return new VideoPlayerEvent(type,bubbles,cancelable);
        }
        
        override public function toString() : String
        {
            return formatToString("VideoPlayerEvent","type","bubbles","cancelable","eventPhase");
        }
    }
}
