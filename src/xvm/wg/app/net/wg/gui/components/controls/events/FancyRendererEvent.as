package net.wg.gui.components.controls.events
{
    import flash.events.Event;
    
    public class FancyRendererEvent extends Event
    {
        
        public function FancyRendererEvent(param1:String, param2:Boolean = false, param3:Boolean = false, param4:String = null)
        {
            this.itemData = param4;
            super(param1,param2,param3);
        }
        
        public static var RENDERER_CLICK:String = "btnClick";
        
        public static var RENDERER_OVER:String = "btnOver";
        
        public var itemData:String = "";
        
        override public function clone() : Event
        {
            return new FancyRendererEvent(type,bubbles,cancelable);
        }
        
        override public function toString() : String
        {
            return formatToString("FancyRendererEvent","type","bubbles","cancelable","eventPhase");
        }
    }
}
