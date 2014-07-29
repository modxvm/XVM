package net.wg.gui.components.common.video.advanced
{
    import flash.events.Event;
    
    public class ProgressBarEvent extends Event
    {
        
        public function ProgressBarEvent(param1:String, param2:Number, param3:Boolean = false, param4:Boolean = false)
        {
            this.position = param2;
            super(param1,param3,param4);
        }
        
        public static var POSITION_UPDATED:String = "positionUpdated";
        
        public var position:Number;
        
        override public function clone() : Event
        {
            return new ProgressBarEvent(type,this.position,bubbles,cancelable);
        }
        
        override public function toString() : String
        {
            return formatToString("ProgressBarEvent","type","bubbles","cancelable","eventPhase");
        }
    }
}
