package net.wg.gui.events 
{
    import flash.events.*;
    
    public class ModuleInfoEvent extends flash.events.Event
    {
        public function ModuleInfoEvent(arg1:String, arg2:String)
        {
            super(arg1, true, true);
            this.id = arg2;
            return;
        }

        public override function clone():flash.events.Event
        {
            return new net.wg.gui.events.ModuleInfoEvent(type, this.id);
        }

        public static const SHOW_INFO:String="showInfo";

        public var id:String;
    }
}
