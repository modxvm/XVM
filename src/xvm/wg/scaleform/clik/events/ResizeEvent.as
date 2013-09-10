package scaleform.clik.events 
{
    import flash.events.*;
    
    public class ResizeEvent extends flash.events.Event
    {
        public function ResizeEvent(arg1:String, arg2:Number, arg3:Number)
        {
            super(arg1, false, false);
            this.scaleX = arg2;
            this.scaleY = arg3;
            return;
        }

        public override function toString():String
        {
            return formatToString("ResizeEvent", "type", "scaleX", "scaleY");
        }

        public override function clone():flash.events.Event
        {
            return new scaleform.clik.events.ResizeEvent(type, this.scaleX, this.scaleY);
        }

        public static const RESIZE:String="resize";

        public static const SCOPE_ORIGINALS_UPDATE:String="scopeOriginalsUpdate";

        public var scaleX:Number=1;

        public var scaleY:Number=1;
    }
}
