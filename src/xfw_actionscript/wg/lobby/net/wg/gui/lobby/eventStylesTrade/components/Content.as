package net.wg.gui.lobby.eventStylesTrade.components
{
    import net.wg.infrastructure.base.UIComponentEx;
    import net.wg.gui.components.carousels.interfaces.IScroller;
    import flash.display.MovieClip;
    import net.wg.data.ListDAAPIDataProvider;
    import net.wg.gui.lobby.eventStylesTrade.data.EventStylesTradeDataVO;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import net.wg.data.constants.Values;
    import net.wg.gui.lobby.eventStylesTrade.data.SkinVO;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.gui.lobby.eventStylesTrade.events.StylesTradeEvent;
    import scaleform.gfx.MouseEventEx;
    import net.wg.gui.lobby.vehicleCustomization.data.customizationPanel.CustomizationCarouselRendererVO;

    public class Content extends UIComponentEx
    {

        private static const NORMAL_ITEM_WIDTH:Number = 228;

        private static const MIN_RES_ITEM_WIDTH:Number = 180;

        private static const NORMAL_ITEM_GAP:Number = 20;

        private static const MIN_RES_ITEM_GAP:Number = 16;

        private static const SCROLL_Y_OFFSET:int = 7;

        private static const MIN_WIDTH_RESOLUTION:int = 1280;

        private static const MIN_HEIGHT_RESOLUTION:int = 900;

        private static const MIN_ITEM_HEIGHT:int = 82;

        private static const NORMAL_ITEM_HEIGHT:int = 104;

        private static const BUY_ITEM_OFFSET:int = -25;

        private static const BG_OFFSET:int = 10;

        private static const BG_EXTRA_HEIGHT:int = 50;

        private static const IS_SMALL_OFFSET:int = 35;

        public var scrollList:IScroller = null;

        public var buyItem:BottomBuyItem = null;

        public var simpleBg:MovieClip = null;

        public var carouselBg:MovieClip = null;

        public var authorInfo:AuthorInfoPanel = null;

        public var styleInfo:StyleInfoPanel = null;

        private var _dataProvider:ListDAAPIDataProvider;

        private var _data:EventStylesTradeDataVO = null;

        private var _screenWidth:int = -1;

        private var _screenHeight:int = -1;

        private var _offsetPanelY:int = 0;

        private var _isSmall:Boolean = false;

        private var _considerWidth:Boolean = false;

        public function Content()
        {
            this._dataProvider = new ListDAAPIDataProvider(CustomizationCarouselRendererVO);
            super();
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.scrollList.rendererWidth = NORMAL_ITEM_WIDTH;
            this.scrollList.horizontalGap = NORMAL_ITEM_GAP;
            this.scrollList.showRendererOnlyIfDataExists = true;
            this.scrollList.dataProvider = this._dataProvider;
            this._dataProvider.addEventListener(Event.CHANGE,this.onDataProviderChangeHandler);
            this.styleInfo.mouseEnabled = this.styleInfo.mouseChildren = this.authorInfo.mouseEnabled = this.authorInfo.mouseChildren = false;
            mouseEnabled = false;
            this.scrollList.addEventListener(MouseEvent.CLICK,this.onScrollListClickHandler,true);
        }

        public function setTouchScrollEnabled(param1:Boolean) : void
        {
            this.scrollList.touchScrollEnabled = param1;
        }

        public function setIsSmall(param1:Boolean) : void
        {
            if(this._isSmall != param1)
            {
                this._isSmall = param1;
                this._offsetPanelY = param1?IS_SMALL_OFFSET:Values.ZERO;
                invalidateSize();
            }
        }

        public function setScreenSize(param1:Number, param2:Number) : void
        {
            this._screenWidth = param1;
            this._screenHeight = param2;
            invalidateSize();
        }

        public function set considerWidth(param1:Boolean) : void
        {
            this._considerWidth = param1;
        }

        override protected function draw() : void
        {
            var _loc1_:SkinVO = null;
            var _loc2_:* = false;
            super.draw();
            if(isInvalid(InvalidationType.SIZE))
            {
                this.carouselBg.width = this._screenWidth;
                this.simpleBg.width = this._screenWidth;
                this.buyItem.x = this._screenWidth >> 1;
                this.styleInfo.x = this._screenWidth;
                this.authorInfo.y = this.styleInfo.y = (-this._screenHeight >> 1) + this._offsetPanelY;
            }
            if(this._data != null && isInvalid(InvalidationType.DATA))
            {
                this.authorInfo.visible = this._data.isShowAuthor;
                _loc1_ = this._data.skins[this.selectedIndex] as SkinVO;
                if(_loc1_)
                {
                    this.authorInfo.authorVisible = _loc1_.isShowAuthorImage;
                    this.authorInfo.setData(_loc1_.styleTitle,_loc1_.styleDescription);
                    this.styleInfo.setData(_loc1_);
                }
            }
            if(this._data != null && isInvalid(InvalidationType.DATA,InvalidationType.SIZE))
            {
                this.buyItem.setData(this._data.skins[this.selectedIndex],this._data.canBuyBundle,this._data.bundlePrice,this._data.bundleTooltip,this._data.bundleNotEnough);
                if(_baseDisposed)
                {
                    return;
                }
                if(this._dataProvider.length > Values.ZERO)
                {
                    _loc2_ = App.appHeight < MIN_HEIGHT_RESOLUTION;
                    if(this._considerWidth && !_loc2_)
                    {
                        _loc2_ = App.appWidth <= MIN_WIDTH_RESOLUTION;
                    }
                    this.scrollList.visible = true;
                    this.scrollList.rendererWidth = _loc2_?MIN_RES_ITEM_WIDTH:NORMAL_ITEM_WIDTH;
                    this.scrollList.horizontalGap = _loc2_?MIN_RES_ITEM_GAP:NORMAL_ITEM_GAP;
                    this._dataProvider.dispatchEvent(new Event(Event.CHANGE));
                    this.scrollList.validateNow();
                    this.scrollList.y = -(_loc2_?MIN_ITEM_HEIGHT:NORMAL_ITEM_HEIGHT) - SCROLL_Y_OFFSET;
                    this.scrollList.x = this._screenWidth - this.scrollList.viewPort.validWidth >> 1;
                    this.buyItem.y = this.scrollList.y + BUY_ITEM_OFFSET;
                    this.carouselBg.y = this.scrollList.y - BG_OFFSET;
                    this.carouselBg.height = -this.carouselBg.y + BG_EXTRA_HEIGHT;
                    this.simpleBg.y = this.carouselBg.y;
                }
                else
                {
                    this.scrollList.visible = false;
                    this.simpleBg.y = Values.ZERO;
                    this.carouselBg.y = Values.ZERO;
                    this.carouselBg.height = BG_EXTRA_HEIGHT;
                    this.buyItem.y = BUY_ITEM_OFFSET;
                }
            }
        }

        public function setData(param1:EventStylesTradeDataVO) : void
        {
            this._data = param1;
            invalidateData();
        }

        public function get selectedIndex() : int
        {
            return this.scrollList.selectedIndex;
        }

        public function set selectedIndex(param1:int) : void
        {
            if(this.scrollList.selectedIndex != param1)
            {
                this.scrollList.selectedIndex = param1;
                invalidateData();
            }
        }

        override protected function onDispose() : void
        {
            this.scrollList.removeEventListener(MouseEvent.CLICK,this.onScrollListClickHandler,true);
            this.buyItem.dispose();
            this.buyItem = null;
            this.carouselBg = null;
            this.simpleBg = null;
            this._data = null;
            this._dataProvider.removeEventListener(Event.CHANGE,this.onDataProviderChangeHandler);
            this._dataProvider = null;
            this.scrollList.dispose();
            this.scrollList = null;
            this.authorInfo.dispose();
            this.authorInfo = null;
            this.styleInfo.dispose();
            this.styleInfo = null;
            super.onDispose();
        }

        private function onDataProviderChangeHandler(param1:Event) : void
        {
            this.selectedIndex = this._dataProvider.getDAAPIselectedIdx();
            invalidateData();
            dispatchEvent(new StylesTradeEvent(StylesTradeEvent.DATA_CHANGED));
        }

        public function getDataProvider() : Object
        {
            return this._dataProvider;
        }

        private function onScrollListClickHandler(param1:MouseEvent) : void
        {
            if(param1 is MouseEventEx && (param1 as MouseEventEx).buttonIdx == MouseEventEx.RIGHT_BUTTON)
            {
                param1.stopPropagation();
            }
        }
    }
}
