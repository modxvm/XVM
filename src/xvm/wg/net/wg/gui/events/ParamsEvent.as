package net.wg.gui.events 
{
    import flash.events.*;
    
    public class ParamsEvent extends flash.events.Event
    {
        public function ParamsEvent(arg1:String, arg2:String="empty")
        {
            super(arg1, true, true);
            this.paramsType = arg2;
            return;
        }

        public override function clone():flash.events.Event
        {
            return new net.wg.gui.events.ParamsEvent(type, this.paramsType);
        }

        public static const HIGHLIGHT_PARAMS:String="highlightParams";

        public var paramsType:String=null;
    }
}
