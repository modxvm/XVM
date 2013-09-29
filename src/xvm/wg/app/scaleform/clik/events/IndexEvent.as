package scaleform.clik.events 
{
    import flash.events.*;
    
    public class IndexEvent extends flash.events.Event
    {
        public function IndexEvent(arg1:String, arg2:Boolean=false, arg3:Boolean=true, arg4:int=-1, arg5:int=-1, arg6:Object=null)
        {
            super(arg1, arg2, arg3);
            this.index = arg4;
            this.lastIndex = arg5;
            this.data = arg6;
            return;
        }

        public override function clone():flash.events.Event
        {
            return new scaleform.clik.events.IndexEvent(type, bubbles, cancelable, this.index, this.lastIndex, this.data);
        }

        public override function toString():String
        {
            return formatToString("IndexEvent", "type", "bubbles", "cancelable", "index", "lastIndex", "data");
        }

        public static const INDEX_CHANGE:String="clikIndexChange";

        public var index:int=-1;

        public var lastIndex:int=-1;

        public var data:Object;
    }
}
