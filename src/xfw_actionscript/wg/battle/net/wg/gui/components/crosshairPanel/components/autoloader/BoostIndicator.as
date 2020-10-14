package net.wg.gui.components.crosshairPanel.components.autoloader
{
    import net.wg.infrastructure.base.SimpleContainer;
    import flash.display.MovieClip;
    import scaleform.clik.motion.Tween;
    import net.wg.data.constants.generated.AUTOLOADERBOOSTVIEWSTATES;

    public class BoostIndicator extends SimpleContainer
    {

        private static const OFFSET_X:uint = 9;

        private static const RECHARGE_ALPHA_START:Number = 0.1;

        private static const RECHARGE_ALPHA_END:Number = 0.8;

        private static const FADE_OUT_DURATION:uint = 280;

        public var left:MovieClip = null;

        public var right:MovieClip = null;

        private var _tweens:Vector.<Tween>;

        private var _leftOriginX:Number;

        private var _rightOriginX:Number;

        private var _leftShiftedX:Number;

        private var _rightShiftedX:Number;

        private var _duration:int;

        private var _currentState:int = -1;

        private var _stateParams:BoostIndicatorStateParamsVO = null;

        private var _isRecharging:Boolean = false;

        private var _isFadingOut:Boolean = false;

        public function BoostIndicator()
        {
            this._tweens = Vector.<Tween>([]);
            super();
            this.left.alpha = this.right.alpha = 0;
            this._leftOriginX = this.left.x;
            this._rightOriginX = this.right.x;
            this._leftShiftedX = this._leftOriginX - OFFSET_X;
            this._rightShiftedX = this._rightOriginX + OFFSET_X;
            this._stateParams = new BoostIndicatorStateParamsVO(this._leftOriginX,this._rightOriginX,this._leftShiftedX,this._rightShiftedX);
        }

        public function get stateParams() : BoostIndicatorStateParamsVO
        {
            var _loc1_:Tween = null;
            this._stateParams.remainingDurationMsec = 0;
            this._stateParams.currentLeftX = this.left.x;
            this._stateParams.currentRightX = this.right.x;
            this._stateParams.currentAlpha = this.left.alpha;
            this._stateParams.currentFrame = this.left.currentFrame;
            this._stateParams.currentState = this._currentState;
            this._stateParams.isRecharging = this._isRecharging;
            this._stateParams.isFadingOut = this._isFadingOut;
            if(this._currentState != AUTOLOADERBOOSTVIEWSTATES.CHARGED && this._tweens.length)
            {
                _loc1_ = this._tweens[0];
                if(_loc1_ && _loc1_.position)
                {
                    if(this._currentState == AUTOLOADERBOOSTVIEWSTATES.RECHARGE)
                    {
                        this._stateParams.remainingDurationMsec = this._duration - _loc1_.position;
                    }
                    else if(this._currentState == AUTOLOADERBOOSTVIEWSTATES.INVISIBLE)
                    {
                        this._stateParams.remainingDurationMsec = FADE_OUT_DURATION - _loc1_.position;
                    }
                }
            }
            return this._stateParams;
        }

        public function autoloaderBoostUpdate(param1:BoostIndicatorStateParamsVO, param2:Number, param3:Boolean = false) : void
        {
            var _loc6_:* = NaN;
            if(!param3 && param1.currentState != AUTOLOADERBOOSTVIEWSTATES.RECHARGE && this._currentState == param1.currentState)
            {
                return;
            }
            if(param3)
            {
                this._isRecharging = false;
            }
            this._stateParams = param1;
            this._duration = this._stateParams.remainingDurationMsec;
            var _loc4_:Tween = null;
            var _loc5_:Tween = null;
            if(param1.currentState == AUTOLOADERBOOSTVIEWSTATES.INVISIBLE && !this._isFadingOut)
            {
                this._currentState = AUTOLOADERBOOSTVIEWSTATES.INVISIBLE;
                this._isRecharging = false;
                this.left.gotoAndStop(1);
                this.right.gotoAndStop(1);
                if(param1.isSideFadeOut)
                {
                    this.clearTweens();
                    _loc6_ = param1.isFadingOut?param1.remainingDurationMsec:FADE_OUT_DURATION;
                    this.left.x = param1.currentLeftX;
                    this.right.x = param1.currentRightX;
                    this.left.alpha = this.right.alpha = param1.currentAlpha;
                    _loc4_ = new Tween(_loc6_,this.left,{
                        "x":this._leftShiftedX,
                        "alpha":0
                    },{"onComplete":this.onFinishFadeOutAnimation});
                    _loc5_ = new Tween(_loc6_,this.right,{
                        "x":this._rightShiftedX,
                        "alpha":0
                    });
                    this._tweens.push(_loc4_);
                    this._tweens.push(_loc5_);
                    this._isFadingOut = true;
                }
                else
                {
                    this.left.alpha = this.right.alpha = 0;
                }
            }
            else if(param1.currentState == AUTOLOADERBOOSTVIEWSTATES.CHARGED)
            {
                this._currentState = AUTOLOADERBOOSTVIEWSTATES.CHARGED;
                this._isRecharging = false;
                this._isFadingOut = false;
                this.clearTweens();
                this.left.x = this._leftOriginX;
                this.right.x = this._rightOriginX;
                this.left.alpha = this.right.alpha = 1;
                if(this._stateParams.currentFrame < this.left.totalFrames)
                {
                    this.left.gotoAndPlay(this._stateParams.currentFrame);
                    this.right.gotoAndPlay(this._stateParams.currentFrame);
                }
                else
                {
                    this.left.gotoAndPlay(this.left.totalFrames - 2);
                    this.right.gotoAndPlay(this.right.totalFrames - 2);
                }
            }
            else if(param1.currentState > 0 && !this._isRecharging)
            {
                this._currentState = AUTOLOADERBOOSTVIEWSTATES.RECHARGE;
                this._isFadingOut = false;
                this.clearTweens();
                this.left.gotoAndStop(1);
                this.right.gotoAndStop(1);
                if(param1.isRecharging)
                {
                    this.left.x = param1.currentLeftX;
                    this.right.x = param1.currentRightX;
                    this.left.alpha = this.right.alpha = param1.currentAlpha;
                }
                else
                {
                    this.left.x = this._leftShiftedX;
                    this.right.x = this._rightShiftedX;
                    this.left.alpha = this.right.alpha = RECHARGE_ALPHA_START;
                }
                _loc4_ = new Tween(this._duration,this.left,{
                    "x":this._leftOriginX,
                    "alpha":RECHARGE_ALPHA_END
                },{"onComplete":this.onFinishRechargeAnimation});
                _loc5_ = new Tween(this._duration,this.right,{
                    "x":this._rightOriginX,
                    "alpha":RECHARGE_ALPHA_END
                });
                this._tweens.push(_loc4_);
                this._tweens.push(_loc5_);
                this._isRecharging = true;
            }
        }

        public function autoloaderBoostUpdateAsPercent(param1:Number, param2:Number) : void
        {
            if(this._isFadingOut)
            {
                return;
            }
            this.clearTweens();
            if(param1 == AUTOLOADERBOOSTVIEWSTATES.CHARGED)
            {
                this._currentState = AUTOLOADERBOOSTVIEWSTATES.CHARGED;
                this.left.x = this._leftOriginX;
                this.right.x = this._rightOriginX;
                this.left.alpha = this.right.alpha = 1;
                this.left.gotoAndPlay(2);
                this.right.gotoAndPlay(2);
            }
            else if(param1 > 0)
            {
                this._currentState = AUTOLOADERBOOSTVIEWSTATES.RECHARGE;
                this.left.x = this._leftShiftedX + (this._leftOriginX - this._leftShiftedX) / 100 * param2;
                this.right.x = this._rightShiftedX + (this._rightOriginX - this._rightShiftedX) / 100 * param2;
                this.left.alpha = this.right.alpha = RECHARGE_ALPHA_START + (RECHARGE_ALPHA_END - RECHARGE_ALPHA_START) / 100 * param2;
                this.left.gotoAndStop(1);
                this.right.gotoAndStop(1);
            }
        }

        override protected function onDispose() : void
        {
            this.clearTweens();
            this._tweens = null;
            this._stateParams = null;
            this.left = null;
            this.right = null;
            super.onDispose();
        }

        private function clearTweens() : void
        {
            var _loc1_:Tween = null;
            var _loc2_:* = 0;
            var _loc3_:* = 0;
            if(this._tweens)
            {
                _loc1_ = null;
                _loc2_ = this._tweens.length;
                _loc3_ = 0;
                while(_loc3_ < _loc2_)
                {
                    _loc1_ = this._tweens[_loc3_];
                    if(_loc1_)
                    {
                        _loc1_.paused = true;
                        _loc1_.dispose();
                    }
                    _loc3_++;
                }
                this._tweens.length = 0;
            }
        }

        private function onFinishRechargeAnimation() : void
        {
            this.stateParams.resetToDefault();
            this._isRecharging = false;
        }

        private function onFinishFadeOutAnimation() : void
        {
            this.stateParams.resetToDefault();
            this._isFadingOut = false;
        }
    }
}
