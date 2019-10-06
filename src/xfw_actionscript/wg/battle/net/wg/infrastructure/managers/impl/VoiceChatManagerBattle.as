package net.wg.infrastructure.managers.impl
{
    import net.wg.infrastructure.managers.IVoiceChatManager;
    import net.wg.infrastructure.events.VoiceChatEvent;

    public class VoiceChatManagerBattle extends VoiceChatManagerBase implements IVoiceChatManager
    {

        public function VoiceChatManagerBattle()
        {
            super();
        }

        override public function as_onPlayerSpeak(param1:Number, param2:Boolean, param3:Boolean) : void
        {
            var _loc4_:String = param2?VoiceChatEvent.START_SPEAKING:VoiceChatEvent.STOP_SPEAKING;
            dispatchEvent(new VoiceChatEvent(_loc4_,param1,param3));
        }
    }
}
