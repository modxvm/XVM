package net.wg.gui.events
{
    import flash.events.Event;
    
    public class TimelineEvent extends Event
    {
        
        public function TimelineEvent(param1:String, param2:Boolean = false, param3:Boolean = false, param4:Boolean = false)
        {
            super(param1,param3,param4);
            this.isShow = param2;
        }
        
        public static var TWEEN_COMPLETE:String = "tweenComplete";
        
        public var isShow:Boolean = false;
        
        override public function clone() : Event
        {
            return new TimelineEvent(type,this.isShow,bubbles,cancelable);
        }
    }
}
