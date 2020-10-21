package net.wg.gui.lobby.eventBattleResult.components
{
    import net.wg.infrastructure.base.UIComponentEx;
    import net.wg.infrastructure.interfaces.entity.IUpdatable;
    import flash.text.TextField;
    import net.wg.gui.components.controls.UILoaderAlt;
    import flash.display.MovieClip;
    import net.wg.gui.lobby.eventBattleResult.data.ResultMissionRewardVO;
    import net.wg.utils.IScheduler;
    import net.wg.utils.ILocale;
    import net.wg.gui.events.UILoaderEvent;
    import scaleform.clik.constants.InvalidationType;
    import flash.events.Event;
    import flash.utils.getTimer;
    import net.wg.gui.lobby.eventBattleResult.events.EventBattleResultEvent;
    import net.wg.data.constants.Values;
    import scaleform.gfx.TextFieldEx;

    public class ResultMission extends UIComponentEx implements IUpdatable
    {

        private static const ANIMATION_TIME:int = 500;

        private static const REWARD_DEALY:int = 700;

        private static const HUNDRED_PERCENT:int = 100;

        private static const DIVIDER:String = "/";

        private static const COMPLETE_EMPTY:int = 72;

        private static const BONUS_DELTA_X:int = 52;

        private static const MARGIN_X:int = 6;

        private static const ICON_X:int = 62;

        public var completeAnim:ResultMissionComplete = null;

        public var totalTF:TextField = null;

        public var currentTF:TextField = null;

        public var deltaTF:TextField = null;

        public var dividerTF:TextField = null;

        public var headerTF:TextField = null;

        public var icon:UILoaderAlt = null;

        public var reward:ResultMissionReward = null;

        public var progress:MovieClip = null;

        public var bonusIcon:MovieClip = null;

        private var _questData:ResultMissionRewardVO = null;

        private var _currentProgress:int = -1;

        private var _currentPercent:int = -1;

        private var _startTime:Number = -1;

        private var _scheduler:IScheduler;

        private var _locale:ILocale;

        private var _iconX:int = -1;

        private var _iconY:int = -1;

        private var _showProgress:Boolean = true;

        public function ResultMission()
        {
            this._scheduler = App.utils.scheduler;
            this._locale = App.utils.locale;
            super();
            TextFieldEx.setNoTranslate(this.totalTF,true);
            TextFieldEx.setNoTranslate(this.currentTF,true);
            TextFieldEx.setNoTranslate(this.deltaTF,true);
            TextFieldEx.setNoTranslate(this.dividerTF,true);
            this.completeAnim.visible = this.totalTF.visible = this.currentTF.visible = this.deltaTF.visible = this.dividerTF.visible = this.progress.visible = false;
        }

        override protected function configUI() : void
        {
            super.configUI();
            this._iconX = this.icon.x;
            this._iconY = this.icon.y;
            this.icon.addEventListener(UILoaderEvent.COMPLETE,this.onIconCompleteHandler);
        }

        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(InvalidationType.SIZE))
            {
                this._iconX = ICON_X;
                this.icon.x = this.bonusIcon.visible?this._iconX - BONUS_DELTA_X:this._iconX;
                this.icon.y = this._iconY - (this.icon.height >> 1);
                this.bonusIcon.x = this.icon.x + this.icon.width >> 0;
            }
            if(this._questData && isInvalid(InvalidationType.DATA))
            {
                this.completeAnim.setData(this._questData.status);
            }
        }

        public function update(param1:Object) : void
        {
            this._questData = ResultMissionRewardVO(param1);
            if(this._questData.progressTotal > 0)
            {
                this.currentTF.text = this._locale.integer(this._questData.progressCurrent);
                this.totalTF.text = this._locale.integer(this._questData.progressTotal);
                this.deltaTF.text = this._questData.progressDelta;
                this.deltaTF.x = this.totalTF.x + this.totalTF.textWidth + MARGIN_X;
                this.dividerTF.text = DIVIDER;
                this._showProgress = this._questData.showProgress;
            }
            this.completeAnim.y = COMPLETE_EMPTY;
            this.headerTF.text = this._questData.header;
            this.icon.source = this._questData.icon;
            this.bonusIcon.visible = this._questData.showBonus;
            this.reward.setData(this._questData.rewards);
            invalidateData();
            invalidateSize();
        }

        override protected function onBeforeDispose() : void
        {
            this.icon.removeEventListener(UILoaderEvent.COMPLETE,this.onIconCompleteHandler);
            this._scheduler.cancelTask(this.playCompleteAnimation);
            this._scheduler.cancelTask(this.showReward);
            removeEventListener(Event.ENTER_FRAME,this.onEnterFrameHandler);
            super.onBeforeDispose();
        }

        override protected function onDispose() : void
        {
            this.completeAnim.dispose();
            this.completeAnim = null;
            this.totalTF = null;
            this.currentTF = null;
            this.deltaTF = null;
            this.dividerTF = null;
            this.headerTF = null;
            this.bonusIcon = null;
            this.icon.dispose();
            this.icon = null;
            this.reward.dispose();
            this.reward = null;
            this.progress = null;
            this._questData = null;
            this._scheduler = null;
            this._locale = null;
            super.onDispose();
        }

        public function appear(param1:int) : void
        {
            if(param1 > 0)
            {
                this._scheduler.scheduleTask(this.playCompleteAnimation,param1);
            }
            else
            {
                this.playCompleteAnimation();
            }
        }

        public function immediateAppear() : void
        {
            this._scheduler.cancelTask(this.playCompleteAnimation);
            this._scheduler.cancelTask(this.showReward);
            removeEventListener(Event.ENTER_FRAME,this.onEnterFrameHandler);
            if(this._questData.progressTotal != 0 && !this._questData.showComplete)
            {
                this.totalTF.visible = this.currentTF.visible = this.deltaTF.visible = this.dividerTF.visible = true;
                this.progress.visible = this._showProgress && !this._questData.showComplete;
                this.currentTF.text = this._locale.integer(this._questData.progressNewCurrent);
                this.deltaTF.text = this._questData.progressDelta;
                this.deltaTF.x = this.totalTF.x + this.totalTF.textWidth + MARGIN_X;
                this.progress.gotoAndStop(this._questData.progress);
                this.completeAnim.setData(this._questData.status);
            }
            if(this._questData.progress == HUNDRED_PERCENT || this._questData.showComplete)
            {
                this.progress.visible = false;
                this.completeAnim.visible = true;
                this.completeAnim.immediateAppear();
            }
            this.reward.immediateAppear();
        }

        private function playCompleteAnimation() : void
        {
            if(this._questData.showComplete)
            {
                this.completeAnim.visible = true;
                this.completeAnim.appear();
            }
            else
            {
                this.totalTF.visible = this.currentTF.visible = this.deltaTF.visible = this.dividerTF.visible = true;
                if(this._questData.progressTotal > 0)
                {
                    this.progress.visible = this._showProgress;
                    this._currentProgress = this._questData.progressCurrent;
                    this._currentPercent = this._questData.progress;
                    this._startTime = getTimer();
                    addEventListener(Event.ENTER_FRAME,this.onEnterFrameHandler);
                    if(this._questData.progressNewCurrent > this._questData.progressCurrent)
                    {
                        dispatchEvent(new EventBattleResultEvent(EventBattleResultEvent.MISSION_PROGRESSBAR_APPEAR,Values.ZERO,null,true));
                    }
                }
            }
            this._scheduler.scheduleTask(this.showReward,REWARD_DEALY);
        }

        private function onEnterFrameHandler(param1:Event) : void
        {
            var _loc2_:Number = Math.min(1,(getTimer() - this._startTime) / ANIMATION_TIME);
            var _loc3_:* = _loc2_ * HUNDRED_PERCENT >> 0;
            var _loc4_:* = this._questData.progressCurrent + (this._questData.progressNewCurrent - this._questData.progressCurrent) * _loc2_ >> 0;
            var _loc5_:* = _loc2_ * this._questData.progress >> 0;
            if(_loc4_ != this._currentProgress)
            {
                this._currentProgress = _loc4_;
                this.currentTF.text = this._locale.integer(this._currentProgress);
            }
            if(this._currentPercent != _loc3_)
            {
                this._currentPercent = _loc3_;
                this.progress.gotoAndStop(_loc5_);
            }
            if(this._currentProgress == this._questData.progressNewCurrent && this._currentPercent == HUNDRED_PERCENT)
            {
                removeEventListener(Event.ENTER_FRAME,this.onEnterFrameHandler);
                if(this._currentProgress == this._questData.progressTotal)
                {
                    this.progress.visible = false;
                    this.completeAnim.visible = true;
                    this.completeAnim.appear();
                }
            }
        }

        private function showReward() : void
        {
            this.reward.appear();
            dispatchEvent(new EventBattleResultEvent(EventBattleResultEvent.MISSION_REWARD_APPEAR,Values.ZERO,null,true));
        }

        private function onIconCompleteHandler(param1:UILoaderEvent) : void
        {
            invalidateSize();
        }
    }
}
