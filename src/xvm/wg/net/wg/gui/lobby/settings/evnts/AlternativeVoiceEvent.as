package net.wg.gui.lobby.settings.evnts 
{
    import flash.events.*;
    
    public class AlternativeVoiceEvent extends flash.events.Event
    {
        public function AlternativeVoiceEvent(arg1:String, arg2:String="", arg3:Boolean=true, arg4:Boolean=false)
        {
            super(arg1, arg3, arg4);
            this.modeName = arg2;
            return;
        }

        public override function clone():flash.events.Event
        {
            return new net.wg.gui.lobby.settings.evnts.AlternativeVoiceEvent(type, this.modeName, bubbles, cancelable);
        }

        public override function toString():String
        {
            return formatToString("AlternativeVoiceEvent", "type", "modeName", "bubbles", "cancelable", "eventPhase");
        }

        
        {
            ON_TEST_ALTERNATIVE_VOICES = "on_alternative_voices";
        }

        public var modeName:String="";

        public static var ON_TEST_ALTERNATIVE_VOICES:String="on_alternative_voices";
    }
}
