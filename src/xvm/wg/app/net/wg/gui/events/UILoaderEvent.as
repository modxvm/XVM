package net.wg.gui.events 
{
    import flash.events.*;
    
    public class UILoaderEvent extends flash.events.Event
    {
        public function UILoaderEvent(arg1:String, arg2:Boolean=true, arg3:Boolean=false, arg4:Number=0)
        {
            super(arg1, arg2, arg3);
            this.percent = arg4;
            return;
        }

        public override function clone():flash.events.Event
        {
            return new net.wg.gui.events.UILoaderEvent(type, bubbles, cancelable, this.percent);
        }

        public override function toString():String
        {
            return formatToString("UILoaderEvent", "type", "bubbles", "cancelable", "eventPhase", "percent");
        }

        public static const IOERROR:String="ui io error";

        public static const COMPLETE:String="ui complete";

        public static const PROGRESS:String="ui progress";

        public var percent:Number=0;
    }
}
