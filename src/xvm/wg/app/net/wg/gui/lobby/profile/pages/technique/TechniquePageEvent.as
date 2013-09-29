package net.wg.gui.lobby.profile.pages.technique 
{
    import flash.events.*;
    
    public class TechniquePageEvent extends flash.events.Event
    {
        public function TechniquePageEvent(arg1:String, arg2:Boolean, arg3:Boolean=false, arg4:Boolean=false)
        {
            this.dataUnderUpdating = arg2;
            super(arg1, arg3, arg4);
            return;
        }

        public override function clone():flash.events.Event
        {
            return new net.wg.gui.lobby.profile.pages.technique.TechniquePageEvent(type, this.dataUnderUpdating, bubbles, cancelable);
        }

        public override function toString():String
        {
            return formatToString("TechniquePageEvent", "type", "bubbles", "cancelable", "eventPhase");
        }

        public static const DATA_STATUS_CHANGED:String="dataStatusChanged";

        public var dataUnderUpdating:Boolean;
    }
}
