package net.wg.gui.components.controls 
{
    import flash.display.*;
    import flash.events.*;
    import scaleform.clik.core.*;
    
    public class VoiceWave extends scaleform.clik.core.UIComponent
    {
        public function VoiceWave()
        {
            super();
            return;
        }

        public override function dispose():void
        {
            this.mutedClip = null;
            this.removeEventListener(flash.events.Event.ENTER_FRAME, this.frameHandler);
            super.dispose();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            this.mutedClip.cross.x = this.cross_x;
            this.mutedClip.cross.y = this.cross_y;
            return;
        }

        public function isSpeak():Boolean
        {
            return this._speak;
        }

        public function setSpeaking(arg1:Boolean, arg2:Boolean=false):void
        {
            this._speakVisible = App.voiceChatMgr.isVOIPEnabledS();
            if (arg1 == this._speak || this._muted) 
            {
                return;
            }
            this._farcedStop = arg2;
            this._speak = arg1;
            if (!this.hasEventListener(flash.events.Event.ENTER_FRAME)) 
            {
                this.addEventListener(flash.events.Event.ENTER_FRAME, this.frameHandler);
            }
            invalidate(INVALIDATE_SPEAKING);
            return;
        }

        protected function frameHandler(arg1:flash.events.Event):void
        {
            if (this._speak) 
            {
                this.nextFrame();
                if (this.currentFrame == this.totalFrames) 
                {
                    this.stop();
                    this.removeEventListener(flash.events.Event.ENTER_FRAME, this.frameHandler);
                }
            }
            else 
            {
                this.prevFrame();
                if (this.currentFrame == 1) 
                {
                    this.stop();
                    this.removeEventListener(flash.events.Event.ENTER_FRAME, this.frameHandler);
                }
            }
            if (this._farcedStop) 
            {
                this.gotoAndStop(1);
                this.removeEventListener(flash.events.Event.ENTER_FRAME, this.frameHandler);
            }
            return;
        }

        public function isMuted():Boolean
        {
            return this._muted;
        }

        public function setMuted(arg1:Boolean):void
        {
            if (this._muted == arg1) 
            {
                return;
            }
            if (arg1 && this._speak) 
            {
                this.setSpeaking(false, true);
            }
            var loc1:*;
            this._muted = loc1 = arg1;
            this.mutedClip.visible = loc1;
            return;
        }

        protected override function draw():void
        {
            if (isInvalid(INVALIDATE_SPEAKING)) 
            {
                this.visible = this._speakVisible;
            }
            return;
        }

        internal static const INVALIDATE_SPEAKING:String="invSpeaking";

        public var cross_x:int;

        public var cross_y:int;

        public var mutedClip:flash.display.MovieClip;

        internal var _speak:Boolean=false;

        internal var _muted:Boolean=false;

        internal var _farcedStop:Boolean;

        internal var _speakVisible:Boolean;
    }
}
