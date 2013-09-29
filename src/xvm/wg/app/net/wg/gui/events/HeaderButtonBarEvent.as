package net.wg.gui.events 
{
    import flash.events.*;
    
    public class HeaderButtonBarEvent extends flash.events.Event
    {
        public function HeaderButtonBarEvent(arg1:String, arg2:int=0)
        {
            super(arg1, true, true);
            this.width = arg2;
            return;
        }

        public override function clone():flash.events.Event
        {
            return new net.wg.gui.events.HeaderButtonBarEvent(type, this.width);
        }

        public static const RESIZE:String="resizeHB";

        public var width:int;
    }
}
