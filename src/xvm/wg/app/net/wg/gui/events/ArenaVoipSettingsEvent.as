package net.wg.gui.events
{
    import flash.events.Event;
    
    public class ArenaVoipSettingsEvent extends Event
    {
        
        public function ArenaVoipSettingsEvent(param1:String, param2:Number)
        {
            super(param1,true,true);
            this.index = param2;
        }
        
        public static var SELECT_USE_COMMON_VOICE_CHAT:String = "selectUseCommonVoiceChat";
        
        public var index:Number = 0;
        
        override public function clone() : Event
        {
            return new ArenaVoipSettingsEvent(type,this.index);
        }
    }
}
