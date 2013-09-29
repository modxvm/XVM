package net.wg.infrastructure.managers.impl 
{
    import net.wg.infrastructure.base.meta.impl.*;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.managers.*;
    
    public class VoiceChatManager extends net.wg.infrastructure.base.meta.impl.VoiceChatManagerMeta implements net.wg.infrastructure.managers.IVoiceChatManager
    {
        public function VoiceChatManager()
        {
            super();
            return;
        }

        public function as_onPlayerSpeak(arg1:uint, arg2:Boolean, arg3:Boolean):void
        {
            var loc1:*=arg2 ? net.wg.infrastructure.events.VoiceChatEvent.START_SPEAKING : net.wg.infrastructure.events.VoiceChatEvent.STOP_SPEAKING;
            dispatchEvent(new net.wg.infrastructure.events.VoiceChatEvent(loc1, arg1, arg3));
            return;
        }
    }
}
