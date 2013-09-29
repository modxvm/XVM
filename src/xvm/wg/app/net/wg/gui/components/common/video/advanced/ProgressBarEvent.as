package net.wg.gui.components.common.video.advanced 
{
    import flash.events.*;
    
    public class ProgressBarEvent extends flash.events.Event
    {
        public function ProgressBarEvent(arg1:String, arg2:Number, arg3:Boolean=false, arg4:Boolean=false)
        {
            this.position = arg2;
            super(arg1, arg3, arg4);
            return;
        }

        public override function clone():flash.events.Event
        {
            return new net.wg.gui.components.common.video.advanced.ProgressBarEvent(type, this.position, bubbles, cancelable);
        }

        public override function toString():String
        {
            return formatToString("ProgressBarEvent", "type", "bubbles", "cancelable", "eventPhase");
        }

        public static const POSITION_UPDATED:String="positionUpdated";

        public var position:Number;
    }
}
