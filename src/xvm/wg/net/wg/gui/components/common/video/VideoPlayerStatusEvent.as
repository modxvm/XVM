package net.wg.gui.components.common.video 
{
    import flash.events.*;
    
    public class VideoPlayerStatusEvent extends flash.events.Event
    {
        public function VideoPlayerStatusEvent(arg1:String, arg2:Boolean=false, arg3:Boolean=false)
        {
            super(arg1, arg2, arg3);
            return;
        }

        public override function clone():flash.events.Event
        {
            var loc1:*=new net.wg.gui.components.common.video.VideoPlayerStatusEvent(type, bubbles, cancelable);
            loc1.errorCode = this.errorCode;
            return loc1;
        }

        public override function toString():String
        {
            return formatToString("VideoPlayerEvent", "type", "bubbles", "cancelable", "eventPhase");
        }

        public static const STATUS_CHANGED:String="videoPlayerStatusChanged";

        public static const ERROR:String="videoPlayerError";

        public var errorCode:String="";
    }
}
