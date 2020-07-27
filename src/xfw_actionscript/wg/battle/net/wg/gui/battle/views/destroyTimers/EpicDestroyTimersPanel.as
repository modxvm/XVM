package net.wg.gui.battle.views.destroyTimers
{
    import net.wg.infrastructure.base.meta.impl.EpicDestroyTimersPanelMeta;
    import net.wg.infrastructure.base.meta.IEpicDestroyTimersPanelMeta;
    import net.wg.data.constants.InvalidationType;
    import flash.display.MovieClip;
    import net.wg.utils.StageSizeBoundaries;
    import net.wg.data.constants.Linkages;

    public class EpicDestroyTimersPanel extends EpicDestroyTimersPanelMeta implements IEpicDestroyTimersPanelMeta
    {

        private static const INVALID_RESUPPLY_STATE:uint = InvalidationType.STATE << 1;

        private static const RESUPPLY_CIRCLE:int = 1;

        public var additionalTimerContainer:MovieClip = null;

        private var _isDestroyTimerActive:Boolean = false;

        private var _isSmall:Boolean = false;

        private var _isTimerShow:Boolean = false;

        private var _progress:Number = 0;

        private var _state:int = 0;

        private var _cooldownTime:String = "";

        private var _resupplyTimer:ResupplyTimer = null;

        public function EpicDestroyTimersPanel()
        {
            super();
        }

        override protected function hideTimer(param1:DestroyTimer) : void
        {
            super.hideTimer(param1);
            this._isDestroyTimerActive = false;
            if(this._resupplyTimer.isActive)
            {
                invalidate(INVALID_RESUPPLY_STATE);
            }
        }

        override protected function hideSecondaryTimer(param1:String) : void
        {
            super.hideSecondaryTimer(param1);
            if(this._resupplyTimer.isActive)
            {
                invalidate(INVALID_RESUPPLY_STATE);
            }
        }

        override protected function showTimer(param1:String, param2:String, param3:Boolean) : void
        {
            super.showTimer(param1,param2,param3);
            this._isDestroyTimerActive = true;
            if(this._resupplyTimer.isActive)
            {
                invalidate(INVALID_RESUPPLY_STATE);
            }
        }

        override protected function showSecondaryTimer(param1:String, param2:int, param3:Number, param4:Boolean = false) : void
        {
            super.showSecondaryTimer(param1,param2,param3,param4);
            if(this._resupplyTimer.isActive)
            {
                invalidate(INVALID_RESUPPLY_STATE);
            }
        }

        override protected function draw() : void
        {
            var _loc1_:String = null;
            super.draw();
            if(this._resupplyTimer && isInvalid(InvalidationType.SIZE))
            {
                if(this._isSmall != stageWidth < StageSizeBoundaries.WIDTH_1280)
                {
                    this._isSmall = stageWidth < StageSizeBoundaries.WIDTH_1280;
                    _loc1_ = this._isSmall?Linkages.RESUPPLY_TIMER_SMALL_UI:Linkages.RESUPPLY_TIMER_UI;
                    this.additionalTimerContainer.removeChild(this._resupplyTimer);
                    this._resupplyTimer = App.utils.classFactory.getComponent(_loc1_,ResupplyTimer);
                    this._resupplyTimer.stop();
                    this._resupplyTimer.visible = false;
                    this._resupplyTimer.mouseEnabled = false;
                    this._resupplyTimer.mouseChildren = false;
                    this._resupplyTimer.setProgressValue(this._progress);
                    this._resupplyTimer.setState(this._state);
                    this._resupplyTimer.setCooldownTime(this._cooldownTime);
                    this._resupplyTimer.isActive = this._isTimerShow;
                    if(this._isTimerShow)
                    {
                        this._resupplyTimer.visible = true;
                        this._resupplyTimer.showTimer();
                    }
                    else
                    {
                        this._resupplyTimer.resetTimer();
                        this._resupplyTimer.hideTimer();
                    }
                    this.additionalTimerContainer.addChild(this._resupplyTimer);
                    invalidate(INVALID_STATE);
                    invalidate(INVALID_RESUPPLY_STATE);
                }
            }
            if(isInvalid(INVALID_RESUPPLY_STATE))
            {
                if(!this._isDestroyTimerActive && this._resupplyTimer.isActive)
                {
                    this._resupplyTimer.visible = true;
                    evaluateState(true,secondaryTimerVisibleBefore);
                    if(secondaryTimerVisibleBefore)
                    {
                        this._resupplyTimer.cropSize();
                    }
                    else
                    {
                        this._resupplyTimer.fullSize();
                    }
                    statusVisibleBefore = true;
                }
                else
                {
                    this._resupplyTimer.visible = false;
                }
            }
        }

        override protected function onDispose() : void
        {
            this.additionalTimerContainer.removeChild(this._resupplyTimer);
            this.additionalTimerContainer = null;
            this._resupplyTimer.dispose();
            this._resupplyTimer = null;
            super.onDispose();
        }

        override protected function configUI() : void
        {
            super.configUI();
            this._isSmall = stageWidth < StageSizeBoundaries.WIDTH_1280;
            var _loc1_:String = this._isSmall?Linkages.RESUPPLY_TIMER_SMALL_UI:Linkages.RESUPPLY_TIMER_UI;
            this._resupplyTimer = App.utils.classFactory.getComponent(_loc1_,ResupplyTimer);
            this._resupplyTimer.stop();
            this._resupplyTimer.visible = false;
            this._resupplyTimer.mouseEnabled = false;
            this._resupplyTimer.mouseChildren = false;
            this._resupplyTimer.setState(0);
            this.additionalTimerContainer.addChild(this._resupplyTimer);
        }

        public function as_hideAdditionalTimer(param1:int) : void
        {
            if(param1 == RESUPPLY_CIRCLE)
            {
                this._resupplyTimer.resetTimer();
                this._resupplyTimer.isActive = false;
                this._isTimerShow = false;
                this._resupplyTimer.hideTimer();
                invalidate(INVALID_STATE);
                invalidate(INVALID_RESUPPLY_STATE);
            }
        }

        public function as_setAdditionalTimerProgressValue(param1:int, param2:Number) : void
        {
            if(param1 == RESUPPLY_CIRCLE)
            {
                this._progress = param2;
                this._resupplyTimer.setProgressValue(param2);
            }
        }

        public function as_setAdditionalTimerState(param1:int, param2:int) : void
        {
            if(param1 == RESUPPLY_CIRCLE)
            {
                this._state = param2;
                this._resupplyTimer.setState(param2);
            }
        }

        public function as_setAdditionalTimerTimeString(param1:int, param2:String) : void
        {
            if(param1 == RESUPPLY_CIRCLE)
            {
                this._cooldownTime = param2;
                this._resupplyTimer.setCooldownTime(param2);
            }
        }

        public function as_showAdditionalTimer(param1:int, param2:int) : void
        {
            if(param1 == RESUPPLY_CIRCLE)
            {
                this._resupplyTimer.visible = true;
                this._resupplyTimer.isActive = true;
                this._state = param2;
                this._resupplyTimer.setState(param2);
                this._isTimerShow = true;
                this._resupplyTimer.showTimer();
                invalidate(INVALID_STATE);
                invalidate(INVALID_RESUPPLY_STATE);
            }
        }
    }
}
