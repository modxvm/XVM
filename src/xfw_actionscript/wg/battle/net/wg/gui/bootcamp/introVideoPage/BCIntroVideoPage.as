package net.wg.gui.bootcamp.introVideoPage
{
    import net.wg.infrastructure.base.meta.impl.BCIntroVideoPageMeta;
    import net.wg.infrastructure.base.meta.IBCIntroVideoPageMeta;
    import net.wg.gui.components.common.video.SimpleVideoPlayer;
    import net.wg.gui.bootcamp.introVideoPage.containers.IntroPageContainer;
    import net.wg.gui.components.controls.CloseButtonText;
    import flash.display.MovieClip;
    import net.wg.gui.bootcamp.introVideoPage.containers.LoadingContainer;
    import net.wg.gui.bootcamp.introVideoPage.containers.StepperContainer;
    import net.wg.gui.bootcamp.containers.TutorialPageContainer;
    import net.wg.gui.bootcamp.introVideoPage.data.BCIntroVideoVO;
    import scaleform.clik.motion.Tween;
    import net.wg.gui.components.common.video.VideoPlayerEvent;
    import net.wg.gui.components.common.video.VideoPlayerStatusEvent;
    import flash.events.MouseEvent;
    import net.wg.gui.bootcamp.data.BCTutorialPageVO;
    import fl.transitions.easing.Strong;
    import org.idmedia.as3commons.util.StringUtils;
    import net.wg.gui.components.common.video.PlayerStatus;

    public class BCIntroVideoPage extends BCIntroVideoPageMeta implements IBCIntroVideoPageMeta
    {

        private static const BTN_PADDING:Number = 50;

        private static const INTRO_INFO_CHANGED:String = "infoChanged";

        private static const STAGE_RESIZED:String = "stageResized";

        private static const SMALL_SCREEN_WIDTH:int = 1920;

        private static const SMALL_SCREEN_HEIGHT:int = 1080;

        private static const FULL_PROGRESS:int = 100;

        private static const BLACK_FADE_DURATION:int = 2000;

        private static const OVERLAY_TWEEN_DURATION:int = 300;

        private static const BACK_WIDTH_BIG:int = 3440;

        private static const BACK_WIDTH_SMALL:int = 2365;

        private static const BACK_HEIGHT_SMALL:int = 1930;

        private static const BACK_HEIGHT_BIG:int = 1380;

        private static const CLOSE_BTN_PADDING_RIGHT:int = 80;

        public var videoPlayer:SimpleVideoPlayer = null;

        public var introPage:IntroPageContainer = null;

        public var closeBtn:CloseButtonText = null;

        public var backgroundContainer:MovieClip = null;

        public var backgroundVignette:MovieClip = null;

        public var blackBG:MovieClip = null;

        public var loadingProgress:LoadingContainer = null;

        public var blackOverlay:MovieClip = null;

        public var btnLeft:MovieClip = null;

        public var btnRight:MovieClip = null;

        public var stepperBar:StepperContainer = null;

        private var _inited:Boolean = false;

        private var _imageGoRight:Boolean;

        private var _tutorialPageList:Vector.<TutorialPageContainer>;

        private var _picIndex:int = 0;

        private var _introData:BCIntroVideoVO = null;

        private var _playerOriginalWidth:Number;

        private var _playerOriginalHeight:Number;

        private var _playerOriginalScaleX:Number;

        private var _playerOriginalScaleY:Number;

        private var _useBigPictures:Boolean = false;

        private var _tweens:Vector.<Tween>;

        private var _stageClickInited:Boolean = false;

        public function BCIntroVideoPage()
        {
            this._tutorialPageList = new Vector.<TutorialPageContainer>();
            this._tweens = new Vector.<Tween>();
            super();
            focusable = true;
        }

        override public function updateStage(param1:Number, param2:Number) : void
        {
            invalidate(STAGE_RESIZED);
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.closeBtn.label = BOOTCAMP.BTN_TUTORIAL_CLOSE;
            this.closeBtn.visible = false;
            if(this.videoPlayer != null)
            {
                this.videoPlayer.addEventListener(VideoPlayerEvent.PLAYBACK_STOPPED,this.onVideoPlayerPlaybackStoppedHandler,false,0,true);
                this.videoPlayer.addEventListener(VideoPlayerStatusEvent.ERROR,this.onVideoPlayerErrorHandler,false,0,true);
                this.videoPlayer.addEventListener(VideoPlayerStatusEvent.STATUS_CHANGED,this.onVideoPlayerStatusChangedHandler,false,0,true);
                this._playerOriginalWidth = this.videoPlayer.width;
                this._playerOriginalHeight = this.videoPlayer.height;
                this._playerOriginalScaleX = this.videoPlayer.scaleX;
                this._playerOriginalScaleY = this.videoPlayer.scaleY;
            }
            this.introPage.logoDescription = BOOTCAMP.WELLCOME_BOOTCAMP_DESCRIPTION;
            this.introPage.setReferralVisibility(false);
            this.loadingProgress.skipLabel = BOOTCAMP.BTN_TUTORIAL_SKIP;
            this.blackOverlay.alpha = 0;
        }

        override protected function draw() : void
        {
            super.draw();
            if(this._introData && isInvalid(INTRO_INFO_CHANGED))
            {
                this.btnLeft.visible = this.btnRight.visible = this._introData.navigationButtonsVisible;
                this.loadingProgress.selectLabel = this._introData.selectButtonLabel;
                if(this._introData.navigationButtonsVisible)
                {
                    if(!this._stageClickInited)
                    {
                        this._stageClickInited = true;
                        App.stage.addEventListener(MouseEvent.CLICK,this.onStageClickHandler);
                    }
                }
                this.videoPlayer.visible = this._introData.videoPlayerVisible;
                if(this._introData.videoPlayerVisible)
                {
                    this.videoPlayer.bufferTime = this._introData.bufferTime;
                    this.videoPlayer.source = this._introData.source;
                }
                else
                {
                    this.disposePlayer();
                    videoFinishedS();
                }
            }
            if(isInvalid(STAGE_RESIZED))
            {
                this.updateUIPosition();
            }
        }

        override protected function onDispose() : void
        {
            var _loc1_:Tween = null;
            App.stage.removeEventListener(MouseEvent.CLICK,this.onStageClickHandler);
            this.closeBtn.removeEventListener(MouseEvent.CLICK,this.onSkipButtonClickHandler);
            this.disposePlayer();
            this.disposeBackgroundRenderers();
            this.stepperBar.dispose();
            this.stepperBar = null;
            this.closeBtn.dispose();
            this.closeBtn = null;
            this._tutorialPageList = null;
            this.introPage.dispose();
            this.introPage = null;
            this.backgroundContainer = null;
            this.backgroundVignette = null;
            this.blackBG = null;
            this.blackOverlay = null;
            this.btnLeft = null;
            this.btnRight = null;
            for each(_loc1_ in this._tweens)
            {
                _loc1_.onComplete = null;
                _loc1_.onChange = null;
                _loc1_.paused = true;
                _loc1_.dispose();
                _loc1_ = null;
            }
            this._tweens.splice(0,this._tweens.length);
            this._tweens = null;
            this.loadingProgress.btnSelect.removeEventListener(MouseEvent.CLICK,this.onSelectButtonClickHandler);
            this.loadingProgress.btnSkip.removeEventListener(MouseEvent.CLICK,this.onSkipButtonClickHandler);
            this.loadingProgress.dispose();
            this.loadingProgress = null;
            this._introData = null;
            super.onDispose();
        }

        override protected function playVideo(param1:BCIntroVideoVO) : void
        {
            this._introData = param1;
            invalidate(INTRO_INFO_CHANGED);
        }

        public function as_loaded() : void
        {
            this.loadingProgress.gotoAndStop(this.loadingProgress.totalFrames);
            if(this._introData)
            {
                this.loadingProgress.selectButtonVisible = !this._introData.autoStart;
                this.loadingProgress.skipButtonVisible = this._introData.allowSkipButton;
                this.loadingProgress.btnSelect.addEventListener(MouseEvent.CLICK,this.onSelectButtonClickHandler);
                this.loadingProgress.btnSkip.addEventListener(MouseEvent.CLICK,this.onSkipButtonClickHandler);
                this.closeBtn.visible = this._introData.isReferralEnabled && this._introData.isBootcampCloseEnabled;
                this.introPage.referralDescription = this._introData.referralDescription;
                if(this.closeBtn.visible)
                {
                    this.closeBtn.addEventListener(MouseEvent.CLICK,this.onSkipButtonClickHandler);
                }
                this.introPage.setReferralVisibility(this._introData.isReferralEnabled);
                if(this._introData.autoStart)
                {
                    this.continueToBattle();
                }
            }
        }

        public function as_showIntroPage(param1:Boolean) : void
        {
            this.introPage.visible = param1;
        }

        public function as_updateProgress(param1:Number) : void
        {
            var _loc2_:int = param1 * FULL_PROGRESS;
            if(this.loadingProgress.currentFrame < this.loadingProgress.totalFrames)
            {
                this.loadingProgress.gotoAndStop(_loc2_ + 1);
            }
        }

        public function as_pausePlayback() : void
        {
            this.videoPlayer.pausePlayback();
        }

        public function as_resumePlayback() : void
        {
            this.videoPlayer.resumePlayback();
        }

        protected function disposePlayer() : void
        {
            if(this.videoPlayer)
            {
                this.videoPlayer.removeEventListener(VideoPlayerStatusEvent.STATUS_CHANGED,this.onVideoPlayerStatusChangedHandler);
                this.videoPlayer.removeEventListener(VideoPlayerEvent.PLAYBACK_STOPPED,this.onVideoPlayerPlaybackStoppedHandler);
                this.videoPlayer.removeEventListener(VideoPlayerStatusEvent.ERROR,this.onVideoPlayerErrorHandler);
                this.videoPlayer.dispose();
                this.videoPlayer = null;
            }
        }

        private function disposeBackgroundRenderers() : void
        {
            var _loc3_:TutorialPageContainer = null;
            var _loc1_:int = this._tutorialPageList.length;
            var _loc2_:* = 0;
            while(_loc2_ < _loc1_)
            {
                _loc3_ = this._tutorialPageList[_loc2_];
                _loc3_.dispose();
                _loc2_++;
            }
            this._tutorialPageList.splice(0,this._tutorialPageList.length);
        }

        private function createImagesList() : void
        {
            var _loc4_:BCTutorialPageVO = null;
            var _loc5_:TutorialPageContainer = null;
            this._inited = true;
            if(this._tutorialPageList.length)
            {
                this.disposeBackgroundRenderers();
            }
            var _loc1_:Vector.<BCTutorialPageVO> = this._useBigPictures?this._introData.lessonPagesBigData:this._introData.lessonPagesSmallData;
            var _loc2_:int = _loc1_.length;
            var _loc3_:uint = 0;
            while(_loc3_ < _loc2_)
            {
                _loc4_ = _loc1_[_loc3_];
                _loc5_ = App.utils.classFactory.getComponent(_loc4_.rendererLinkage,TutorialPageContainer);
                _loc5_.setData(_loc4_);
                this._tutorialPageList.push(_loc5_);
                _loc3_++;
            }
            if(_loc2_ > 1)
            {
                this.stepperBar.setCount(_loc2_);
            }
        }

        private function updateUIPosition() : void
        {
            var _loc2_:* = 0;
            var _loc4_:* = NaN;
            var _loc1_:int = App.appWidth;
            _loc2_ = App.appHeight;
            if(this.videoPlayer != null)
            {
                if(_loc1_ / _loc2_ > this._playerOriginalWidth / this._playerOriginalHeight)
                {
                    _loc4_ = _loc1_ / this._playerOriginalWidth;
                    this.videoPlayer.scaleX = this._playerOriginalScaleX * _loc4_;
                    this.videoPlayer.scaleY = this._playerOriginalScaleY * _loc4_;
                }
                else
                {
                    _loc4_ = _loc2_ / this._playerOriginalHeight;
                    this.videoPlayer.scaleX = this._playerOriginalScaleX * _loc4_;
                    this.videoPlayer.scaleY = this._playerOriginalScaleY * _loc4_;
                }
                this.videoPlayer.x = _loc1_ - this.videoPlayer.width >> 1;
                this.videoPlayer.y = _loc2_ - this.videoPlayer.height >> 1;
            }
            this.loadingProgress.x = _loc1_ >> 1;
            this.loadingProgress.y = _loc2_;
            this.loadingProgress.setSize(_loc1_,_loc2_);
            var _loc3_:Boolean = _loc1_ >= SMALL_SCREEN_WIDTH && _loc2_ >= SMALL_SCREEN_HEIGHT;
            if(this._introData && this._introData.showTutorialPages)
            {
                if(this._useBigPictures != _loc3_ || !this._inited)
                {
                    this._useBigPictures = _loc3_;
                    this.createImagesList();
                    this.updateBackgroundRenderer();
                }
                this.backgroundContainer.x = -((this._useBigPictures?BACK_WIDTH_BIG:BACK_WIDTH_SMALL) - _loc1_ >> 1);
                this.backgroundContainer.y = -((this._useBigPictures?BACK_HEIGHT_SMALL:BACK_HEIGHT_BIG) - _loc2_ >> 1);
            }
            else
            {
                this.introPage.setSize(_loc1_,_loc2_);
            }
            this.backgroundVignette.width = _loc1_;
            this.backgroundVignette.height = _loc2_;
            this.backgroundVignette.x = 0;
            this.backgroundVignette.y = 0;
            this.blackBG.width = this.blackOverlay.width = _loc1_;
            this.blackBG.height = this.blackOverlay.height = _loc2_;
            this.blackBG.x = this.blackBG.x = 0;
            this.blackBG.y = this.blackBG.y = 0;
            this.btnLeft.x = BTN_PADDING;
            this.btnRight.x = App.appWidth - BTN_PADDING;
            this.btnLeft.y = this.btnRight.y = (App.appHeight >> 1) - (this.btnLeft.height >> 1);
            this.stepperBar.x = _loc1_ - this.stepperBar.width >> 1;
            this.closeBtn.validateNow();
            this.closeBtn.x = _loc1_ - this.closeBtn.width - CLOSE_BTN_PADDING_RIGHT;
        }

        private function updateBackgroundRenderer() : void
        {
            if(this.backgroundContainer.numChildren > 0)
            {
                this.backgroundContainer.removeChildAt(0);
            }
            this.backgroundContainer.addChild(this._tutorialPageList[this._picIndex]);
            this.stepperBar.selectItem(this._picIndex);
        }

        private function hideVideoPlayer() : void
        {
            var _loc1_:Tween = null;
            if(this.videoPlayer)
            {
                this.videoPlayer.visible = false;
                this.blackOverlay.alpha = 0;
                _loc1_ = new Tween(BLACK_FADE_DURATION,this.blackOverlay,{"alpha":0},{"ease":Strong.easeInOut});
                this._tweens.push(_loc1_);
            }
        }

        private function tweenFadeIn() : void
        {
            if(this._imageGoRight)
            {
                this._picIndex = this._picIndex < this._tutorialPageList.length - 1?this._picIndex + 1:0;
            }
            else
            {
                this._picIndex = this._picIndex > 0?this._picIndex - 1:this._tutorialPageList.length - 1;
            }
            this.updateBackgroundRenderer();
            var _loc1_:Tween = new Tween(OVERLAY_TWEEN_DURATION,this.blackOverlay,{"alpha":0},{"ease":Strong.easeOut});
            this._tweens.push(_loc1_);
        }

        private function onFadeOutTweenComplete() : void
        {
            this.tweenFadeIn();
        }

        private function tweenFadeOut() : void
        {
            var _loc1_:Tween = new Tween(OVERLAY_TWEEN_DURATION,this.blackOverlay,{"alpha":0},{
                "ease":Strong.easeIn,
                "onComplete":this.onFadeOutTweenComplete
            });
            this._tweens.push(_loc1_);
        }

        private function continueToBattle() : void
        {
            App.stage.removeEventListener(MouseEvent.CLICK,this.onStageClickHandler);
            goToBattleS();
        }

        private function onStageClickHandler(param1:MouseEvent) : void
        {
            if(!this._introData.showTutorialPages)
            {
                this.continueToBattle();
            }
            else
            {
                if(stage.mouseX > App.appWidth >> 1)
                {
                    this._imageGoRight = true;
                }
                else if(stage.mouseX < App.appWidth >> 1)
                {
                    this._imageGoRight = false;
                }
                this.tweenFadeOut();
            }
        }

        private function onSelectButtonClickHandler(param1:MouseEvent) : void
        {
            this.loadingProgress.btnSelect.removeEventListener(MouseEvent.CLICK,this.onSelectButtonClickHandler);
            this.continueToBattle();
        }

        private function onSkipButtonClickHandler(param1:MouseEvent) : void
        {
            this.loadingProgress.btnSkip.removeEventListener(MouseEvent.CLICK,this.onSkipButtonClickHandler);
            skipBootcampS();
        }

        private function onVideoPlayerPlaybackStoppedHandler(param1:VideoPlayerEvent) : void
        {
            if(this.videoPlayer.source == this._introData.source)
            {
                videoFinishedS();
                if(!StringUtils.isNotEmpty(this._introData.backgroundVideo))
                {
                    this.hideVideoPlayer();
                }
            }
            this.handleBackgroundVideo();
        }

        private function handleBackgroundVideo() : void
        {
            if(StringUtils.isNotEmpty(this._introData.backgroundVideo))
            {
                if(this.videoPlayer.source != this._introData.backgroundVideo)
                {
                    setChildIndex(this.videoPlayer,getChildIndex(this.introPage));
                    this.videoPlayer.visible = true;
                    this.videoPlayer.source = this._introData.backgroundVideo;
                    this.videoPlayer.isLoop = true;
                }
            }
        }

        private function onVideoPlayerStatusChangedHandler(param1:VideoPlayerStatusEvent) : void
        {
            if(this.videoPlayer.status == PlayerStatus.PLAYING)
            {
                this.videoPlayer.removeEventListener(VideoPlayerStatusEvent.STATUS_CHANGED,this.onVideoPlayerStatusChangedHandler);
                videoStartedS();
                this.videoPlayer.seek(0);
            }
        }

        private function onVideoPlayerErrorHandler(param1:VideoPlayerStatusEvent) : void
        {
            handleErrorS(param1.errorCode);
            this.hideVideoPlayer();
        }
    }
}
