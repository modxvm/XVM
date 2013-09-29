package net.wg.infrastructure.base.meta.impl 
{
    import net.wg.data.constants.*;
    import net.wg.infrastructure.base.*;
    
    public class VoiceChatManagerMeta extends net.wg.infrastructure.base.BaseDAAPIModule
    {
        public function VoiceChatManagerMeta()
        {
            super();
            return;
        }

        public function isPlayerSpeakingS(arg1:uint):Boolean
        {
            App.utils.asserter.assertNotNull(this.isPlayerSpeaking, "isPlayerSpeaking" + net.wg.data.constants.Errors.CANT_NULL);
            return this.isPlayerSpeaking(arg1);
        }

        public function isVivoxS():Boolean
        {
            App.utils.asserter.assertNotNull(this.isVivox, "isVivox" + net.wg.data.constants.Errors.CANT_NULL);
            return this.isVivox();
        }

        public function isYYS():Boolean
        {
            App.utils.asserter.assertNotNull(this.isYY, "isYY" + net.wg.data.constants.Errors.CANT_NULL);
            return this.isYY();
        }

        public function isVOIPEnabledS():Boolean
        {
            App.utils.asserter.assertNotNull(this.isVOIPEnabled, "isVOIPEnabled" + net.wg.data.constants.Errors.CANT_NULL);
            return this.isVOIPEnabled();
        }

        public var isPlayerSpeaking:Function=null;

        public var isVivox:Function=null;

        public var isYY:Function=null;

        public var isVOIPEnabled:Function=null;
    }
}
