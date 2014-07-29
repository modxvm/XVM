package net.wg.gui.events
{
    import flash.events.Event;
    
    public class ResizableBlockEvent extends Event
    {
        
        public function ResizableBlockEvent(param1:String, param2:Boolean = false, param3:Number = 0)
        {
            super(param1,true,true);
            this.contentWasChanged = param2;
            this.heightDiff = param3;
        }
        
        public static var VALIDATE_SCROLL_BAR:String = "validateScrollBar";
        
        public static var CONTETNT_WAS_CHANGED:String = "contentWasChanged";
        
        public static var CONTENT_IS_READY:String = "contentIsReady";
        
        public static var READY_FOR_ANIMATION:String = "readyForAnimation";
        
        public var contentWasChanged:Boolean = false;
        
        public var heightDiff:Number = 0;
        
        override public function clone() : Event
        {
            return new ResizableBlockEvent(type,this.contentWasChanged,this.heightDiff);
        }
    }
}
