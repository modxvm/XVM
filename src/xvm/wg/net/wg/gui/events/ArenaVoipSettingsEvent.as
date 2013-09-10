package net.wg.gui.events 
{
    import flash.events.*;
    
    public class ArenaVoipSettingsEvent extends flash.events.Event
    {
        public function ArenaVoipSettingsEvent(arg1:String, arg2:Number)
        {
            super(arg1, true, true);
            this.index = arg2;
            return;
        }

        public override function clone():flash.events.Event
        {
            return new net.wg.gui.events.ArenaVoipSettingsEvent(type, this.index);
        }

        public static const SELECT_USE_COMMON_VOICE_CHAT:String="selectUseCommonVoiceChat";

        public var index:Number=0;
    }
}
