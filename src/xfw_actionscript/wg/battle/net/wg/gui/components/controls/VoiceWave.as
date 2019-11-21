package net.wg.gui.components.controls
{
    import net.wg.infrastructure.base.UIComponentEx;
    import flash.display.MovieClip;

    public class VoiceWave extends UIComponentEx
    {

        private static const INVALIDATE_SPEAKING:String = "invSpeaking";

        private static const LABEL_SHOW:String = "show";

        private static const LABEL_HIDE:String = "hide";

        public var crossX:int;

        public var crossY:int;

        public var mutedClip:MovieClip;

        private var _speak:Boolean = false;

        private var _muted:Boolean = false;

        private var _forcedStop:Boolean;

        private var _speakVisible:Boolean;

        public function VoiceWave()
        {
            super();
        }

        override protected function onDispose() : void
        {
            stop();
            this.mutedClip = null;
            super.onDispose();
        }

        override protected function configUI() : void
        {
            super.configUI();
            var _loc1_:MovieClip = this.mutedClip.cross;
            _loc1_.x = this.crossX;
            _loc1_.y = this.crossY;
        }

        override protected function draw() : void
        {
            if(isInvalid(INVALIDATE_SPEAKING))
            {
                visible = this._speakVisible;
            }
        }

        public function isMuted() : Boolean
        {
            return this._muted;
        }

        public function isSpeak() : Boolean
        {
            return this._speak;
        }

        public function setMuted(param1:Boolean) : void
        {
            if(this._muted == param1)
            {
                return;
            }
            if(param1 && this._speak)
            {
                this.setSpeaking(false,true);
            }
            this.mutedClip.visible = this._muted = param1;
        }

        public function setSpeaking(param1:Boolean, param2:Boolean = false) : void
        {
            this._speakVisible = App.voiceChatMgr.isVOIPEnabledS();
            if(param1 == this._speak || this._muted)
            {
                invalidate(INVALIDATE_SPEAKING);
                return;
            }
            this._forcedStop = param2;
            this._speak = param1;
            if(param2)
            {
                gotoAndStop(1);
            }
            else if(param1)
            {
                gotoAndPlay(LABEL_SHOW);
            }
            else
            {
                gotoAndPlay(LABEL_HIDE);
            }
            invalidate(INVALIDATE_SPEAKING);
        }
    }
}
