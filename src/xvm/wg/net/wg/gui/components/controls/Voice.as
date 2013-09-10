package net.wg.gui.components.controls 
{
    import scaleform.clik.core.*;
    
    public class Voice extends scaleform.clik.core.UIComponent
    {
        public function Voice()
        {
            super();
            return;
        }

        protected override function configUI():void
        {
            this.voiceWaveFx.setSpeaking(true, true);
            this.voiceWave.setSpeaking(true, true);
            return;
        }

        public var voiceWaveFx:net.wg.gui.components.controls.VoiceWave;

        public var voiceWave:net.wg.gui.components.controls.VoiceWave;
    }
}
