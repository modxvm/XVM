package net.wg.gui.components.crosshairPanel.components.autoloader
{
    import net.wg.infrastructure.base.SimpleContainer;
    import flash.display.MovieClip;

    public class AutoloaderShellsCassette extends SimpleContainer
    {

        private static const GUN_RELOADING_COMPLETE_STATE:int = 1;

        private static const RELOADING_FRAMES:int = 100;

        private static const AUTOLOADING_START_FRAME:int = 14;

        private static const AUTOLOADING_FRAMES:int = 83;

        private static const STATUS_RELOAD_IDLE_STATE:int = 1;

        private static const STATUS_RELOAD_COMPLETE_STATE:int = 2;

        private static const SHELL_STATE_COMEIN:String = "comeIn";

        private static const SHELL_STATE_READY:String = "ready";

        private static const SHELL_STATE_RELOADING:String = "reloading";

        private static const SHELL_STATE_ON_READY:String = "onReady";

        private static const SHELL_STATE_CLEAR:String = "clear";

        private static const TIMER_STATE_INVALID:String = "TIMER_STATE_INVALID";

        private static const TIMER_COMPONENT_NAME:String = "timer";

        private static const IDLE_STATE:int = 0;

        public var shell_1:MovieClip = null;

        public var shell_2:MovieClip = null;

        public var shell_3:MovieClip = null;

        public var shell_4:MovieClip = null;

        public var shell_5:MovieClip = null;

        public var shell_6:MovieClip = null;

        public var shell_7:MovieClip = null;

        public var shell_8:MovieClip = null;

        public var statusMc:MovieClip = null;

        public var background:MovieClip = null;

        public var backgroundCritical:MovieClip = null;

        public var timerMc:MovieClip = null;

        private var timer:AutoloaderTimer = null;

        private var _totalAmmo:int = -1;

        private var _currentAmmo:int = -1;

        private var _isAnimationInProgress:Boolean = false;

        private var _isAutoloadInProgress:Boolean = false;

        private var _isCritical:Boolean = false;

        private var _shells:Vector.<MovieClip> = null;

        private var _lastShell:MovieClip = null;

        private var _lastLoadedShell:MovieClip = null;

        private var _currentReloadingPercent:Number = -1;

        private var _currentAutoloadProgress:Number = -1;

        public function AutoloaderShellsCassette()
        {
            super();
            this._shells = new <MovieClip>[this.shell_1,this.shell_2,this.shell_3,this.shell_4,this.shell_5,this.shell_6,this.shell_7,this.shell_8];
            this.timer = this.timerMc.getChildByName(TIMER_COMPONENT_NAME) as AutoloaderTimer;
            this.backgroundCritical.visible = this._isCritical;
        }

        override protected function onDispose() : void
        {
            this.shell_1 = null;
            this.shell_2 = null;
            this.shell_3 = null;
            this.shell_4 = null;
            this.shell_5 = null;
            this.shell_6 = null;
            this.shell_7 = null;
            this.shell_8 = null;
            this.background = null;
            this.backgroundCritical = null;
            this.timerMc = null;
            this.statusMc = null;
            this._lastShell = null;
            this._lastLoadedShell = null;
            this._shells.splice(0,this._shells.length);
            this._shells = null;
            this.timer.dispose();
            this.timer = null;
            super.onDispose();
        }

        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(TIMER_STATE_INVALID))
            {
                this.timer.updateTimerColor(this._isAnimationInProgress,this._isCritical,this._isAutoloadInProgress);
            }
        }

        public function autoloadProgress(param1:Number, param2:Number, param3:Boolean) : void
        {
            if(!this._isAnimationInProgress)
            {
                if(this._lastLoadedShell)
                {
                    if(param1 != this._currentAutoloadProgress)
                    {
                        this._currentAutoloadProgress = param1;
                        if(!this._isAutoloadInProgress)
                        {
                            this._isAutoloadInProgress = true;
                            invalidate(TIMER_STATE_INVALID);
                        }
                        this._lastLoadedShell.gotoAndStop(AUTOLOADING_START_FRAME + param1 * AUTOLOADING_FRAMES);
                    }
                }
            }
            this.timer.updateTimer(param2,param3);
        }

        public function reloadingPercent(param1:Number, param2:Boolean) : void
        {
            this._currentReloadingPercent = param1;
            if(param1 < GUN_RELOADING_COMPLETE_STATE)
            {
                this.reloadingInProgress(param1);
            }
            else
            {
                this.reloadingComplete(param2);
            }
        }

        public function updateCritical(param1:Boolean) : void
        {
            this._isCritical = param1;
            this.backgroundCritical.visible = this._isCritical;
            this.background.visible = !this._isCritical;
            invalidate(TIMER_STATE_INVALID);
        }

        private function updateTotalAmmoState() : void
        {
            var _loc1_:int = this._shells.length;
            var _loc2_:* = 0;
            while(_loc2_ < _loc1_)
            {
                this._shells[_loc2_].visible = _loc2_ < this._totalAmmo;
                _loc2_++;
            }
            var _loc3_:int = this._totalAmmo - 1;
            this._lastShell = this._shells[_loc3_];
            this.background.gotoAndStop(_loc3_);
            this.backgroundCritical.gotoAndStop(_loc3_);
            this.timerMc.gotoAndStop(_loc3_);
        }

        private function updateCurrentAmmoStates(param1:int) : void
        {
            var _loc3_:String = null;
            var _loc4_:MovieClip = null;
            var _loc2_:* = 0;
            while(_loc2_ < this._totalAmmo)
            {
                _loc3_ = _loc2_ < param1?SHELL_STATE_READY:SHELL_STATE_CLEAR;
                _loc4_ = this._shells[_loc2_];
                if(_loc4_.currentLabel == SHELL_STATE_RELOADING && _loc2_ < param1)
                {
                    _loc4_.gotoAndPlay(SHELL_STATE_ON_READY);
                }
                else
                {
                    _loc4_.gotoAndStop(_loc3_);
                }
                _loc2_++;
            }
            this._isAutoloadInProgress = false;
            invalidate(TIMER_STATE_INVALID);
            this._lastLoadedShell = this._shells[this._currentAmmo];
        }

        private function reloadingComplete(param1:Boolean) : void
        {
            var _loc2_:Boolean = this._isAnimationInProgress;
            this._isAnimationInProgress = false;
            invalidate(TIMER_STATE_INVALID);
            gotoAndStop(IDLE_STATE);
            this.updateCurrentAmmoStates(this._currentAmmo);
            if(param1 || !param1 && !_loc2_)
            {
                this.statusMc.gotoAndStop(STATUS_RELOAD_IDLE_STATE);
            }
            else
            {
                this.statusMc.gotoAndPlay(STATUS_RELOAD_COMPLETE_STATE);
            }
            if(this._lastShell && _loc2_)
            {
                this._lastShell.gotoAndPlay(SHELL_STATE_COMEIN);
            }
        }

        private function reloadingInProgress(param1:Number) : void
        {
            if(!this._isAnimationInProgress)
            {
                this._isAnimationInProgress = true;
                invalidate(TIMER_STATE_INVALID);
            }
            gotoAndStop(param1 * RELOADING_FRAMES);
        }

        public function set totalAmmo(param1:int) : void
        {
            this._totalAmmo = param1;
            this.updateTotalAmmoState();
        }

        public function set currentAmmo(param1:int) : void
        {
            this._currentAmmo = param1;
            var _loc2_:int = this._currentAmmo;
            if(this._isAnimationInProgress)
            {
                _loc2_ = _loc2_ + 1;
            }
            this.updateCurrentAmmoStates(_loc2_);
        }
    }
}
