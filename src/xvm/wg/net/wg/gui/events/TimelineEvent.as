package net.wg.gui.events 
{
    import flash.events.*;
    
    public class TimelineEvent extends flash.events.Event
    {
        public function TimelineEvent(arg1:String, arg2:Boolean=false, arg3:Boolean=false, arg4:Boolean=false)
        {
            super(arg1, arg3, arg4);
            this.isShow = arg2;
            return;
        }

        public override function clone():flash.events.Event
        {
            return new net.wg.gui.events.TimelineEvent(type, this.isShow, bubbles, cancelable);
        }

        public static const TWEEN_COMPLETE:String="tweenComplete";

        public var isShow:Boolean=false;
    }
}
