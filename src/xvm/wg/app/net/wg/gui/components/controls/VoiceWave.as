package net.wg.gui.components.controls
{
    import scaleform.clik.core.UIComponent;
    import flash.display.MovieClip;
    import flash.events.Event;
    
    public class VoiceWave extends UIComponent
    {
        
        public function VoiceWave() {
            super();
        }
        
        private static var INVALIDATE_SPEAKING:String = "invSpeaking";
        
        public var cross_x:int;
        
        public var cross_y:int;
        
        public var mutedClip:MovieClip;
        
        private var _speak:Boolean = false;
        
        private var _muted:Boolean = false;
        
        private var _farcedStop:Boolean;
        
        private var _speakVisible:Boolean;
        
        override protected function onDispose() : void {
            this.mutedClip = null;
            removeEventListener(Event.ENTER_FRAME,this.frameHandler);
            super.onDispose();
        }
        
        override protected function configUI() : void {
            super.configUI();
            this.mutedClip.cross.x = this.cross_x;
            this.mutedClip.cross.y = this.cross_y;
        }
        
        public function isSpeak() : Boolean {
            return this._speak;
        }
        
        public function setSpeaking(param1:Boolean, param2:Boolean = false) : void {
            this._speakVisible = App.voiceChatMgr.isVOIPEnabledS();
            if(param1 == this._speak || (this._muted))
            {
                invalidate(INVALIDATE_SPEAKING);
                return;
            }
            this._farcedStop = param2;
            this._speak = param1;
            addEventListener(Event.ENTER_FRAME,this.frameHandler);
            invalidate(INVALIDATE_SPEAKING);
        }
        
        protected function frameHandler(param1:Event) : void {
            if(this._speak)
            {
                this.nextFrame();
                if(this.currentFrame == this.totalFrames)
                {
                    this.stop();
                    this.removeEventListener(Event.ENTER_FRAME,this.frameHandler);
                }
            }
            else
            {
                this.prevFrame();
                if(this.currentFrame == 1)
                {
                    this.stop();
                    this.removeEventListener(Event.ENTER_FRAME,this.frameHandler);
                }
            }
            if(this._farcedStop)
            {
                this.gotoAndStop(1);
                this.removeEventListener(Event.ENTER_FRAME,this.frameHandler);
            }
        }
        
        public function isMuted() : Boolean {
            return this._muted;
        }
        
        public function setMuted(param1:Boolean) : void {
            if(this._muted == param1)
            {
                return;
            }
            if((param1) && (this._speak))
            {
                this.setSpeaking(false,true);
            }
            this.mutedClip.visible = this._muted = param1;
        }
        
        override protected function draw() : void {
            if(isInvalid(INVALIDATE_SPEAKING))
            {
                this.visible = this._speakVisible;
            }
        }
    }
}
