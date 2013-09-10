package scaleform.clik.events 
{
    import flash.events.*;
    
    public class SliderEvent extends flash.events.Event
    {
        public function SliderEvent(arg1:String, arg2:Boolean=false, arg3:Boolean=true, arg4:Number=-1)
        {
            super(arg1, arg2, arg3);
            this.value = arg4;
            return;
        }

        public override function clone():flash.events.Event
        {
            return new scaleform.clik.events.SliderEvent(type, bubbles, cancelable, this.value);
        }

        public override function toString():String
        {
            return formatToString("SliderEvent", "type", "bubbles", "cancelable", "value");
        }

        public static const VALUE_CHANGE:String="valueChange";

        public var value:Number=-1;
    }
}
