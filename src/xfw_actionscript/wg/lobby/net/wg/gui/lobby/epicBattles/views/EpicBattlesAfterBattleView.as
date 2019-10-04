package net.wg.gui.lobby.epicBattles.views
{
    import net.wg.infrastructure.base.meta.impl.EpicBattlesAfterBattleViewMeta;
    import net.wg.infrastructure.base.meta.IEpicBattlesAfterBattleViewMeta;
    import net.wg.gui.components.controls.CloseButtonText;
    import net.wg.gui.lobby.epicBattles.components.afterBattle.EpicBattlesPlayerRank;
    import net.wg.gui.lobby.epicBattles.components.afterBattle.EpicBattlesAnimatedTitleTextfield;
    import net.wg.gui.lobby.epicBattles.components.prestigeView.RewardRibbon;
    import net.wg.gui.components.controls.SoundButtonEx;
    import net.wg.gui.lobby.epicBattles.components.afterBattle.EpicBattlesAfterBattleFameProgressBar;
    import flash.text.TextField;
    import flash.display.Sprite;
    import net.wg.gui.lobby.epicBattles.components.BackgroundComponent;
    import net.wg.utils.IScheduler;
    import net.wg.gui.lobby.epicBattles.data.EpicBattlesAfterBattleViewVO;
    import scaleform.clik.motion.Tween;
    import flash.ui.Keyboard;
    import flash.events.KeyboardEvent;
    import scaleform.clik.events.ButtonEvent;
    import net.wg.gui.lobby.epicBattles.events.AfterBattleFameBarEvent;
    import flash.text.TextFieldAutoSize;
    import scaleform.clik.constants.InvalidationType;
    import org.idmedia.as3commons.util.StringUtils;
    import scaleform.clik.events.InputEvent;

    public class EpicBattlesAfterBattleView extends EpicBattlesAfterBattleViewMeta implements IEpicBattlesAfterBattleViewMeta
    {

        private static const OLD_PROGRESS_INDEX:int = 0;

        private static const NEW_PROGRESS_PURE_INDEX:int = 1;

        private static const NEW_PROGRESS_INDEX:int = 2;

        private static const OFFSET_CLOSE_BUTTON:int = 22;

        private static const BASIC_DELAY:int = 100;

        private static const FADE_OUT_LENGTH:int = 300;

        private static const FAME_BAR_DELAY:int = 100;

        private static const INTRO_ANIMATION_START_DELAY:int = 1500;

        private static const STANDARD_TOP_RIBBON_RATIO:Number = 0.58;

        private static const BREAKING_POINT_RESOLUTION:int = 900;

        private static const RANK_TO_BAR_GAP:int = 150;

        private static const BAR_TO_BUTTON_GAP:int = 110;

        private static const BAR_TO_SUBTITLE:int = 50;

        private static const RANK_Y_OFFSET:int = 130;

        private static const REWARDS_TO_TITLE_GAP:int = -380;

        private static const RANK_TOP_OFFSET:int = 60;

        private static const MAX_PRESTIGE_ICON_OFFSET:int = 5;

        public var closeButton:CloseButtonText;

        public var playerRank:EpicBattlesPlayerRank;

        public var titleTextWrapper:EpicBattlesAnimatedTitleTextfield;

        public var rewardRibbon:RewardRibbon;

        public var nextButton:SoundButtonEx;

        public var fameBar:EpicBattlesAfterBattleFameProgressBar;

        public var fameSubTitle:TextField;

        public var maxPrestigeIcon:Sprite;

        public var background:BackgroundComponent = null;

        private var _scheduler:IScheduler;

        private var _completedBattleData:EpicBattlesAfterBattleViewVO = null;

        private var _isSmall:Boolean;

        private var _fameBarVisible:Boolean = true;

        private var _ribbonDisplayed:Boolean = false;

        private var _fameBarFadeInTween:Tween;

        private var _playerRankFadeInTween:Tween;

        private var _nextButtonFadeInTween:Tween;

        private var _fameSubTitleInTween:Tween;

        private var _maxPrestigeIconInTween:Tween;

        public function EpicBattlesAfterBattleView()
        {
            this._scheduler = App.utils.scheduler;
            super();
        }

        override public function updateStage(param1:Number, param2:Number) : void
        {
            super.updateStage(param1,param2);
            invalidateSize();
        }

        override protected function onBeforeDispose() : void
        {
            this.titleTextWrapper.stop();
            App.gameInputMgr.clearKeyHandler(Keyboard.ESCAPE,KeyboardEvent.KEY_DOWN,this.onEscapeKeyDownHandler);
            this._scheduler.cancelTask(this.startAnimation);
            this._scheduler.cancelTask(this.delayedPlayerRankIntroTweenTask);
            this._scheduler.cancelTask(this.delayedFameBarIntroTweenTask);
            this._scheduler.cancelTask(this.delayedNextButtonIntroTweenTask);
            this.nextButton.removeEventListener(ButtonEvent.CLICK,this.onNextButtonClickHandler);
            this.closeButton.removeEventListener(ButtonEvent.CLICK,this.onCloseButtonClickHandler);
            this.fameBar.removeEventListener(AfterBattleFameBarEvent.LEVEL_UP,this.onNewEpicMetaLevelUpHandler);
            this.fameBar.removeEventListener(AfterBattleFameBarEvent.BAR_FILLED,this.onProgressBarFilledHandler);
            this.fameBar.removeEventListener(AfterBattleFameBarEvent.START_ANIM,this.onProgressBarStartAnimHandler);
            super.onBeforeDispose();
        }

        override protected function onDispose() : void
        {
            this._scheduler = null;
            if(this._fameBarFadeInTween != null)
            {
                this._fameBarFadeInTween.dispose();
                this._fameBarFadeInTween = null;
            }
            this._playerRankFadeInTween.dispose();
            this._playerRankFadeInTween = null;
            if(this._fameSubTitleInTween != null)
            {
                this._fameSubTitleInTween.dispose();
                this._fameSubTitleInTween = null;
            }
            if(this._maxPrestigeIconInTween != null)
            {
                this._maxPrestigeIconInTween.dispose();
                this._maxPrestigeIconInTween = null;
            }
            if(this._nextButtonFadeInTween)
            {
                this._nextButtonFadeInTween.dispose();
                this._nextButtonFadeInTween = null;
            }
            this.nextButton.dispose();
            this.nextButton = null;
            this.closeButton.dispose();
            this.closeButton = null;
            this.playerRank.dispose();
            this.playerRank = null;
            this.titleTextWrapper.dispose();
            this.titleTextWrapper = null;
            this.rewardRibbon.dispose();
            this.rewardRibbon = null;
            this.background.dispose();
            this.background = null;
            this.fameBar.dispose();
            this.fameBar = null;
            this.fameSubTitle = null;
            this.maxPrestigeIcon = null;
            this._completedBattleData = null;
            super.onDispose();
        }

        override protected function configUI() : void
        {
            super.configUI();
            App.gameInputMgr.setKeyHandler(Keyboard.ESCAPE,KeyboardEvent.KEY_DOWN,this.onEscapeKeyDownHandler,true,null,getFocusIndex());
            this.closeButton.label = VEHICLE_CUSTOMIZATION.CUSTOMIZATIONHEADER_CLOSE;
            this.closeButton.tooltip = RANKED_BATTLES.TOOLTIP_CLOSEBUTTON;
            this.closeButton.addEventListener(ButtonEvent.CLICK,this.onCloseButtonClickHandler);
            this.closeButton.validateNow();
            this.playerRank.alpha = 0;
            this.playerRank.visible = false;
            this.rewardRibbon.visible = false;
            this.titleTextWrapper.visible = false;
            this.fameSubTitle.visible = false;
            this.fameSubTitle.alpha = 0;
            this.fameSubTitle.autoSize = TextFieldAutoSize.CENTER;
            this.maxPrestigeIcon.alpha = 0;
            this.nextButton.alpha = 0;
            this.nextButton.visible = false;
            this.nextButton.label = DIALOGS.COMMON_SUBMIT;
            this.nextButton.addEventListener(ButtonEvent.CLICK,this.onNextButtonClickHandler);
            this.fameBar.alpha = 0;
            this.fameBar.visible = false;
            this.fameBar.addEventListener(AfterBattleFameBarEvent.LEVEL_UP,this.onNewEpicMetaLevelUpHandler);
            this.fameBar.addEventListener(AfterBattleFameBarEvent.BAR_FILLED,this.onProgressBarFilledHandler);
            this.fameBar.addEventListener(AfterBattleFameBarEvent.START_ANIM,this.onProgressBarStartAnimHandler);
        }

        override protected function setData(param1:EpicBattlesAfterBattleViewVO) : void
        {
            this._completedBattleData = param1;
            this._fameBarVisible = this._completedBattleData.fameBarVisible;
            this.rewardRibbon.setAwards(param1.awards);
            this.rewardRibbon.setLevel(param1.epicMetaLevelIconData);
            this.background.setBackground(param1.backgroundImageSrc);
            invalidateData();
        }

        override protected function draw() : void
        {
            var _loc1_:* = false;
            var _loc2_:* = 0;
            var _loc3_:Array = null;
            var _loc4_:* = 0;
            var _loc5_:* = 0;
            var _loc6_:* = 0;
            var _loc7_:* = 0;
            super.draw();
            if(this._completedBattleData)
            {
                _loc1_ = isInvalid(InvalidationType.SIZE);
                _loc2_ = App.appHeight;
                this._isSmall = _loc2_ < BREAKING_POINT_RESOLUTION;
                if(isInvalid(InvalidationType.DATA))
                {
                    if(this._fameBarVisible)
                    {
                        this.fameBar.setMaxLevel(this._completedBattleData.maxLevel);
                        this.fameBar.setFamePoints(this._completedBattleData.barText);
                        this.fameBar.setFameBoostPoints(this._completedBattleData.barBoostText);
                        _loc3_ = this._completedBattleData.progress;
                        this.fameBar.setProgress(_loc3_[OLD_PROGRESS_INDEX],_loc3_[NEW_PROGRESS_PURE_INDEX],_loc3_[NEW_PROGRESS_INDEX]);
                    }
                    this.playerRank.setRank(this._completedBattleData.rank);
                    this.playerRank.setDescText(this._completedBattleData.rankSubText);
                    this.playerRank.setTitleText(this._isSmall?this._completedBattleData.rankText:this._completedBattleData.rankTextBig);
                    this.fameSubTitle.visible = StringUtils.isNotEmpty(this._completedBattleData.maxLevelText);
                    if(this.fameSubTitle.visible)
                    {
                        this.fameSubTitle.htmlText = this._completedBattleData.maxLevelText;
                    }
                    this.maxPrestigeIcon.visible = this._completedBattleData.maxPrestigeIconVisible;
                    _loc1_ = true;
                    this.startAnimation();
                }
                if(_loc1_)
                {
                    _loc4_ = App.appWidth;
                    _loc5_ = _loc4_ >> 1;
                    this.background.updateStage(_loc4_,_loc2_);
                    this.closeButton.x = _loc4_ - this.closeButton.width - OFFSET_CLOSE_BUTTON | 0;
                    this.closeButton.y = OFFSET_CLOSE_BUTTON;
                    this.titleTextWrapper.setText(this._isSmall?this._completedBattleData.levelUpText:this._completedBattleData.levelUpTextBig);
                    this.playerRank.setTitleText(this._isSmall?this._completedBattleData.rankText:this._completedBattleData.rankTextBig);
                    _loc6_ = RANK_Y_OFFSET + this.playerRank.height + RANK_TO_BAR_GAP + this.fameBar.height + BAR_TO_BUTTON_GAP + this.nextButton.height;
                    this.playerRank.y = (_loc2_ - _loc6_ >> 1) + RANK_Y_OFFSET;
                    _loc7_ = this.playerRank.y + this.playerRank.height + RANK_TO_BAR_GAP;
                    this.fameBar.y = _loc7_;
                    this.nextButton.y = _loc7_ + BAR_TO_BUTTON_GAP;
                    this.playerRank.y = this.playerRank.y + RANK_TOP_OFFSET;
                    if(this._fameBarVisible)
                    {
                        this.fameSubTitle.y = _loc7_ + BAR_TO_SUBTITLE;
                    }
                    else
                    {
                        this.fameSubTitle.y = _loc7_;
                    }
                    if(this.maxPrestigeIcon.visible)
                    {
                        this.maxPrestigeIcon.x = _loc4_ - this.maxPrestigeIcon.width >> 1;
                        this.maxPrestigeIcon.y = this.fameSubTitle.y - this.maxPrestigeIcon.height + MAX_PRESTIGE_ICON_OFFSET | 0;
                    }
                    this.rewardRibbon.y = _loc2_ * STANDARD_TOP_RIBBON_RATIO ^ 0;
                    this.titleTextWrapper.y = this.rewardRibbon.y + REWARDS_TO_TITLE_GAP;
                    this.nextButton.x = _loc5_ - (this.nextButton.width >> 1);
                    this.titleTextWrapper.x = _loc4_ - this.titleTextWrapper.getWidth() >> 1;
                    this.playerRank.x = _loc5_;
                    this.rewardRibbon.x = _loc5_;
                    this.fameBar.x = _loc4_ - this.fameBar.width >> 1;
                    this.fameSubTitle.x = _loc4_ - this.fameSubTitle.width >> 1;
                }
            }
        }

        private function startIntroAnimation() : void
        {
            this.playerRank.playIntro();
            onIntroStartsPlayingS();
            if(this._fameBarVisible)
            {
                this._scheduler.scheduleTask(this.delayedFameBarIntroTweenTask,BASIC_DELAY);
            }
            else
            {
                this._scheduler.scheduleTask(this.delayedNextButtonIntroTweenTask,BASIC_DELAY);
            }
        }

        private function delayedFameBarIntroTweenTask() : void
        {
            this.fameBar.visible = this._fameBarVisible;
            this._fameBarFadeInTween = new Tween(FADE_OUT_LENGTH,this.fameBar,{"alpha":1},{
                "delay":FAME_BAR_DELAY,
                "onComplete":this.fameBar.startProgressAnimation()
            });
        }

        private function startAnimation() : void
        {
            this._scheduler.scheduleTask(this.delayedPlayerRankIntroTweenTask,INTRO_ANIMATION_START_DELAY);
        }

        private function delayedPlayerRankIntroTweenTask() : void
        {
            this.playerRank.visible = true;
            this._playerRankFadeInTween = new Tween(FADE_OUT_LENGTH,this.playerRank,{"alpha":1},{"delay":BASIC_DELAY});
            this._scheduler.scheduleTask(this.startIntroAnimation,FADE_OUT_LENGTH + BASIC_DELAY);
        }

        private function delayedNextButtonIntroTweenTask() : void
        {
            this.nextButton.visible = true;
            this._nextButtonFadeInTween = new Tween(FADE_OUT_LENGTH,this.nextButton,{"alpha":1},{"delay":BASIC_DELAY});
            if(this.fameSubTitle.visible)
            {
                this._fameSubTitleInTween = new Tween(FADE_OUT_LENGTH,this.fameSubTitle,{"alpha":1},{"delay":FAME_BAR_DELAY});
            }
            if(this.maxPrestigeIcon.visible)
            {
                this._maxPrestigeIconInTween = new Tween(FADE_OUT_LENGTH,this.maxPrestigeIcon,{"alpha":1},{"delay":FAME_BAR_DELAY});
            }
        }

        private function onProgressBarStartAnimHandler(param1:AfterBattleFameBarEvent) : void
        {
            onProgressBarStartAnimS();
        }

        private function onProgressBarFilledHandler(param1:AfterBattleFameBarEvent) : void
        {
            this._scheduler.scheduleTask(this.delayedNextButtonIntroTweenTask,BASIC_DELAY);
            onProgressBarCompleteAnimS();
        }

        private function onNewEpicMetaLevelUpHandler(param1:AfterBattleFameBarEvent) : void
        {
            onProgressBarCompleteAnimS();
            if(this._ribbonDisplayed)
            {
                return;
            }
            this.playerRank.visible = false;
            this.titleTextWrapper.visible = true;
            this.titleTextWrapper.setText(this._isSmall?this._completedBattleData.levelUpText:this._completedBattleData.levelUpTextBig);
            this.titleTextWrapper.gotoAndPlay(EpicBattlesAnimatedTitleTextfield.LEVEL_UP_ANIM_FRAME_LBL);
            this.rewardRibbon.visible = true;
            this.rewardRibbon.show();
            this._ribbonDisplayed = true;
            onRibbonStartsPlayingS();
        }

        private function onNextButtonClickHandler(param1:ButtonEvent) : void
        {
            onCloseBtnClickS();
        }

        private function onCloseButtonClickHandler(param1:ButtonEvent) : void
        {
            onCloseBtnClickS();
        }

        private function onEscapeKeyDownHandler(param1:InputEvent) : void
        {
            onEscapePressS();
        }
    }
}
