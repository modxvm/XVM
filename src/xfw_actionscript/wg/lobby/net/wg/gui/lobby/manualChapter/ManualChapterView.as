package net.wg.gui.lobby.manualChapter
{
    import net.wg.infrastructure.base.meta.impl.ManualChapterViewMeta;
    import net.wg.infrastructure.base.meta.IManualChapterViewMeta;
    import net.wg.gui.interfaces.ISoundButtonEx;
    import net.wg.gui.components.paginator.PaginationGroup;
    import flash.display.Sprite;
    import net.wg.gui.lobby.manualChapter.controls.ManualBackgroundContainer;
    import net.wg.gui.components.controls.UILoaderAlt;
    import net.wg.gui.bootcamp.interfaces.IAnimatedButtonRenderer;
    import net.wg.gui.lobby.manualChapter.data.ManualChapterContainerVO;
    import scaleform.clik.motion.Tween;
    import net.wg.gui.components.paginator.PaginatorArrowsController;
    import flash.display.InteractiveObject;
    import net.wg.data.constants.Values;
    import fl.motion.easing.Linear;
    import scaleform.clik.data.DataProvider;
    import net.wg.gui.components.paginator.vo.PaginatorPageNumVO;
    import net.wg.gui.lobby.manualChapter.data.ManualPageDetailedViewVO;
    import scaleform.clik.constants.InvalidationType;
    import fl.transitions.easing.Regular;
    import flash.geom.Point;
    import scaleform.clik.controls.Button;
    import flash.events.Event;
    import scaleform.clik.events.ButtonEvent;
    import net.wg.gui.lobby.manualChapter.events.ManualViewEvent;
    import scaleform.clik.events.InputEvent;
    import scaleform.clik.ui.InputDetails;
    import flash.ui.Keyboard;
    import scaleform.clik.constants.InputValue;
    import net.wg.gui.components.paginator.PaginationDetailsNumButton;

    public class ManualChapterView extends ManualChapterViewMeta implements IManualChapterViewMeta
    {

        private static const ARROW_BTN_GAP:int = 50;

        private static const INV_PAGE:String = "InvPage";

        private static const MANUAL_CHAPTER_GROUP:String = "ManualChapterGroup";

        private static const NUM_GAP:int = 50;

        private static const TOP_PANEL_HEIGHT:int = 34;

        private static const FADE_IN_DELAY:Number = 200;

        private static const FADE_IN_DURATION:Number = 400;

        private static const MIN_PAGES:int = 1;

        private static const VIEW_CENTER_OFFSET:int = 10;

        private static const CLOSE_BTN_PADDING:int = 40;

        private static const MIN_FULL_WIDTH:int = 1920;

        private static const MIN_FULL_HEIGHT:int = 926;

        private static const SMALL_SCALE:Number = 0.7;

        private static const FULL_SCALE:int = 1;

        private static const TWEEN_DURATION:int = 300;

        private static const RIGHT_TWEEN_HEIGHT_OFFSET:int = 340;

        private static const LEFT_TWEEN_HEIGHT_OFFSET:int = 110;

        private static const SWAP_ROTATION:int = 15;

        private static const STACK_IMAGE_OFFSET:int = 80;

        private static const IN_LABEL:String = "in";

        private static const OUT_LABEL:String = "out";

        public var view:ManualPageView;

        public var arrowLeftBtn:ISoundButtonEx;

        public var arrowRightBtn:ISoundButtonEx;

        public var pageButtons:PaginationGroup;

        public var bg:Sprite;

        public var pageBackground:ManualBackgroundContainer;

        public var prevBackground:ManualBackgroundContainer;

        public var stackBackground:UILoaderAlt;

        public var btnClose:IAnimatedButtonRenderer = null;

        private var _data:ManualChapterContainerVO;

        private var _currentMissionIndex:int = -1;

        private var _fadeTween:Tween;

        private var _bgFadeTween:Tween;

        private var _swapTween1:Tween;

        private var _swapTween2:Tween;

        private var _goRight:Boolean = false;

        private var _viewOpacity:Number = 1;

        private var _contentScale:Number = 1;

        private var _isNewPage:Boolean = false;

        private var _pageController:PaginatorArrowsController = null;

        public function ManualChapterView()
        {
            super();
        }

        override public function updateStage(param1:Number, param2:Number) : void
        {
            this._contentScale = param1 >= MIN_FULL_WIDTH && param2 >= MIN_FULL_HEIGHT?FULL_SCALE:SMALL_SCALE;
            this.view.updateScaleFactor(this._contentScale);
            setSize(param1,param2);
        }

        override protected function onInitModalFocus(param1:InteractiveObject) : void
        {
            super.onInitModalFocus(param1);
            setFocus(this);
        }

        override protected function setInitData(param1:ManualChapterContainerVO) : void
        {
            this._data = param1;
            invalidateData();
        }

        override protected function onDispose() : void
        {
            this.removeListeners();
            this.pageBackground.dispose();
            this.pageBackground = null;
            this.prevBackground.dispose();
            this.prevBackground = null;
            this._data = null;
            this.view.dispose();
            this.view = null;
            this.stackBackground.dispose();
            this.stackBackground = null;
            this.arrowLeftBtn.dispose();
            this.arrowLeftBtn = null;
            this.arrowRightBtn.dispose();
            this.arrowRightBtn = null;
            this.pageButtons.dispose();
            this.pageButtons = null;
            this.bg = null;
            this._bgFadeTween.dispose();
            this._bgFadeTween = null;
            if(this._fadeTween)
            {
                this._fadeTween.dispose();
                this._fadeTween = null;
            }
            this.btnClose.dispose();
            this.btnClose = null;
            this.clearTweens();
            this._pageController.dispose();
            this._pageController = null;
            super.onDispose();
        }

        override protected function configUI() : void
        {
            super.configUI();
            this._pageController = new PaginatorArrowsController(this,this.pageButtons,this.arrowLeftBtn,this.arrowRightBtn,MANUAL_CHAPTER_GROUP,Values.ZERO,true);
            this.viewOpacity = 0;
            this.bg.alpha = 0;
            this._bgFadeTween = new Tween(FADE_IN_DURATION,this.bg,{"alpha":1},{
                "paused":false,
                "ease":Linear.easeOut
            });
            this.addListeners();
        }

        override protected function draw() : void
        {
            var _loc1_:DataProvider = null;
            var _loc2_:* = 0;
            var _loc3_:PaginatorPageNumVO = null;
            var _loc4_:* = 0;
            var _loc5_:ManualPageDetailedViewVO = null;
            super.draw();
            if(this._data != null && isInvalid(InvalidationType.DATA))
            {
                _loc1_ = this._data.pages;
                _loc2_ = _loc1_.length;
                if(_loc2_ > MIN_PAGES)
                {
                    this._pageController.setPages(_loc1_);
                    for each(_loc3_ in _loc1_)
                    {
                        if(_loc3_.selected)
                        {
                            this._currentMissionIndex = _loc3_.pageIndex;
                            break;
                        }
                    }
                }
                invalidate(INV_PAGE,InvalidationType.SIZE);
                this.playFadeInTween();
            }
            if(this._data != null && isInvalid(INV_PAGE))
            {
                this._pageController.setPageIndex(this._currentMissionIndex);
                _loc4_ = this._data.details.length;
                if(_loc4_ > this._currentMissionIndex)
                {
                    _loc5_ = this._data.details[this._currentMissionIndex];
                    if(_loc5_ != null)
                    {
                        if(this._isNewPage)
                        {
                            this.tweenBackground();
                            this.view.fadeOut();
                            this.btnClose.gotoAndPlay(OUT_LABEL);
                        }
                        else
                        {
                            this.view.fadeIn();
                            this.view.setData(_loc5_);
                            this.btnClose.gotoAndPlay(IN_LABEL);
                        }
                        this.pageBackground.imageSource = _loc5_.background;
                        this.pageBackground.backgroundSource = RES_ICONS.MAPS_ICONS_MANUAL_BACKGROUNDS_MANUAL_CARD_BACK;
                    }
                }
            }
            if(isInvalid(InvalidationType.SIZE))
            {
                this.updateLayout();
            }
        }

        override protected function onPopulate() : void
        {
            super.onPopulate();
            this.stackBackground.source = RES_ICONS.MAPS_ICONS_MANUAL_BACKGROUNDS_IMAGE_BACK;
        }

        public function as_showPage(param1:int) : void
        {
            this._goRight = param1 > this._currentMissionIndex;
            this.setPageIndex(param1);
        }

        private function setPageIndex(param1:int) : void
        {
            if(this._currentMissionIndex != param1)
            {
                this._isNewPage = this._currentMissionIndex != -1;
                this._currentMissionIndex = param1;
                invalidate(INV_PAGE);
            }
        }

        private function clearTweens() : void
        {
            if(this._swapTween1)
            {
                this._swapTween1.dispose();
                this._swapTween1 = null;
            }
            if(this._swapTween2)
            {
                this._swapTween2.dispose();
                this._swapTween2 = null;
            }
        }

        private function onSwapComplete() : void
        {
            this._pageController.allowPageChange = true;
            this._isNewPage = false;
            invalidateData();
        }

        private function swapBackgrounds() : void
        {
            swapChildren(this.prevBackground,this.pageBackground);
        }

        private function tweenBackground() : void
        {
            this._pageController.allowPageChange = false;
            var _loc1_:ManualBackgroundContainer = this.prevBackground;
            this.prevBackground = this.pageBackground;
            this.pageBackground = _loc1_;
            var _loc2_:ManualBackgroundContainer = this._goRight?this.prevBackground:this.pageBackground;
            this.clearTweens();
            var _loc3_:int = this.pageBackground.x;
            var _loc4_:int = this.pageBackground.y;
            var _loc5_:* = 0;
            var _loc6_:* = 0;
            var _loc7_:* = 0;
            if(this._goRight)
            {
                _loc7_ = SWAP_ROTATION;
                _loc5_ = this.pageBackground.x + this.pageBackground.width;
                _loc6_ = this.pageBackground.y - RIGHT_TWEEN_HEIGHT_OFFSET * this._contentScale;
            }
            else
            {
                _loc7_ = -SWAP_ROTATION;
                _loc5_ = this.pageBackground.x - this.pageBackground.width;
                _loc6_ = this.pageBackground.y - LEFT_TWEEN_HEIGHT_OFFSET * this._contentScale;
            }
            this._swapTween1 = new Tween(TWEEN_DURATION,_loc2_,{
                "x":_loc5_,
                "y":_loc6_,
                "rotation":_loc7_
            },{
                "onComplete":this.swapBackgrounds,
                "paused":false,
                "ease":Regular.easeIn
            });
            this._swapTween2 = new Tween(TWEEN_DURATION,_loc2_,{
                "x":_loc3_,
                "y":_loc4_,
                "rotation":0
            },{
                "onComplete":this.onSwapComplete,
                "delay":TWEEN_DURATION,
                "paused":false,
                "ease":Regular.easeOut
            });
            this._swapTween1.fastTransform = false;
            this._swapTween2.fastTransform = false;
        }

        private function updateLayout() : void
        {
            this.pageBackground.scaleX = this.pageBackground.scaleY = this._contentScale;
            this.prevBackground.scaleX = this.prevBackground.scaleY = this._contentScale;
            this.stackBackground.scaleX = this.stackBackground.scaleY = this._contentScale;
            this.view.x = width - this.view.width >> 1;
            this.view.y = (height - this.view.height >> 1) - VIEW_CENTER_OFFSET;
            this.pageBackground.x = width - this.pageBackground.width >> 1;
            this.pageBackground.y = (height - this.pageBackground.height >> 1) - VIEW_CENTER_OFFSET;
            this.prevBackground.x = this.pageBackground.x;
            this.prevBackground.y = this.pageBackground.y;
            var _loc1_:Number = STACK_IMAGE_OFFSET * this._contentScale | 0;
            this.stackBackground.x = this.pageBackground.x - _loc1_;
            this.stackBackground.y = this.pageBackground.y - _loc1_;
            this.btnClose.x = this.view.x + this.view.width - CLOSE_BTN_PADDING * this._contentScale | 0;
            this.btnClose.y = this.view.y + CLOSE_BTN_PADDING * this._contentScale | 0;
            this.arrowLeftBtn.height = this.arrowRightBtn.height = this.view.height;
            this.arrowLeftBtn.y = this.arrowRightBtn.y = this.view.y;
            var _loc2_:int = ARROW_BTN_GAP * this._contentScale;
            this.arrowLeftBtn.x = this.view.x - this.arrowLeftBtn.width - _loc2_;
            this.arrowRightBtn.x = this.view.x + this.view.width + this.arrowRightBtn.width + _loc2_;
            var _loc3_:Point = new Point(this.view.x + (this.view.width >> 1),this.view.y + this.view.height + NUM_GAP * this._contentScale);
            this._pageController.setPositions(_loc3_);
            this.bg.width = _width;
            this.bg.height = _height - TOP_PANEL_HEIGHT;
            this.bg.y = TOP_PANEL_HEIGHT;
        }

        private function addListeners() : void
        {
            var _loc1_:Button = this.btnClose.button;
            this._pageController.addEventListener(Event.CHANGE,this.onPageControllerChangeHandler);
            _loc1_.addEventListener(ButtonEvent.CLICK,this.onAnimatedButtonContentClickHandler);
            this.view.addEventListener(ManualViewEvent.BOOTCAMP_CLICKED,this.onViewBootcampClickedHandler);
        }

        private function removeListeners() : void
        {
            var _loc1_:Button = this.btnClose.button;
            this._pageController.removeEventListener(Event.CHANGE,this.onPageControllerChangeHandler);
            _loc1_.removeEventListener(ButtonEvent.CLICK,this.onAnimatedButtonContentClickHandler);
            this.view.removeEventListener(ManualViewEvent.BOOTCAMP_CLICKED,this.onViewBootcampClickedHandler);
        }

        private function playFadeInTween() : void
        {
            this._fadeTween = new Tween(FADE_IN_DURATION,this,{"viewOpacity":1},{
                "paused":false,
                "ease":Linear.easeOut,
                "delay":FADE_IN_DELAY
            });
        }

        public function get viewOpacity() : Number
        {
            return this._viewOpacity;
        }

        public function set viewOpacity(param1:Number) : void
        {
            this._viewOpacity = param1;
            this.arrowLeftBtn.alpha = this.arrowRightBtn.alpha = this.view.alpha = this._viewOpacity;
        }

        override public function handleInput(param1:InputEvent) : void
        {
            var _loc2_:InputDetails = param1.details;
            if(_loc2_.code == Keyboard.ESCAPE && _loc2_.value == InputValue.KEY_DOWN)
            {
                param1.handled = true;
                closeViewS();
            }
        }

        private function onViewBootcampClickedHandler(param1:ManualViewEvent) : void
        {
            bootcampButtonClickedS();
        }

        private function onAnimatedButtonContentClickHandler(param1:ButtonEvent) : void
        {
            closeViewS();
        }

        private function onPageControllerChangeHandler(param1:Event) : void
        {
            var _loc2_:int = PaginationDetailsNumButton(this._pageController.getSelectedButton()).pageIndex;
            this._goRight = _loc2_ > this._currentMissionIndex;
            this.setPageIndex(_loc2_);
        }
    }
}
