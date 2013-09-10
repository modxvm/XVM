package net.wg.gui.lobby.settings.components 
{
    import flash.events.*;
    import scaleform.clik.core.*;
    
    public class SoundVoiceWaves extends scaleform.clik.core.UIComponent
    {
        public function SoundVoiceWaves()
        {
            super();
            return;
        }

        public function speak(arg1:Boolean):void
        {
            if (arg1) 
            {
                this.step = 1;
                this.finishFrame = this.totalFrames;
            }
            else 
            {
                this.step = -1;
                this.finishFrame = 1;
            }
            if (hasEventListener(flash.events.Event.ENTER_FRAME)) 
                this.removeEventListener(flash.events.Event.ENTER_FRAME, this.anim);
            this.addEventListener(flash.events.Event.ENTER_FRAME, this.anim);
            return;
        }

        internal function anim(arg1:flash.events.Event):void
        {
            this.gotoAndStop(this.currentFrame + this.step);
            if (this.currentFrame == this.finishFrame) 
                this.removeEventListener(flash.events.Event.ENTER_FRAME, this.anim);
            return;
        }

        internal var step:Number=0;

        internal var finishFrame:uint;
    }
}
