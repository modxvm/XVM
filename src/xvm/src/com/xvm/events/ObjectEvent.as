package com.xvm.events
{
    import flash.events.Event;

    public class ObjectEvent extends Event
    {
        public var result:Object;

        public function ObjectEvent(type:String, result:Object, bubbles:Boolean=false, cancelable:Boolean=false)
        {
            super(type, bubbles, cancelable);
            this.result = result;
        }

        public override function clone():Event
        {
            return new ObjectEvent(type, result, bubbles, cancelable);
        }
    }

}
