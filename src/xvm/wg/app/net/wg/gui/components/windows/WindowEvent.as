package net.wg.gui.components.windows
{
    import flash.events.Event;
    
    public class WindowEvent extends Event
    {
        
        public function WindowEvent(param1:String, param2:Number) {
            super(param1,true,false);
            this.prevValue = param2;
        }
        
        public static var SCALE_X_CHANGED:String = "scaleXChanged";
        
        public static var SCALE_Y_CHANGED:String = "scaleYChanged";
        
        public var prevValue:Number = 0;
    }
}
