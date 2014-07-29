package net.wg.gui.components.common.video
{
    import flash.events.Event;
    
    public class VideoPlayerStatusEvent extends Event
    {
        
        public function VideoPlayerStatusEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
        {
            super(param1,param2,param3);
        }
        
        public static var STATUS_CHANGED:String = "videoPlayerStatusChanged";
        
        public static var ERROR:String = "videoPlayerError";
        
        public var errorCode:String = "";
        
        override public function clone() : Event
        {
            var _loc1_:VideoPlayerStatusEvent = new VideoPlayerStatusEvent(type,bubbles,cancelable);
            _loc1_.errorCode = this.errorCode;
            return _loc1_;
        }
        
        override public function toString() : String
        {
            return formatToString("VideoPlayerEvent","type","bubbles","cancelable","eventPhase");
        }
    }
}
