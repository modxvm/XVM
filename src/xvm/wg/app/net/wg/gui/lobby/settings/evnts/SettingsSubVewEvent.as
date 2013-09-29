package net.wg.gui.lobby.settings.evnts 
{
    import flash.events.*;
    
    public class SettingsSubVewEvent extends flash.events.Event
    {
        public function SettingsSubVewEvent(arg1:String, arg2:String, arg3:String="", arg4:*=null, arg5:String="", arg6:Boolean=false, arg7:Boolean=false)
        {
            super(arg1, arg6, arg7);
            this.subViewId = arg2;
            this.controlId = arg3;
            this.alternative = arg5;
            this.controlValue = arg4;
            return;
        }

        public override function clone():flash.events.Event
        {
            return new net.wg.gui.lobby.settings.evnts.SettingsSubVewEvent(type, this.subViewId, this.controlId, this.controlValue, this.alternative, bubbles, cancelable);
        }

        public override function toString():String
        {
            return formatToString("SettingsSubVewEvent", "type", "subViewId", "controlId", "controlValue", "alternative", "bubbles", "cancelable", "eventPhase");
        }

        
        {
            ON_CONTROL_CHANGE = "on_control_changed";
        }

        public var subViewId:String;

        public var controlId:String;

        public var alternative:String;

        public var controlValue:*;

        public static var ON_CONTROL_CHANGE:String="on_control_changed";
    }
}
