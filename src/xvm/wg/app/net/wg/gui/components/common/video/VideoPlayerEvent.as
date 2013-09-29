package net.wg.gui.components.common.video 
{
    import flash.events.*;
    
    public class VideoPlayerEvent extends flash.events.Event
    {
        public function VideoPlayerEvent(arg1:String, arg2:Boolean=false, arg3:Boolean=false)
        {
            super(arg1, arg2, arg3);
            return;
        }

        public override function clone():flash.events.Event
        {
            return new net.wg.gui.components.common.video.VideoPlayerEvent(type, bubbles, cancelable);
        }

        public override function toString():String
        {
            return formatToString("VideoPlayerEvent", "type", "bubbles", "cancelable", "eventPhase");
        }

        public static const META_DATA_CHANGED:String="metaDataChanged";

        public static const SUBTITLE_CHANGED:String="subtitleChanged";

        public static const VOLUME_CHANGED:String="volumeChanged";

        public static const SEEK_START:String="seekStart";

        public static const SEEK_COMPLETE:String="seekComplete";

        public static const PLAYBACK_STOPPED:String="playbackStopped";
    }
}
