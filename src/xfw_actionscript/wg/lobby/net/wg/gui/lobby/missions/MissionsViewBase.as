package net.wg.gui.lobby.missions
{
    import net.wg.infrastructure.base.meta.impl.MissionsViewBaseMeta;
    import net.wg.infrastructure.base.meta.IMissionsViewBaseMeta;
    import net.wg.infrastructure.interfaces.IViewStackContent;
    import net.wg.gui.lobby.missions.components.MissionsList;
    import net.wg.gui.components.controls.ScrollBar;
    import net.wg.gui.components.controls.UILoaderAlt;
    import flash.display.Sprite;
    import net.wg.gui.components.advanced.interfaces.IDummy;
    import scaleform.clik.interfaces.IDataProvider;
    import scaleform.clik.motion.Tween;
    import net.wg.gui.lobby.missions.data.MissionsPackVO;
    import flash.events.Event;
    import net.wg.gui.components.controls.events.ScrollEvent;
    import scaleform.clik.events.ListEvent;
    import net.wg.gui.components.advanced.events.DummyEvent;
    import net.wg.gui.events.UILoaderEvent;
    import flash.events.MouseEvent;
    import scaleform.clik.events.ComponentEvent;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.gui.components.advanced.vo.DummyVO;
    import net.wg.gui.lobby.missions.event.MissionViewEvent;
    import flash.display.InteractiveObject;
    import net.wg.data.constants.generated.MISSIONS_ALIASES;
    import fl.motion.easing.Cubic;
    import net.wg.gui.lobby.missions.data.MissionCardViewVO;
    import net.wg.data.ListDAAPIDataProvider;

    public class MissionsViewBase extends MissionsViewBaseMeta implements IMissionsViewBaseMeta, IViewStackContent
    {

        protected static const BIG_FADE_IN_DELAY:Number = 600;

        protected static const SMALL_FADE_IN_DELAY:Number = 250;

        private static const LIST_TOP_OFFSET:int = 70;

        private static const LIST_BOTTOM_OFFSET:int = 70;

        private static const LIST_MASK_TOP_OFFSET:int = 53;

        private static const ORIGINAL_BACKGROUND_ASPECT_RATIO:Number = 2;

        private static const INV_BACKGROUND_POSITION:String = "InvBackgroundPosition";

        private static const LINKAGE_IMAGE_RENDERER_UI:String = "MissionPackRendererUI";

        private static const DEFAULT_SCROLL_STEP:int = 7;

        private static const FADE_IN_DURATION:Number = 1500;

        private static const BOTTOM_BG_OFFSET:int = 1;

        public var list:MissionsList;

        public var scrollBar:ScrollBar;

        public var bgLoader:UILoaderAlt;

        public var bottomShadowBg:Sprite;

        public var dummy:IDummy;

        private var _questsDataProvider:IDataProvider;

        private var _scrollStepSize:int = 7;

        private var _ignoreScrollBarHandler:Boolean = false;

        private var _fadeInTween:Tween;

        protected var _hasBeenShownBefore:Boolean = false;

        public function MissionsViewBase()
        {
            super();
            addEventListener(ComponentEvent.SHOW,this.onShowHandler);
            this._questsDataProvider = new ListDAAPIDataProvider(this.dataProviderClass);
            this.list.itemRendererClassName = LINKAGE_IMAGE_RENDERER_UI;
            this.list.dataProvider = this._questsDataProvider;
        }

        protected function get dataProviderClass() : Class
        {
            return MissionsPackVO;
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.list.verticalScrollStep = this._scrollStepSize;
            this.list.maskOffsetTop = LIST_MASK_TOP_OFFSET;
            this.list.paddingTop = LIST_TOP_OFFSET;
            this.list.paddingBottom = LIST_BOTTOM_OFFSET;
            this.list.addEventListener(Event.SCROLL,this.onListScrollHandler);
            this.list.addEventListener(ScrollEvent.UPDATE_SIZE,this.onListUpdateSizeHandler);
            this.list.addEventListener(ListEvent.ITEM_CLICK,this.onListItemClickHandler);
            this.list.addEventListener(DummyEvent.CLICK,this.onDummyClickHandler);
            this.scrollBar.addEventListener(Event.SCROLL,this.onScrollBarScrollHandler);
            this.bgLoader.addEventListener(UILoaderEvent.COMPLETE,this.onBgLoaderCompleteHandler);
            this.bgLoader.addEventListener(MouseEvent.MOUSE_WHEEL,this.onBgLoaderMouseWheelHandler);
            this.bgLoader.autoSize = false;
            this.bottomShadowBg.mouseEnabled = false;
            this.dummy.addEventListener(DummyEvent.CLICK,this.onDummyClickHandler);
        }

        override protected function onDispose() : void
        {
            removeEventListener(ComponentEvent.SHOW,this.onShowHandler);
            this.list.removeEventListener(Event.SCROLL,this.onListScrollHandler);
            this.list.removeEventListener(ScrollEvent.UPDATE_SIZE,this.onListUpdateSizeHandler);
            this.list.removeEventListener(ListEvent.ITEM_CLICK,this.onListItemClickHandler);
            this.list.removeEventListener(DummyEvent.CLICK,this.onDummyClickHandler);
            this.list.dispose();
            this.list = null;
            this.scrollBar.removeEventListener(Event.SCROLL,this.onScrollBarScrollHandler);
            this.scrollBar.dispose();
            this.scrollBar = null;
            this.bgLoader.removeEventListener(MouseEvent.MOUSE_WHEEL,this.onBgLoaderMouseWheelHandler);
            this.bgLoader.removeEventListener(UILoaderEvent.COMPLETE,this.onBgLoaderCompleteHandler);
            this.bgLoader.dispose();
            this.bgLoader = null;
            this.dummy.removeEventListener(DummyEvent.CLICK,this.onDummyClickHandler);
            this.dummy.dispose();
            this.dummy = null;
            this._questsDataProvider.cleanUp();
            this._questsDataProvider = null;
            this.bottomShadowBg = null;
            this.clearFadeInTween();
            super.onDispose();
        }

        override protected function draw() : void
        {
            var _loc1_:* = false;
            super.draw();
            if(isInvalid(InvalidationType.SIZE))
            {
                this.updateSize();
                this.updateDummySize();
                invalidate(INV_BACKGROUND_POSITION);
            }
            if(isInvalid(INV_BACKGROUND_POSITION))
            {
                _loc1_ = _width / _height > ORIGINAL_BACKGROUND_ASPECT_RATIO;
                this.updateBgLoaderSize(_loc1_?_width:_height * ORIGINAL_BACKGROUND_ASPECT_RATIO,_loc1_?_width / ORIGINAL_BACKGROUND_ASPECT_RATIO:_height);
            }
        }

        override protected function showDummy(param1:DummyVO) : void
        {
            this.dummy.setData(param1);
            this.setDummyVisible(true);
        }

        public function as_getDP() : Object
        {
            return this._questsDataProvider;
        }

        public function as_hideDummy() : void
        {
            this.setDummyVisible(false);
        }

        public function as_scrollToItem(param1:String, param2:String) : void
        {
            this.list.scrollToItem(param1,param2);
        }

        public function as_setBackground(param1:String) : void
        {
            this.bgLoader.source = param1;
        }

        public function as_setWaitingVisible(param1:Boolean) : void
        {
            var _loc2_:MissionViewEvent = new MissionViewEvent(MissionViewEvent.SHOW_WAITING,true);
            _loc2_.isWaiting = param1;
            dispatchEvent(_loc2_);
        }

        public function canShowAutomatically() : Boolean
        {
            return true;
        }

        public function getComponentForFocus() : InteractiveObject
        {
            return this;
        }

        public function update(param1:Object) : void
        {
        }

        protected function updateSize() : void
        {
            var _loc1_:int = _width < MISSIONS_ALIASES.MISSION_RENDERER_WIDTH_SWITCH?MISSIONS_ALIASES.MISSION_RENDERER_WIDTH_SMALL:MISSIONS_ALIASES.MISSION_RENDERER_WIDTH_LARGE;
            var _loc2_:int = this.getHeight();
            this.list.setSize(_loc1_,_loc2_);
            this.list.x = _width - _loc1_ >> 1;
            this.scrollBar.height = _loc2_;
            this.scrollBar.x = width - this.scrollBar.width | 0;
            this.bottomShadowBg.width = _width - this.scrollBar.width | 0;
            this.bottomShadowBg.y = _loc2_ - this.bottomShadowBg.height + BOTTOM_BG_OFFSET | 0;
        }

        protected function updateDummySize() : void
        {
            this.dummy.width = _width;
            this.dummy.height = _height;
        }

        protected function getHeight() : int
        {
            return _height;
        }

        protected function handleShow() : void
        {
            this.clearFadeInTween();
            this.playFadeInTween();
        }

        private function updateBgLoaderSize(param1:int, param2:int) : void
        {
            this.bgLoader.width = param1;
            this.bgLoader.height = param2;
            this.bgLoader.x = _width - param1 >> 1;
            this.bgLoader.y = _height - param2 >> 1;
        }

        protected function getPageSize() : int
        {
            return this.list.height;
        }

        private function updateScrollBarProperties() : void
        {
            this.scrollBar.setScrollProperties(this.getPageSize(),0,this.list.maxVerticalScrollPosition,this._scrollStepSize);
            this.scrollBar.position = this.list.verticalScrollPosition;
            if(this.list.visible)
            {
                this.scrollBar.visible = this.list.maxVerticalScrollPosition != 0;
            }
        }

        private function clearFadeInTween() : void
        {
            if(this._fadeInTween)
            {
                this._fadeInTween.dispose();
                this._fadeInTween = null;
            }
        }

        protected function setFadeInTween(param1:int) : void
        {
            this._fadeInTween = new Tween(FADE_IN_DURATION,this,{"alpha":1},{
                "paused":false,
                "ease":Cubic.easeOut,
                "delay":param1,
                "onComplete":null
            });
            this._fadeInTween.fastTransform = false;
        }

        protected function playFadeInTween() : void
        {
            alpha = 0;
            var _loc1_:int = this._hasBeenShownBefore?SMALL_FADE_IN_DELAY:BIG_FADE_IN_DELAY;
            this.setFadeInTween(_loc1_);
            this._hasBeenShownBefore = true;
        }

        private function setDummyVisible(param1:Boolean) : void
        {
            this.dummy.visible = param1;
            this.list.visible = !param1;
            this.scrollBar.visible = !param1;
            this.bottomShadowBg.visible = !param1;
        }

        private function onDummyClickHandler(param1:DummyEvent) : void
        {
            dummyClickedS(param1.clickType);
        }

        private function onListScrollHandler(param1:Event) : void
        {
            this._ignoreScrollBarHandler = true;
            this.scrollBar.position = this.list.verticalScrollPosition;
            this._ignoreScrollBarHandler = false;
        }

        private function onListUpdateSizeHandler(param1:ScrollEvent) : void
        {
            this._ignoreScrollBarHandler = true;
            this.updateScrollBarProperties();
            this._ignoreScrollBarHandler = false;
        }

        private function onScrollBarScrollHandler(param1:Event) : void
        {
            if(!this._ignoreScrollBarHandler)
            {
                this.list.scrollTo(this.scrollBar.position);
            }
        }

        private function onListItemClickHandler(param1:ListEvent) : void
        {
            var _loc2_:MissionCardViewVO = MissionCardViewVO(param1.itemData);
            openMissionDetailsViewS(_loc2_.eventID,_loc2_.blockID);
        }

        private function onBgLoaderCompleteHandler(param1:Event) : void
        {
            invalidate(INV_BACKGROUND_POSITION);
        }

        private function onBgLoaderMouseWheelHandler(param1:MouseEvent) : void
        {
            this.list.dispatchEvent(param1.clone());
        }

        private function onShowHandler(param1:ComponentEvent) : void
        {
            this.handleShow();
        }
    }
}
