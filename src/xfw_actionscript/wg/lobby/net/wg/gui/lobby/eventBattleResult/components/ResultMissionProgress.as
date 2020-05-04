package net.wg.gui.lobby.eventBattleResult.components
{
    import net.wg.infrastructure.base.UIComponentEx;
    import net.wg.infrastructure.interfaces.entity.IUpdatable;
    import net.wg.gui.bootcamp.containers.AnimatedTextContainer;
    import net.wg.gui.bootcamp.containers.AnimatedSpriteContainer;
    import flash.display.MovieClip;
    import flash.text.TextField;
    import net.wg.gui.lobby.eventBattleResult.data.ResultMissionRewardVO;
    import net.wg.utils.IScheduler;
    import net.wg.utils.ILocale;
    import net.wg.infrastructure.managers.ITooltipMgr;
    import flash.events.MouseEvent;
    import flash.events.Event;
    import net.wg.data.constants.Values;
    import net.wg.gui.lobby.eventBattleResult.events.EventBattleResultEvent;
    import flash.utils.getTimer;
    import org.idmedia.as3commons.util.StringUtils;

    public class ResultMissionProgress extends UIComponentEx implements IUpdatable
    {

        private static const ANIMATION_TIME:int = 500;

        private static const REWARD_DELAY:int = 700;

        private static const HUNDRED_PERCENT:int = 100;

        private static const DOTS:String = "...";

        private static const PLUS:String = "+";

        private static const PERSONAl_FRAME:int = 1;

        private static const CREW_FRAME:int = 2;

        public var completeAnim:ResultMissionComplete = null;

        public var descriptionAnim:AnimatedTextContainer = null;

        public var deltaText:AnimatedSpriteContainer = null;

        public var progressText:ProgressContainer = null;

        public var reward:ResultMissionReward = null;

        public var icon:MovieClip = null;

        public var progress:ProgressAnimation = null;

        public var iconCrew:ProgressCrew = null;

        public var textHeader:TextField = null;

        public var tank:RewardItemRenderer = null;

        public var hover:MovieClip = null;

        private var _questData:ResultMissionRewardVO = null;

        private var _currentProgress:int = -1;

        private var _currentPercent:int = -1;

        private var _startTime:Number = -1;

        private var _scheduler:IScheduler;

        private var _locale:ILocale;

        private var _tooltipMgr:ITooltipMgr;

        public function ResultMissionProgress()
        {
            this._scheduler = App.utils.scheduler;
            this._locale = App.utils.locale;
            this._tooltipMgr = App.toolTipMgr;
            super();
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.hover.addEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
            this.hover.addEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
        }

        override protected function onBeforeDispose() : void
        {
            this._scheduler.cancelTask(this.playCompleteAnimation);
            this._scheduler.cancelTask(this.showReward);
            this.hover.removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
            this.hover.removeEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
            removeEventListener(Event.ENTER_FRAME,this.onEnterFrameHandler);
            super.onBeforeDispose();
        }

        override protected function onDispose() : void
        {
            this.completeAnim.dispose();
            this.completeAnim = null;
            this.textHeader = null;
            this.reward.dispose();
            this.reward = null;
            this.descriptionAnim.dispose();
            this.descriptionAnim = null;
            this.progress.dispose();
            this.progress = null;
            this.deltaText.dispose();
            this.deltaText = null;
            this.progressText.dispose();
            this.progressText = null;
            if(this.iconCrew != null)
            {
                this.iconCrew.dispose();
                this.iconCrew = null;
            }
            if(this.tank != null)
            {
                this.tank.dispose();
                this.tank = null;
            }
            this.hover = null;
            this.icon = null;
            this._questData = null;
            this._scheduler = null;
            this._locale = null;
            this._tooltipMgr = null;
            super.onDispose();
        }

        public function appear(param1:int = 0) : void
        {
            if(!this._questData)
            {
                return;
            }
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
            var _loc1_:* = NaN;
            if(!this._questData)
            {
                return;
            }
            this.deltaText.gotoAndStop(ResultAppearMovieClip.IDLE);
            this._scheduler.cancelTask(this.playCompleteAnimation);
            this._scheduler.cancelTask(this.showReward);
            removeEventListener(Event.ENTER_FRAME,this.onEnterFrameHandler);
            if(this._questData.progressTotal != 0)
            {
                _loc1_ = this._questData.progressDelta / this._questData.progressTotal * HUNDRED_PERCENT;
                this._currentProgress = this._questData.progressNewCurrent;
                this._currentPercent = this._questData.progress + _loc1_;
                this.progressText.visible = true;
                if(this._questData.progressDelta > 0)
                {
                    this.progress.resetInitialProgress(this._questData.progress);
                    if(_loc1_ < 1)
                    {
                        if(this._currentPercent + 1 != HUNDRED_PERCENT)
                        {
                            this._currentPercent = this._currentPercent + 1;
                        }
                        else
                        {
                            this.progress.resetInitialProgress(this._currentPercent - 1);
                        }
                    }
                    this.progress.immediateAppear();
                    this.progress.setProgress(this._currentPercent);
                }
                this.updateProgress();
                if(this._currentProgress == this._questData.progressTotal)
                {
                    this.completeAnim.immediateAppear();
                    this.reward.immediateAppear();
                }
            }
            this.showReward();
        }

        public function update(param1:Object) : void
        {
            var _loc3_:String = null;
            this._questData = ResultMissionRewardVO(param1);
            if(!this._questData)
            {
                return;
            }
            var _loc2_:Boolean = this._questData.isCrew;
            MovieClip(this.deltaText.content).gotoAndStop(_loc2_?CREW_FRAME:PERSONAl_FRAME);
            this.progress.init(_loc2_);
            this.completeAnim.setLabels(this._questData.progressLabel,this._questData.completeLabel);
            this.reward.setData(this._questData.rewards,_loc2_);
            this.descriptionAnim.text = this._questData.description;
            if(this._questData.progressTotal != this._questData.progressCurrent)
            {
                _loc3_ = Values.EMPTY_STR;
                if(this._questData.progressDelta)
                {
                    _loc3_ = PLUS + this._locale.integer(this._questData.progressDelta);
                }
                else
                {
                    _loc3_ = this._questData.progressDelta.toString();
                }
                this.deltaText.text = _loc3_;
            }
            else
            {
                this.completeAnim.immediateAppear();
                this.showReward();
            }
            if(this._questData.progressTotal > 0)
            {
                this.progressText.setProgress(this._questData.progressCurrent,this._questData.progressTotal);
                this.progress.setProgress(this._questData.progress);
            }
            App.utils.commons.truncateTextFieldText(this.textHeader,this._questData.header,true,false,DOTS);
            if(this.iconCrew != null && this._questData.isCrew)
            {
                this.iconCrew.setIcons(this._questData.iconCrew,this._questData.iconLevel);
            }
            if(this.tank != null)
            {
                this.tank.update(this._questData.tank);
            }
        }

        private function updateProgress() : void
        {
            this.progressText.setProgress(this._currentProgress,this._questData.progressTotal);
        }

        private function playCompleteAnimation() : void
        {
            this.deltaText.gotoAndPlay(ResultAppearMovieClip.APPEAR);
            if(this._questData.progressDelta > 0)
            {
                this.progress.appear();
                dispatchEvent(new EventBattleResultEvent(EventBattleResultEvent.PROGRESS_BAR_APPEAR,0,null,true));
            }
            if(this._questData.progressTotal == 0)
            {
                this.completeAnim.appear();
            }
            else
            {
                this.progressText.visible = true;
                this._currentProgress = this._questData.progressCurrent;
                this._currentPercent = this._questData.progress;
                this._startTime = getTimer();
                addEventListener(Event.ENTER_FRAME,this.onEnterFrameHandler);
            }
            if(this._questData.progressTotal != this._questData.progressCurrent)
            {
                this._scheduler.scheduleTask(this.showReward,REWARD_DELAY);
            }
        }

        private function showReward() : void
        {
            if(this._questData.progressNewCurrent == this._questData.progressTotal)
            {
                this.reward.appear();
                if(this.tank != null)
                {
                    this.tank.alpha = Values.DEFAULT_ALPHA;
                    this.tank.appear();
                }
            }
        }

        private function onEnterFrameHandler(param1:Event) : void
        {
            var _loc2_:Number = Math.min(1,(getTimer() - this._startTime) / ANIMATION_TIME);
            var _loc3_:Number = this._questData.progressDelta / this._questData.progressTotal * HUNDRED_PERCENT;
            var _loc4_:int = this._questData.progress + (_loc2_ * _loc3_ >> 0);
            if(_loc2_ == 1 && _loc4_ == this._questData.progress && this._questData.progressDelta > 0)
            {
                if(_loc4_ + 1 != HUNDRED_PERCENT)
                {
                    _loc4_ = _loc4_ + 1;
                }
                else
                {
                    this._currentPercent = this._currentPercent - 1;
                    this.progress.resetInitialProgress(this._currentPercent);
                }
            }
            var _loc5_:* = this._questData.progressCurrent + (this._questData.progressNewCurrent - this._questData.progressCurrent) * _loc2_ >> 0;
            if(_loc5_ != this._currentProgress)
            {
                this._currentProgress = _loc5_;
                this.updateProgress();
            }
            if(this._currentPercent != _loc4_)
            {
                this._currentPercent = _loc4_;
                this.progress.setProgress(_loc4_);
            }
            if(this._currentProgress == this._questData.progressNewCurrent && this._currentPercent == HUNDRED_PERCENT)
            {
                removeEventListener(Event.ENTER_FRAME,this.onEnterFrameHandler);
                if(this._questData.progressTotal != this._questData.progressCurrent)
                {
                    this.completeAnim.appear();
                }
            }
        }

        private function onRollOverHandler(param1:MouseEvent) : void
        {
            if(this._questData == null || this._questData.tooltipData == null)
            {
                return;
            }
            if(this._questData.isWulfTooltip)
            {
                this._tooltipMgr.showWulfTooltip.apply(this._tooltipMgr,this._questData.tooltipData.specialArgs);
            }
            else if(StringUtils.isNotEmpty(this._questData.tooltipData.tooltip))
            {
                this._tooltipMgr.showComplex(this._questData.tooltipData.tooltip);
            }
            else
            {
                this._tooltipMgr.showSpecial.apply(this._tooltipMgr,[this._questData.tooltipData.specialAlias,null].concat(this._questData.tooltipData.specialArgs));
            }
        }

        private function onRollOutHandler(param1:MouseEvent) : void
        {
            this._tooltipMgr.hide();
        }
    }
}
