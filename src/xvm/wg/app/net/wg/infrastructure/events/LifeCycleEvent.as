package net.wg.infrastructure.events
{
    import flash.events.Event;
    
    public class LifeCycleEvent extends Event
    {
        
        public function LifeCycleEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
        {
            super(param1,param2,param3);
        }
        
        public static var ON_BEFORE_POPULATE:String = "onBeforePopulate";
        
        public static var ON_AFTER_POPULATE:String = "onAfterPopulate";
        
        public static var ON_POPULATE:String = ON_AFTER_POPULATE;
        
        public static var ON_BEFORE_DISPOSE:String = "onBefireDispose";
        
        public static var ON_AFTER_DISPOSE:String = "onAfterDispose";
        
        public static var ON_DISPOSE:String = ON_BEFORE_DISPOSE;
        
        override public function clone() : Event
        {
            return new LifeCycleEvent(type,bubbles,cancelable);
        }
    }
}
