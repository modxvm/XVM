package net.wg.gui.bootcamp.battleResult
{
    import net.wg.infrastructure.base.meta.impl.BCBattleResultMeta;
    import net.wg.infrastructure.base.meta.IBCBattleResultMeta;
    import net.wg.gui.bootcamp.containers.AnimatedTextContainer;
    import flash.display.MovieClip;
    import net.wg.gui.components.controls.UILoaderAlt;
    import net.wg.gui.bootcamp.battleResult.containers.base.BattleResultContent;
    import net.wg.gui.components.containers.GroupEx;
    import net.wg.gui.components.controls.SoundButtonEx;
    import flash.geom.Point;
    import net.wg.gui.bootcamp.battleResult.data.BCBattleViewVO;
    import net.wg.utils.IScheduler;
    import net.wg.gui.bootcamp.battleResult.events.BattleViewEvent;
    import net.wg.gui.events.UILoaderEvent;
    import scaleform.clik.events.ButtonEvent;
    import net.wg.gui.components.containers.HorizontalGroupLayout;
    import net.wg.data.constants.Linkages;
    import scaleform.clik.constants.InvalidationType;
    import flash.text.TextFieldAutoSize;
    import net.wg.utils.StageSizeBoundaries;
    import scaleform.clik.events.InputEvent;
    import scaleform.clik.ui.InputDetails;
    import scaleform.clik.constants.InputValue;
    import flash.ui.Keyboard;
    import net.wg.gui.bootcamp.battleResult.containers.base.BattleResultVideoButton;

    public class BCBattleResult extends BCBattleResultMeta implements IBCBattleResultMeta
    {

        public static const BIG:String = "big";

        public static const SMALL:String = "small";

        public static const MEDIUM:String = "medium";

        public static const STAGE_SMALL_SIZE:int = 1000;

        private static const PLAYER_STATUS_MARGIN_X:int = 34;

        private static const PLAYER_STATUS_MARGIN_Y:int = 37;

        private static const FINISH_MARGIN_Y:int = 100;

        private static const RESULT_MARGIN_Y:int = -18;

        private static const BUTTON_MARGIN_Y:int = -70;

        private static const FINISH_MARGIN_SMALL_Y:int = 30;

        private static const RESULT_MARGIN_SMALL_Y:int = -10;

        private static const BUTTON_MARGIN_SMALL_Y:int = -45;

        private static const CONTENT_MIN_MARGIN_Y:int = 330;

        private static const CONTENT_MARGIN_Y_SCALE:Number = 0.4;

        private static const DELAY_EXIT:int = 100;

        private static const VIDEO_BUTTONS_GAP_SMALL:int = 10;

        private static const VIDEO_BUTTONS_GAP_MEDIUM:int = 10;

        private static const VIDEO_BUTTONS_GAP_BIG:int = 20;

        private static const VIDEO_BUTTONS_X_SMALL:int = 20;

        private static const VIDEO_BUTTONS_X_MEDIUM:int = 40;

        private static const VIDEO_BUTTONS_X_BIG:int = 50;

        public var finishReason:AnimatedTextContainer = null;

        public var result:AnimatedTextContainer = null;

        public var resultGlowMC:MovieClip = null;

        public var bg:UILoaderAlt = null;

        public var playerStatus:AnimatedTextContainer = null;

        public var content:BattleResultContent = null;

        public var videoList:GroupEx = null;

        public var videoTitle:AnimatedTextContainer = null;

        public var btnAnimation:MovieClip = null;

        public var btnHangar:SoundButtonEx = null;

        public var bottomGlowMC:MovieClip = null;

        private var _bgProportion:Number;

        private var _stageDimensions:Point;

        private var _data:BCBattleViewVO = null;

        private var _scheduler:IScheduler;

        public function BCBattleResult()
        {
            this._stageDimensions = new Point();
            this._scheduler = App.utils.scheduler;
            super();
        }

        override public function updateStage(param1:Number, param2:Number) : void
        {
            this._stageDimensions.x = param1;
            this._stageDimensions.y = param2;
            this.resultGlowMC.width = param1;
            this.bottomGlowMC.width = param1;
            var _loc3_:String = param2 <= STAGE_SMALL_SIZE?SMALL:BIG;
            this.finishReason.gotoAndStop(_loc3_);
            if(_baseDisposed)
            {
                return;
            }
            this.result.gotoAndStop(_loc3_);
            if(_baseDisposed)
            {
                return;
            }
            this.playerStatus.gotoAndStop(_loc3_);
            if(_baseDisposed)
            {
                return;
            }
            this.content.updateStage(param1,param2);
            if(_baseDisposed)
            {
                return;
            }
            this.updateText();
            this.updateBg();
            invalidateLayout();
            this.videoList.invalidateLayout();
        }

        override protected function onPopulate() : void
        {
            super.onPopulate();
            addEventListener(BattleViewEvent.ALL_RENDERERS_LOADED,this.onAllRenderersLoadedHandler);
            addEventListener(BattleViewEvent.ANIMATION_START,this.onAnimationStartHandler);
            addEventListener(BattleViewEvent.TOOLTIP_SHOW,this.onTooltipShowHandler);
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.bg.addEventListener(UILoaderEvent.COMPLETE,this.onBgCompleteHandler);
            focusable = true;
            this.btnHangar.label = BOOTCAMP.BTN_CONTINUE;
            this.btnHangar.addEventListener(ButtonEvent.CLICK,this.onBtnHangarClickHandler);
            this.videoList.addEventListener(ButtonEvent.CLICK,this.onVideoButtonClickHandler);
            this.videoList.layout = new HorizontalGroupLayout();
            this.videoList.itemRendererLinkage = Linkages.BC_VIDEO_BUTTON;
            this.videoTitle.text = BOOTCAMP.BATTLE_RESULT_VIDEOBUTTON;
            this.videoTitle.visible = false;
            this.videoTitle.mouseEnabled = this.videoTitle.mouseChildren = false;
        }

        override protected function draw() : void
        {
            super.draw();
            if(this._data && isInvalid(InvalidationType.DATA))
            {
                this.validateData();
            }
            if(this._stageDimensions && isInvalid(InvalidationType.LAYOUT))
            {
                this.validateLayout();
            }
        }

        override protected function onDispose() : void
        {
            removeEventListener(BattleViewEvent.ANIMATION_START,this.onAnimationStartHandler);
            removeEventListener(BattleViewEvent.TOOLTIP_SHOW,this.onTooltipShowHandler);
            removeEventListener(BattleViewEvent.ALL_RENDERERS_LOADED,this.onAllRenderersLoadedHandler);
            this.videoList.removeEventListener(ButtonEvent.CLICK,this.onVideoButtonClickHandler);
            this.videoList.dispose();
            this.videoList = null;
            this.videoTitle.dispose();
            this.videoTitle = null;
            this.bg.removeEventListener(UILoaderEvent.COMPLETE,this.onBgCompleteHandler);
            this.bg.dispose();
            this.bg = null;
            this.btnHangar.removeEventListener(ButtonEvent.CLICK,this.onBtnHangarClickHandler);
            this.btnHangar.dispose();
            this.btnHangar = null;
            this.result.dispose();
            this.result = null;
            this.finishReason.dispose();
            this.finishReason = null;
            this.playerStatus.dispose();
            this.playerStatus = null;
            this.content.dispose();
            this.content = null;
            this._data.dispose();
            this._data = null;
            this._stageDimensions = null;
            this.resultGlowMC = null;
            this.bottomGlowMC = null;
            this.btnAnimation = null;
            this._scheduler = null;
            super.onDispose();
        }

        override protected function setData(param1:BCBattleViewVO) : void
        {
            this._data = param1;
            invalidate(InvalidationType.DATA);
        }

        private function validateData() : void
        {
            this.bg.source = this._data.background;
            this.resultGlowMC.gotoAndStop(this._data.finishReason);
            if(_baseDisposed)
            {
                return;
            }
            this.content.setData(this._data);
            this.videoList.dataProvider = this._data.videoButtons;
            this.videoTitle.visible = this._data.videoButtons.length > 0;
            this.updateText();
            this.validateLayout();
        }

        private function updateText() : void
        {
            if(this._data)
            {
                this.finishReason.autoSize = TextFieldAutoSize.LEFT;
                this.result.autoSize = TextFieldAutoSize.LEFT;
                this.finishReason.text = this._data.finishReasonStr;
                this.result.text = this._data.resultTypeStr;
                this.playerStatus.textField.multiline = true;
                this.playerStatus.autoSize = TextFieldAutoSize.LEFT;
                this.playerStatus.htmlText = this._data.playerResult;
            }
        }

        private function updateBg() : void
        {
            var _loc1_:* = 0;
            var _loc2_:* = 0;
            if(this._stageDimensions && this._bgProportion)
            {
                _loc1_ = this._stageDimensions.x;
                _loc2_ = this._stageDimensions.y;
                if(_loc1_ / _loc2_ >= this._bgProportion)
                {
                    this.bg.width = _loc1_;
                    this.bg.height = Math.round(_loc1_ / this._bgProportion);
                }
                else
                {
                    this.bg.height = _loc2_;
                    this.bg.width = Math.round(_loc2_ * this._bgProportion);
                }
            }
        }

        private function validateLayout() : void
        {
            var _loc1_:int = this._stageDimensions.x;
            var _loc2_:int = this._stageDimensions.y;
            this.bg.x = _loc1_ - this.bg.width >> 1;
            this.finishReason.x = _loc1_ - this.finishReason.width >> 1;
            this.result.x = _loc1_ - this.result.width >> 1;
            this.content.x = this.bottomGlowMC.x = _loc1_ >> 1;
            this.btnHangar.x = _loc1_ - this.btnHangar.width >> 1;
            this.btnAnimation.x = _loc1_ >> 1;
            this.playerStatus.x = _loc1_ - this.playerStatus.width - PLAYER_STATUS_MARGIN_X >> 0;
            if(this._stageDimensions.y <= BCBattleResult.STAGE_SMALL_SIZE)
            {
                this.finishReason.y = FINISH_MARGIN_SMALL_Y;
                this.result.y = this.finishReason.y + this.finishReason.contentHeight + RESULT_MARGIN_SMALL_Y >> 0;
                this.btnHangar.y = _loc2_ - this.btnHangar.height + BUTTON_MARGIN_SMALL_Y >> 0;
            }
            else
            {
                this.finishReason.y = FINISH_MARGIN_Y;
                this.result.y = this.finishReason.y + this.finishReason.contentHeight + RESULT_MARGIN_Y >> 0;
                this.btnHangar.y = _loc2_ - this.btnHangar.height + BUTTON_MARGIN_Y >> 0;
            }
            var _loc3_:int = Math.max(_loc2_ * CONTENT_MARGIN_Y_SCALE,CONTENT_MIN_MARGIN_Y);
            this.content.y = _loc2_ - _loc3_ - this.content.tapeYPos >> 0;
            this.playerStatus.y = _loc2_ - this.playerStatus.height - PLAYER_STATUS_MARGIN_Y >> 0;
            this.btnAnimation.y = this.btnHangar.y + (this.btnHangar.height >> 1) >> 0;
            this.bottomGlowMC.y = _loc2_;
            var _loc4_:HorizontalGroupLayout = HorizontalGroupLayout(this.videoList.layout);
            if(_loc1_ < StageSizeBoundaries.WIDTH_1600)
            {
                _loc4_.gap = VIDEO_BUTTONS_GAP_SMALL;
                this.videoList.x = VIDEO_BUTTONS_X_SMALL;
                this.videoTitle.gotoAndStop(SMALL);
            }
            else if(_loc1_ < StageSizeBoundaries.WIDTH_2200)
            {
                _loc4_.gap = VIDEO_BUTTONS_GAP_MEDIUM;
                this.videoList.x = VIDEO_BUTTONS_X_MEDIUM;
                this.videoTitle.gotoAndStop(MEDIUM);
            }
            else
            {
                _loc4_.gap = VIDEO_BUTTONS_GAP_BIG;
                this.videoList.x = VIDEO_BUTTONS_X_BIG;
                this.videoTitle.gotoAndStop(BIG);
            }
            if(_baseDisposed)
            {
                return;
            }
            this.videoList.validateNow();
            this.videoList.y = this.btnHangar.y + this.btnHangar.height - this.videoList.height >> 0;
            this.videoTitle.y = this.videoList.y;
            if(this.videoTitle.visible)
            {
                this.videoTitle.text = BOOTCAMP.BATTLE_RESULT_VIDEOBUTTON;
            }
        }

        private function delayExit() : void
        {
            this._scheduler.cancelTask(this.delayExit);
            clickS();
        }

        private function onBtnHangarClickHandler(param1:ButtonEvent) : void
        {
            this.btnHangar.enabled = false;
            this._scheduler.scheduleTask(this.delayExit,DELAY_EXIT);
        }

        override public function handleInput(param1:InputEvent) : void
        {
            var _loc3_:* = NaN;
            super.handleInput(param1);
            var _loc2_:InputDetails = param1.details;
            if(_loc2_.value == InputValue.KEY_DOWN)
            {
                _loc3_ = _loc2_.code;
                if(_loc3_ == Keyboard.ESCAPE || _loc3_ == Keyboard.ENTER || _loc3_ == Keyboard.SPACE)
                {
                    param1.handled = true;
                    clickS();
                }
            }
        }

        private function onTooltipShowHandler(param1:BattleViewEvent) : void
        {
            onToolTipShowS(param1.elementId);
        }

        private function onAllRenderersLoadedHandler(param1:BattleViewEvent) : void
        {
            invalidateLayout();
        }

        private function onBgCompleteHandler(param1:UILoaderEvent) : void
        {
            this._bgProportion = Math.round(this.bg.originalWidth) / Math.round(this.bg.originalHeight);
            this.updateBg();
            invalidateLayout();
        }

        private function onAnimationStartHandler(param1:BattleViewEvent) : void
        {
            onAnimationAwardStartS(param1.elementId);
        }

        private function onVideoButtonClickHandler(param1:ButtonEvent) : void
        {
            var _loc2_:BattleResultVideoButton = param1.target as BattleResultVideoButton;
            if(_loc2_ != null)
            {
                onVideoButtonClickS(this.videoList.dataProvider.indexOf(_loc2_.videoData));
            }
        }
    }
}
