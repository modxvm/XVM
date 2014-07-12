package net.wg.gui.components.controls
{
    import scaleform.clik.core.UIComponent;
    
    public class Voice extends UIComponent
    {
        
        public function Voice() {
            super();
        }
        
        public var voiceWaveFx:VoiceWave;
        
        public var voiceWave:VoiceWave;
        
        override protected function onDispose() : void {
            this.voiceWaveFx.dispose();
            this.voiceWaveFx = null;
            this.voiceWave.dispose();
            this.voiceWave = null;
            super.onDispose();
        }
        
        override protected function configUI() : void {
            this.voiceWaveFx.setSpeaking(true,true);
            this.voiceWave.setSpeaking(true,true);
        }
    }
}
