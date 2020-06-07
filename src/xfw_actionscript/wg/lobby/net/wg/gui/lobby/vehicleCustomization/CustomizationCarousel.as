package net.wg.gui.lobby.vehicleCustomization
{
    import net.wg.gui.components.carousels.ScrollCarousel;
    import net.wg.infrastructure.interfaces.IFocusChainContainer;
    import net.wg.gui.lobby.vehicleCustomization.controls.magneticTool.IMagneticClickHandler;
    import flash.text.TextField;
    import net.wg.gui.components.controls.ScrollBarBookmarked;
    import net.wg.gui.components.carousels.interfaces.IFilterCounter;
    import flash.display.MovieClip;
    import net.wg.gui.components.carousels.filters.TankCarouselFilters;
    import net.wg.infrastructure.base.UIComponentEx;
    import net.wg.data.ListDAAPIDataProvider;
    import net.wg.gui.lobby.vehicleCustomization.data.customizationPanel.CustomizationCarouselDataVO;
    import flash.text.TextFieldAutoSize;
    import net.wg.gui.components.controls.events.RendererEvent;
    import flash.events.Event;
    import flash.geom.Rectangle;
    import net.wg.gui.lobby.vehicleCustomization.data.customizationPanel.CustomizationCarouselBookmarkVO;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.gui.components.carousels.HorizontalScroller;
    import net.wg.data.managers.impl.ToolTipParams;
    import net.wg.gui.lobby.vehicleCustomization.data.customizationPanel.CustomizationCarouselRendererVO;
    import flash.display.InteractiveObject;
    import net.wg.data.constants.Values;
    import net.wg.data.VO.TankCarouselFilterSelectedVO;
    import net.wg.data.VO.TankCarouselFilterInitVO;
    import net.wg.gui.lobby.vehicleCustomization.data.customizationPanel.CustomizationCarouselFilterVO;
    import flash.events.MouseEvent;
    import flash.display.DisplayObject;
    import net.wg.gui.lobby.vehicleCustomization.controls.CarouselItemRenderer;
    import net.wg.gui.lobby.vehicleCustomization.events.CustomizationEvent;

    public class CustomizationCarousel extends ScrollCarousel implements IFocusChainContainer, IMagneticClickHandler
    {

        private static const NORMAL_ITEM_GAP:Number = 20;

        private static const MIN_RES_ITEM_GAP:Number = 16;

        private static const MASK_SIDE_OFFSET:int = -10;

        private static const MASK_TOP_OFFSET:int = -25;

        private static const OFFSET_ARROW:int = 14;

        private static const BOOKMARKS_COEFFICIENT:int = 4;

        private static const EXTRA_OFFSET:int = 79;

        private static const SCROLL_Y_OFFSET:int = 10;

        private static const MIN_RESOLUTION:int = 900;

        private static const FILTERS_GAP_OFFSET:int = -5;

        private static const BOOK_MARK_BACK_MOVIE:String = "BookmarkBackingUI";

        private static const GO_TO_OFFSET:Number = 0.5;

        private static const GO_TO_DURATION:Number = 1;

        private static const BOOKMARK_START_OFFSET:int = 5;

        private static const HIT_AREA_HEIGHT:int = 116;

        private static const HIT_AREA_HEIGHT_MIN:int = 95;

        public var lblMessage:TextField = null;

        public var scrollBar:ScrollBarBookmarked = null;

        public var filterCounter:IFilterCounter = null;

        public var dragBlocker:MovieClip = null;

        public var carouselFilters:TankCarouselFilters = null;

        public var projectionDecalHint:UIComponentEx = null;

        public var editableStyleHint:UIComponentEx = null;

        public var progressionDecalHint:UIComponentEx = null;

        private var _layoutController:CustomizationCarouselLayoutController = null;

        private var _bookmarkBackings:Vector.<MovieClip>;

        private var _dataProvider:ListDAAPIDataProvider = null;

        private var _data:CustomizationCarouselDataVO = null;

        private var _oldWidth:Number = 0;

        private var _isMinResolution:Boolean;

        public function CustomizationCarousel()
        {
            this._bookmarkBackings = new Vector.<MovieClip>();
            super();
            roundCountRenderer = false;
        }

        override protected function configUI() : void
        {
            super.configUI();
            scrollList.hasHorizontalElasticEdges = true;
            scrollList.snapScrollPositionToItemRendererSize = false;
            scrollList.horizontalGap = NORMAL_ITEM_GAP;
            scrollList.snapToPages = true;
            scrollList.goToOffset = GO_TO_OFFSET;
            scrollList.goToDuration = GO_TO_DURATION;
            scrollList.cropContent = true;
            scrollList.maskOffsetLeft = scrollList.maskOffsetRight = MASK_SIDE_OFFSET;
            scrollList.maskOffsetTop = MASK_TOP_OFFSET;
            scrollList.showRendererOnlyIfDataExists = true;
            this.lblMessage.autoSize = TextFieldAutoSize.LEFT;
            this._layoutController = new CustomizationCarouselLayoutController(scrollList);
            scrollList.setLayoutController(this._layoutController);
            scrollList.setScrollbar(this.scrollBar);
            this.scrollBar.setBookmarkStartOffset(BOOKMARK_START_OFFSET);
            this.carouselFilters.addEventListener(RendererEvent.ITEM_CLICK,this.onCarouselFiltersItemClickHandler);
            this.carouselFilters.addEventListener(Event.RESIZE,this.onCarouselFiltersResizeHandler);
        }

        override protected function onDispose() : void
        {
            this._dataProvider.removeEventListener(Event.CHANGE,this.onDataProviderChangeHandler);
            this.carouselFilters.removeEventListener(Event.RESIZE,this.onCarouselFiltersResizeHandler);
            this.carouselFilters.removeEventListener(RendererEvent.ITEM_CLICK,this.onCarouselFiltersItemClickHandler);
            this._bookmarkBackings.splice(0,this._bookmarkBackings.length);
            this._bookmarkBackings = null;
            this.scrollBar.dispose();
            this.scrollBar = null;
            this.carouselFilters.dispose();
            this.carouselFilters = null;
            this.lblMessage = null;
            this.filterCounter.dispose();
            this.filterCounter = null;
            this.projectionDecalHint.dispose();
            this.projectionDecalHint = null;
            this.editableStyleHint.dispose();
            this.editableStyleHint = null;
            this.progressionDecalHint.dispose();
            this.progressionDecalHint = null;
            this._dataProvider.cleanUp();
            this._dataProvider = null;
            this._layoutController.dispose();
            this._layoutController = null;
            this._data = null;
            this.dragBlocker = null;
            super.onDispose();
        }

        override protected function updateLayout(param1:int, param2:int = 0) : void
        {
            var _loc3_:* = 0;
            var _loc4_:* = 0;
            var _loc6_:Rectangle = null;
            _loc3_ = param2 + OFFSET_ARROW + EXTRA_OFFSET;
            _loc4_ = param1 - _loc3_ - OFFSET_ARROW;
            var _loc5_:int = _loc4_ + leftArrowOffset - rightArrowOffset;
            this.lblMessage.x = (_loc4_ - this.lblMessage.textWidth >> 1) + _loc3_;
            super.updateLayout(_loc4_,(_loc4_ - _loc5_ >> 1) + _loc3_);
            this.scrollBar.setVisibleBookmarks(scrollList.viewPort.width / _loc4_ > BOOKMARKS_COEFFICIENT);
            this.dragBlocker.width = param1;
            if(hasScrollButtons)
            {
                _loc6_ = CustomizationShared.computeItemSize(false,this._isMinResolution);
                leftArrow.height = _loc6_.height;
                rightArrow.height = _loc6_.height;
            }
            this.scrollBar.width = scrollList.width;
            this.scrollBar.x = scrollList.x;
            this.scrollBar.y = leftArrow.y + leftArrow.height + SCROLL_Y_OFFSET;
            this.projectionDecalHint.x = this.editableStyleHint.x = this.progressionDecalHint.x = scrollList.x;
            this.projectionDecalHint.y = this.editableStyleHint.y = this.progressionDecalHint.y = scrollList.y;
            this.projectionDecalHint.width = this.editableStyleHint.width = this.progressionDecalHint.width = scrollList.width;
            this.projectionDecalHint.height = this.editableStyleHint.height = this.progressionDecalHint.height = this._isMinResolution?HIT_AREA_HEIGHT_MIN:HIT_AREA_HEIGHT;
            this.carouselFilters.gapOffset = int(this._isMinResolution) * FILTERS_GAP_OFFSET;
        }

        override protected function updateAvailableScroll(param1:Boolean, param2:Boolean) : void
        {
            super.updateAvailableScroll(param1,param2);
            leftArrow.visible = rightArrow.visible = param1 || param2;
            if(!param1 && !param2)
            {
                this.scrollBar.clearBookmarks();
            }
        }

        override protected function scrollListResizeComplete() : void
        {
            super.scrollListResizeComplete();
            invalidateSize();
            this._layoutController.invalidateData();
        }

        override protected function draw() : void
        {
            var _loc2_:Vector.<Rectangle> = null;
            var _loc3_:Vector.<Rectangle> = null;
            var _loc4_:* = 0;
            var _loc5_:* = 0;
            var _loc6_:MovieClip = null;
            var _loc7_:CustomizationCarouselBookmarkVO = null;
            var _loc8_:CustomizationCarouselBookmarkVO = null;
            var _loc9_:* = 0;
            var _loc10_:* = 0;
            var _loc11_:Rectangle = null;
            var _loc12_:* = false;
            var _loc13_:* = 0;
            super.draw();
            var _loc1_:* = App.appHeight < MIN_RESOLUTION;
            if((this._oldWidth != _width || this._isMinResolution != _loc1_) && isInvalid(InvalidationType.SIZE))
            {
                this._oldWidth = _width;
                this._isMinResolution = _loc1_;
                scrollList.horizontalGap = _loc1_?MIN_RES_ITEM_GAP:NORMAL_ITEM_GAP;
                this._dataProvider.dispatchEvent(new Event(Event.CHANGE));
            }
            if(this._data != null && scrollList.viewPort != null && isInvalid(InvalidationType.DATA))
            {
                this.scrollBar.clearBookmarks();
                _loc2_ = this._layoutController.getLayout();
                _loc3_ = this._layoutController.getBookmarksLayout();
                _loc4_ = Math.min(_loc3_.length,this._data.bookmarks.length);
                _loc5_ = _loc2_.length;
                for each(_loc6_ in this._bookmarkBackings)
                {
                    HorizontalScroller(scrollList).removeUnmanagedChild(_loc6_);
                    _loc6_.visible = false;
                    _loc6_ = null;
                }
                this._bookmarkBackings.splice(0,this._bookmarkBackings.length);
                _loc11_ = null;
                _loc12_ = false;
                _loc13_ = 0;
                while(_loc13_ < _loc4_)
                {
                    _loc7_ = this._data.bookmarks[_loc13_];
                    _loc9_ = _loc7_.bookmarkIndex;
                    if(_loc9_ < 0)
                    {
                        _loc9_ = _loc5_ - 1;
                    }
                    if(_loc9_ < _loc5_)
                    {
                        _loc11_ = _loc2_[_loc9_];
                        if(_loc13_ + 1 < _loc4_)
                        {
                            _loc8_ = this._data.bookmarks[_loc13_ + 1];
                            if(_loc8_)
                            {
                                _loc10_ = _loc8_.bookmarkIndex;
                            }
                        }
                        _loc12_ = Boolean(_loc10_ == _loc9_ + 1);
                        this.addBookmarkItem(_loc3_[_loc13_],_loc7_,_loc12_);
                        this.scrollBar.addBookmark(_loc11_.right,TOOLTIPS.CUSTOMIZATION_SCROLLBAR_BOOKMARK,new ToolTipParams({"bookmark":_loc7_.bookmarkName}));
                    }
                    _loc10_ = _loc9_;
                    _loc13_++;
                }
                this.scrollBar.validateNow();
                if(_loc5_ > 0)
                {
                    pageWidth = _loc2_[0].width + horizontalGap;
                }
                this.lblMessage.visible = _loc5_ == 0;
                scrollList.visible = true;
                this.carouselFilters.updateHotFilterSelectedFromData = false;
            }
        }

        public function getDataProvider() : Object
        {
            if(this._dataProvider == null)
            {
                this._dataProvider = new ListDAAPIDataProvider(CustomizationCarouselRendererVO);
                scrollList.dataProvider = this._dataProvider;
                this._dataProvider.addEventListener(Event.CHANGE,this.onDataProviderChangeHandler);
            }
            return this._dataProvider;
        }

        public function getFocusChain() : Vector.<InteractiveObject>
        {
            var _loc1_:Vector.<InteractiveObject> = new Vector.<InteractiveObject>();
            if(visible)
            {
                _loc1_.push(this.carouselFilters,scrollList);
            }
            return _loc1_;
        }

        public function playFilterBlink() : void
        {
            this.filterCounter.blink();
        }

        public function selectSlot(param1:int, param2:Boolean = false) : CustomizationCarouselRendererVO
        {
            var _loc3_:CustomizationCarouselRendererVO = null;
            var _loc4_:int = this._dataProvider.length;
            var _loc5_:* = 0;
            while(_loc5_ < _loc4_)
            {
                _loc3_ = CustomizationCarouselRendererVO(this._dataProvider.requestItemAt(_loc5_));
                if(_loc3_.intCD == param1)
                {
                    selectedIndex = _loc5_;
                    goToItem(selectedIndex,param2);
                    return _loc3_;
                }
                _loc5_++;
            }
            selectedIndex = -1;
            return _loc3_;
        }

        public function clearSelected() : void
        {
            selectedIndex = Values.DEFAULT_INT;
        }

        public function setCarouselFiltersData(param1:TankCarouselFilterSelectedVO) : void
        {
            this.carouselFilters.setSelectedData(param1);
            this.updatePopoverData();
        }

        public function setCarouselFiltersInitData(param1:TankCarouselFilterInitVO) : void
        {
            this.carouselFilters.initData(param1);
            this.updatePopoverData();
        }

        public function setData(param1:CustomizationCarouselDataVO) : void
        {
            if(param1 != null && this._data != param1)
            {
                this._data = param1;
                if(this._layoutController)
                {
                    this._layoutController.setData(param1);
                    invalidateData();
                    invalidateSize();
                }
                if(this._data.shouldShow)
                {
                    this.filterCounter.setCount(param1.displayString,param1.isZeroCount);
                }
                else
                {
                    this.filterCounter.hide();
                }
                this.updatePopoverData();
            }
        }

        public function setFilterData(param1:CustomizationCarouselFilterVO) : void
        {
            var _loc2_:Object = {
                "purchasedEnabled":param1.purchasedEnabled,
                "historicEnabled":param1.historicEnabled,
                "nonHistoricEnabled":param1.nonHistoricEnabled,
                "appliedEnabled":param1.appliedEnabled,
                "groups":param1.groups,
                "selectedGroup":param1.selectedGroup,
                "groupCount":param1.groupCount,
                "formfactorGroups":param1.formfactorGroups,
                "hideOnAnotherVehEnabled":param1.hideOnAnotherVehEnabled,
                "showOnlyProgressionDecalsEnabled":param1.showOnlyProgressionDecalsEnabled,
                "showOnlyEditableStylesEnabled":param1.showOnlyEditableStylesEnabled,
                "showOnlyNonEditableStylesEnabled":param1.showOnlyNonEditableStylesEnabled,
                "isInit":true
            };
            this.carouselFilters.popoverData = _loc2_;
        }

        public function setFilterMessage(param1:String) : void
        {
            this.lblMessage.htmlText = param1;
        }

        public function handleLeftClick(param1:MouseEvent) : Boolean
        {
            return DisplayObject(param1.target) is CarouselItemRenderer;
        }

        private function addBookmarkItem(param1:Rectangle, param2:CustomizationCarouselBookmarkVO, param3:Boolean) : void
        {
            var _loc4_:Class = App.instance.utils.classFactory.getClass(BOOK_MARK_BACK_MOVIE);
            var _loc5_:CustomizationCarouselBookmark = new _loc4_() as CustomizationCarouselBookmark;
            if(_loc5_ != null)
            {
                _loc5_.visible = true;
                HorizontalScroller(scrollList).addUnmanagedChild(_loc5_,0);
                _loc5_.width = param1.width;
                _loc5_.x = param1.x;
                _loc5_.y = param1.y;
                _loc5_.setBookmarkNameText(param2.bookmarkName,param3);
                this._bookmarkBackings.push(_loc5_);
            }
        }

        private function updateSelectedIndex() : void
        {
            selectedIndex = this._dataProvider.getDAAPIselectedIdx();
        }

        private function updatePopoverData() : void
        {
            dispatchEvent(new CustomizationEvent(CustomizationEvent.REFRESH_FILTER_DATA,false));
        }

        private function onCarouselFiltersItemClickHandler(param1:RendererEvent) : void
        {
            dispatchEvent(new CustomizationEvent(CustomizationEvent.SELECT_HOT_FILTER,this.carouselFilters.listHotFilter.getRendererAt(param1.index).selectable,param1.index));
            this.updatePopoverData();
            scrollList.moveToHorizontalScrollPosition(0);
        }

        private function onCarouselFiltersResizeHandler(param1:Event) : void
        {
            this.carouselFilters.y = leftArrow.y + (leftArrow.height - this.carouselFilters.height >> 1);
        }

        private function onDataProviderChangeHandler(param1:Event) : void
        {
            invalidateData();
            if(this._layoutController != null)
            {
                this._layoutController.invalidateData();
            }
            this.updateSelectedIndex();
            this.updatePopoverData();
        }
    }
}
