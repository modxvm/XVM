package net.wg.gui.lobby.settings.evnts
{
    import flash.events.Event;
    
    public class AlternativeVoiceEvent extends Event
    {
        
        public function AlternativeVoiceEvent(param1:String, param2:String = "", param3:Boolean = true, param4:Boolean = false)
        {
            super(param1,param3,param4);
            this.modeName = param2;
        }
        
        public static var ON_TEST_ALTERNATIVE_VOICES:String = "on_alternative_voices";
        
        public var modeName:String = "";
        
        override public function clone() : Event
        {
            return new AlternativeVoiceEvent(type,this.modeName,bubbles,cancelable);
        }
        
        override public function toString() : String
        {
            return formatToString("AlternativeVoiceEvent","type","modeName","bubbles","cancelable","eventPhase");
        }
    }
}
