package net.wg.gui.components.crosshairPanel.components.autoloader
{
    import flash.display.MovieClip;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import scaleform.clik.motion.Tween;
    import net.wg.data.constants.generated.AUTOLOADERBOOSTVIEWSOUNDS;
    import net.wg.gui.components.crosshairPanel.CrosshairPanelEvent;
    import fl.motion.easing.Linear;
    import flash.utils.setTimeout;
    import flash.utils.clearTimeout;

    public class BoostIndicatorElement extends MovieClip implements IDisposable
    {

        public static const RECHARGE_BEGIN_FRAME:uint = 7;

        public static const RECHARGE_END_FRAME:uint = 90;

        private static const FADE_IN_FRAME:uint = 1;

        private static const START:uint = 10;

        private static const START_SPAN:uint = 16;

        private static const PROGRESS_QUARTER:uint = 32;

        private static const PROGRESS_QUARTER_SPAN:uint = 38;

        private static const PROGRESS_HALF:uint = 57;

        private static const PROGRESS_HALF_SPAN:uint = 63;

        private static const CHARGE_FRAME:uint = 91;

        private static const CHARGE_MAX_FRAME:uint = 98;

        private static const CHARGE_MAX:uint = 92;

        private static const CHARGE_MAX_SPAN:uint = 99;

        private static const CHARGED_FRAME:uint = 100;

        private static const FADE_OUT_FRAME:uint = 101;

        public var onRechargeComplete:Function = null;

        public var onChargeComplete:Function = null;

        public var onFadeOutComplete:Function = null;

        public var soundsEnabled:Boolean = true;

        private var _durationMSec:Number = 0;

        private var _currentTween:Tween = null;

        private var _prevFrame:uint = 0;

        private var _soundProgress:uint = 10;

        private var _timeOutId:int = -1;

        public function BoostIndicatorElement()
        {
            super();
            gotoAndStop(1);
            addFrameScript(RECHARGE_END_FRAME - 1,this.onRecharged);
            addFrameScript(CHARGE_MAX_FRAME - 1,this.onMaxCharge);
            addFrameScript(CHARGED_FRAME - 1,this.onCharged);
            addFrameScript(totalFrames - 1,this.onFadedOut);
        }

        public final function dispose() : void
        {
            stop();
            addFrameScript(RECHARGE_END_FRAME - 1,null);
            addFrameScript(CHARGE_MAX_FRAME - 1,null);
            addFrameScript(CHARGED_FRAME - 1,null);
            addFrameScript(totalFrames - 1,null);
            this.clearTween();
            this.cancelTasks();
            this._currentTween = null;
            this.onRechargeComplete = null;
            this.onChargeComplete = null;
            this.onFadeOutComplete = null;
        }

        public function set currentFrame(param1:int) : void
        {
            if(param1 < 1 || param1 > 100)
            {
                this._soundProgress = START;
                return;
            }
            gotoAndStop(param1);
            if(this.soundsEnabled && this._prevFrame != param1)
            {
                if(this._soundProgress == START && param1 >= START && param1 <= START_SPAN)
                {
                    this.dispatchSoundEvent(AUTOLOADERBOOSTVIEWSOUNDS.START);
                    this._soundProgress = PROGRESS_QUARTER;
                }
                else if(this._soundProgress == PROGRESS_QUARTER && param1 >= PROGRESS_QUARTER && param1 <= PROGRESS_QUARTER_SPAN)
                {
                    this.dispatchSoundEvent(AUTOLOADERBOOSTVIEWSOUNDS.PROGRESS);
                    this._soundProgress = PROGRESS_HALF;
                }
                else if(this._soundProgress == PROGRESS_HALF && param1 >= PROGRESS_HALF && param1 <= PROGRESS_HALF_SPAN)
                {
                    this.dispatchSoundEvent(AUTOLOADERBOOSTVIEWSOUNDS.PROGRESS);
                    this._soundProgress = CHARGE_MAX;
                }
                else if(this._soundProgress == CHARGE_MAX && param1 >= CHARGE_MAX && param1 <= CHARGE_MAX_SPAN)
                {
                    this.onMaxCharge();
                    this._soundProgress = START;
                }
            }
            this._prevFrame = param1;
        }

        private function dispatchSoundEvent(param1:String) : void
        {
            dispatchEvent(new CrosshairPanelEvent(CrosshairPanelEvent.SOUND,param1));
        }

        public function get remainingDurationMSc() : Number
        {
            if(this._currentTween)
            {
                return this._durationMSec - this._currentTween.position;
            }
            return this._durationMSec;
        }

        public function showCharged(param1:uint = 0) : void
        {
            if(currentFrame > CHARGE_FRAME)
            {
                return;
            }
            this._durationMSec = 0;
            this.clearTween();
            this.cancelTasks();
            if(param1)
            {
                if(param1 >= CHARGED_FRAME)
                {
                    gotoAndStop(CHARGED_FRAME);
                }
                else
                {
                    gotoAndPlay(param1);
                }
            }
            else
            {
                gotoAndPlay(CHARGE_FRAME);
            }
        }

        public function showRecharge(param1:Number) : void
        {
            this._durationMSec = param1;
            this.clearTween();
            this.cancelTasks();
            this._soundProgress = START;
            this._currentTween = new Tween(this._durationMSec,this,{"currentFrame":RECHARGE_END_FRAME},{"ease":Linear.easeNone});
        }

        public function showFadeIn(param1:Number) : void
        {
            this.clearTween();
            this.cancelTasks();
            if(param1 > 0)
            {
                this._timeOutId = setTimeout(gotoAndPlay,param1,FADE_IN_FRAME);
            }
            else
            {
                gotoAndPlay(FADE_IN_FRAME);
            }
        }

        public function showFadeOut() : void
        {
            this.clearTween();
            this.cancelTasks();
            gotoAndPlay(FADE_OUT_FRAME);
        }

        public function hide() : void
        {
            this.clearTween();
            this.cancelTasks();
            this.currentFrame = 1;
        }

        public function cancelTasks() : void
        {
            if(this._timeOutId != -1)
            {
                clearTimeout(this._timeOutId);
                this._timeOutId = -1;
            }
        }

        private function clearTween() : void
        {
            if(this._currentTween)
            {
                this._currentTween.paused = true;
                this._currentTween.dispose();
            }
        }

        private function onRecharged() : void
        {
            stop();
            if(this.onRechargeComplete != null)
            {
                this.onRechargeComplete();
            }
        }

        private function onMaxCharge() : void
        {
            if(this.soundsEnabled && this._soundProgress != START)
            {
                this.dispatchSoundEvent(AUTOLOADERBOOSTVIEWSOUNDS.MAX);
            }
        }

        private function onCharged() : void
        {
            stop();
            if(this.onChargeComplete != null)
            {
                this.onChargeComplete();
            }
        }

        private function onFadedOut() : void
        {
            stop();
            if(this.onFadeOutComplete != null)
            {
                this.onFadeOutComplete();
            }
        }
    }
}
