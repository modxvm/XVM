package net.wg.gui.events
{
    import flash.events.Event;
    
    public class ParamsEvent extends Event
    {
        
        public function ParamsEvent(param1:String, param2:String = "empty")
        {
            super(param1,true,true);
            this.paramsType = param2;
        }
        
        public static var HIGHLIGHT_PARAMS:String = "highlightParams";
        
        public var paramsType:String = null;
        
        override public function clone() : Event
        {
            return new ParamsEvent(type,this.paramsType);
        }
    }
}
