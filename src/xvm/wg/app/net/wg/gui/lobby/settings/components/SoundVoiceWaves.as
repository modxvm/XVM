package net.wg.gui.lobby.settings.components
{
    import scaleform.clik.core.UIComponent;
    import flash.events.Event;
    
    public class SoundVoiceWaves extends UIComponent
    {
        
        public function SoundVoiceWaves()
        {
            super();
        }
        
        private var step:Number = 0;
        
        private var finishFrame:uint;
        
        public function speak(param1:Boolean) : void
        {
            if(param1)
            {
                this.step = 1;
                this.finishFrame = this.totalFrames;
            }
            else
            {
                this.step = -1;
                this.finishFrame = 1;
            }
            if(hasEventListener(Event.ENTER_FRAME))
            {
                this.removeEventListener(Event.ENTER_FRAME,this.anim);
            }
            this.addEventListener(Event.ENTER_FRAME,this.anim);
        }
        
        private function anim(param1:Event) : void
        {
            this.gotoAndStop(this.currentFrame + this.step);
            if(this.currentFrame == this.finishFrame)
            {
                this.removeEventListener(Event.ENTER_FRAME,this.anim);
            }
        }
    }
}
