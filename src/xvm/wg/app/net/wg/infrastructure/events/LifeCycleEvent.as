package net.wg.infrastructure.events 
{
    import flash.events.*;
    
    public class LifeCycleEvent extends flash.events.Event
    {
        public function LifeCycleEvent(arg1:String, arg2:Boolean=false, arg3:Boolean=false)
        {
            super(arg1, arg2, arg3);
            return;
        }

        public override function clone():flash.events.Event
        {
            return new net.wg.infrastructure.events.LifeCycleEvent(type, bubbles, cancelable);
        }

        public static const ON_BEFORE_POPULATE:String="onBeforePopulate";

        public static const ON_AFTER_POPULATE:String="onAfterPopulate";

        public static const ON_POPULATE:String=ON_AFTER_POPULATE;

        public static const ON_BEFORE_DISPOSE:String="onBefireDispose";

        public static const ON_AFTER_DISPOSE:String="onAfterDispose";

        public static const ON_DISPOSE:String=ON_BEFORE_DISPOSE;
    }
}
