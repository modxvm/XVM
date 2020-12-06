package net.wg.gui.lobby.hangar.tcarousel
{
    import net.wg.infrastructure.base.meta.impl.TankCarouselMeta;
    import net.wg.gui.components.carousels.filters.TankCarouselFilters;
    import flash.display.MovieClip;
    import net.wg.gui.lobby.hangar.tcarousel.helper.ITankCarouselHelper;
    import net.wg.gui.components.controls.scroller.data.ScrollConfig;
    import net.wg.gui.components.carousels.events.TankItemEvent;
    import net.wg.gui.components.controls.events.RendererEvent;
    import flash.events.Event;
    import flash.display.Sprite;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.data.VO.TankCarouselFilterInitVO;
    import net.wg.data.VO.TankCarouselFilterSelectedVO;
    import net.wg.utils.helpLayout.HelpLayoutVO;
    import org.idmedia.as3commons.util.StringUtils;
    import net.wg.data.constants.Directions;
    import flash.geom.Rectangle;
    import net.wg.infrastructure.events.LifeCycleEvent;

    public class TankCarousel extends TankCarouselMeta implements ITankCarousel
    {

        private static const HELP_ID_SEPARATOR:String = "_";

        private static const FILTERS_WIDTH:int = 58;

        private static const ELASTICITY:Number = 0.25;

        private static const MASK_TOP_OFFSET:int = -12;

        private static const THROW_ACCELERATION_RATE:int = 4;

        private static const OFFSET_FILTERS:int = 20;

        private static const OUTSIDE_ARROW_OFFSET:int = 14;

        private static const THRESHOLD:int = 809;

        private static const GO_TO_OFFSET:Number = 0.5;

        private static const INV_ROW_COUNT:String = "invRowCount";

        private static const HIT_AREA_NAME:String = "emptyHitArea";

        private static const OPTIMIZE_OFFSET:int = 10;

        private static const ROUND_CORRECTION:int = 1;

        public var vehicleFilters:TankCarouselFilters = null;

        public var background:MovieClip = null;

        private var _carouselHelpLayoutId:String = null;

        private var _filtersHelpLayoutId:String = null;

        private var _stageHeight:Number = 0;

        private var _rowCount:int = 1;

        private var _helper:ITankCarouselHelper = null;

        private var _smallDoubleCarouselEnable:Boolean = false;

        private var _listVisibleHeight:int = -1;

        private var _rightMargin:int = 0;

        public function TankCarousel()
        {
            super();
        }

        override public function as_populate() : void
        {
            super.as_populate();
            App.graphicsOptimizationMgr.register(this);
        }

        override protected function updateLayout(param1:int, param2:int = 0) : void
        {
            this.background.width = param1;
            var _loc3_:int = param2 + OUTSIDE_ARROW_OFFSET;
            if(this.vehicleFilters.visible)
            {
                _loc3_ = _loc3_ + (OFFSET_FILTERS + FILTERS_WIDTH);
            }
            var _loc4_:int = param1 - _loc3_ - OUTSIDE_ARROW_OFFSET - this._rightMargin;
            var _loc5_:int = _loc3_ - leftArrowOffset;
            super.updateLayout(_loc4_,_loc5_);
            startFadeMask.x = scrollList.x + startFadeMask.width - ROUND_CORRECTION | 0;
            endFadeMask.x = scrollList.x + scrollList.width - endFadeMask.width + ROUND_CORRECTION | 0;
        }

        override protected function configUI() : void
        {
            super.configUI();
            endFadeMask.mouseEnabled = false;
            startFadeMask.mouseEnabled = false;
            roundCountRenderer = false;
            var _loc1_:ScrollConfig = new ScrollConfig();
            _loc1_.elasticity = ELASTICITY;
            _loc1_.throwAccelerationRate = THROW_ACCELERATION_RATE;
            scrollList.scrollConfig = _loc1_;
            scrollList.useTimer = true;
            scrollList.hasHorizontalElasticEdges = true;
            scrollList.snapScrollPositionToItemRendererSize = false;
            scrollList.snapToPages = true;
            scrollList.cropContent = true;
            scrollList.maskOffsetTop = MASK_TOP_OFFSET;
            scrollList.goToOffset = GO_TO_OFFSET;
            this._helper = new TankCarouselHelper();
            this.updateScrollListSettings();
            leftArrow.mouseEnabledOnDisabled = rightArrow.mouseEnabledOnDisabled = true;
            addEventListener(TankItemEvent.SELECT_BUY_SLOT,this.onSelectBuySlotHandler);
            addEventListener(TankItemEvent.SELECT_BUY_TANK,this.onSelectBuyTankHandler);
            addEventListener(TankItemEvent.SELECT_RESTORE_TANK,this.onSelectRestoreTankHandler);
            addEventListener(TankItemEvent.SELECT_RENT_PROMOTION_SLOT,this.onSelectRentPromotionSlotHandler);
            addEventListener(TankItemEvent.SELECT_NEW_YEAR_SLOT,this.onSelectNewYearSlotHandler);
            this.vehicleFilters.addEventListener(RendererEvent.ITEM_CLICK,this.onVehicleFiltersItemClickHandler);
            this.vehicleFilters.addEventListener(Event.RESIZE,this.onVehicleFiltersResizeHandler);
            this.background.mouseEnabled = false;
            this.background.mouseChildren = false;
            var _loc2_:Sprite = new Sprite();
            _loc2_.name = HIT_AREA_NAME;
            addChild(_loc2_);
            this.background.hitArea = _loc2_;
            mouseEnabled = false;
            App.utils.helpLayout.registerComponent(this);
        }

        override protected function draw() : void
        {
            var _loc1_:Boolean = isInvalid(InvalidationType.SIZE);
            if(_loc1_)
            {
                this._helper = this.getNewHelper();
            }
            if(isInvalid(INV_ROW_COUNT))
            {
                scrollList.rowCount = this._rowCount;
                goToSelectedItem();
                invalidate(InvalidationType.SETTINGS);
            }
            if(isInvalid(InvalidationType.SETTINGS))
            {
                this.updateScrollListSettings();
            }
            super.draw();
            if(_loc1_)
            {
                if(scrollList.pageWidth == 0)
                {
                    scrollList.validateNow();
                }
                this.updateLayout(width);
                dispatchEvent(new Event(Event.RESIZE));
            }
        }

        override protected function updateSelectedIndex() : void
        {
            super.updateSelectedIndex();
            goToSelectedItem();
        }

        override protected function onDispose() : void
        {
            removeEventListener(TankItemEvent.SELECT_BUY_SLOT,this.onSelectBuySlotHandler);
            removeEventListener(TankItemEvent.SELECT_BUY_TANK,this.onSelectBuyTankHandler);
            removeEventListener(TankItemEvent.SELECT_RESTORE_TANK,this.onSelectRestoreTankHandler);
            removeEventListener(TankItemEvent.SELECT_RENT_PROMOTION_SLOT,this.onSelectRentPromotionSlotHandler);
            removeEventListener(TankItemEvent.SELECT_NEW_YEAR_SLOT,this.onSelectNewYearSlotHandler);
            App.contextMenuMgr.hide();
            this.vehicleFilters.removeEventListener(Event.RESIZE,this.onVehicleFiltersResizeHandler);
            this.vehicleFilters.removeEventListener(RendererEvent.ITEM_CLICK,this.onVehicleFiltersItemClickHandler);
            this.vehicleFilters.dispose();
            this.vehicleFilters = null;
            this.background = null;
            this._helper = null;
            super.onDispose();
        }

        override protected function initCarouselFilter(param1:TankCarouselFilterInitVO) : void
        {
            this.vehicleFilters.visible = param1.isVisible;
            this.vehicleFilters.initData(param1);
        }

        override protected function setCarouselFilter(param1:TankCarouselFilterSelectedVO) : void
        {
            this.vehicleFilters.setSelectedData(param1);
        }

        override protected function updateAvailableScroll(param1:Boolean, param2:Boolean) : void
        {
            super.updateAvailableScroll(param1,param2);
            startFadeMask.visible = param1;
            endFadeMask.visible = param2;
        }

        public function as_rowCount(param1:int) : void
        {
            if(this._rowCount != param1)
            {
                this._rowCount = param1;
                invalidate(InvalidationType.SIZE,INV_ROW_COUNT);
            }
        }

        public function as_setSmallDoubleCarousel(param1:Boolean) : void
        {
            this._smallDoubleCarouselEnable = param1;
            invalidateSize();
        }

        public function getAliasS() : String
        {
            return getCarouselAliasS();
        }

        public function getBottom() : Number
        {
            return this.background.height + this.background.y;
        }

        public function getLayoutProperties() : Vector.<HelpLayoutVO>
        {
            var _loc1_:Vector.<HelpLayoutVO> = new Vector.<HelpLayoutVO>();
            if(StringUtils.isEmpty(this._carouselHelpLayoutId))
            {
                this._carouselHelpLayoutId = name + HELP_ID_SEPARATOR + Math.random();
            }
            var _loc2_:HelpLayoutVO = new HelpLayoutVO();
            _loc2_.x = leftArrow.x;
            _loc2_.y = scrollList.y;
            _loc2_.width = rightArrow.x - leftArrow.x;
            _loc2_.height = scrollList.height;
            _loc2_.extensibilityDirection = Directions.RIGHT;
            _loc2_.message = LOBBY_HELP.HANGAR_VEHICLE_CAROUSEL;
            _loc2_.id = name + HELP_ID_SEPARATOR + Math.random();
            _loc2_.scope = this;
            _loc1_.push(_loc2_);
            if(StringUtils.isEmpty(this._filtersHelpLayoutId))
            {
                this._filtersHelpLayoutId = name + HELP_ID_SEPARATOR + Math.random();
            }
            var _loc3_:HelpLayoutVO = new HelpLayoutVO();
            _loc3_.x = this.vehicleFilters.x;
            _loc3_.y = this.vehicleFilters.y;
            _loc3_.width = this.vehicleFilters.width;
            _loc3_.height = this.vehicleFilters.height;
            _loc3_.extensibilityDirection = Directions.RIGHT;
            _loc3_.message = LOBBY_HELP.HANGAR_VEHFILTERS;
            _loc3_.id = this._filtersHelpLayoutId;
            _loc3_.scope = this;
            _loc1_.push(_loc3_);
            return _loc1_;
        }

        public function getRectangles() : Vector.<Rectangle>
        {
            if(!visible || !stage || !parent.visible)
            {
                return null;
            }
            var _loc1_:int = getBounds(App.stage).y - this.background.y + OPTIMIZE_OFFSET;
            return new <Rectangle>[new Rectangle(x,_loc1_,App.appWidth,App.appHeight - _loc1_)];
        }

        public function setRightMargin(param1:int) : void
        {
            this._rightMargin = param1;
            invalidateSize();
        }

        public function updateCarouselPosition(param1:Number) : void
        {
            if(y != param1)
            {
                y = param1;
                dispatchEvent(new LifeCycleEvent(LifeCycleEvent.ON_GRAPHICS_RECTANGLES_UPDATE));
            }
        }

        public function updateStage(param1:Number, param2:Number) : void
        {
            width = param1;
            this._stageHeight = param2;
            invalidate(InvalidationType.SIZE);
        }

        protected function getNewHelper() : ITankCarouselHelper
        {
            var _loc1_:ITankCarouselHelper = this._helper;
            if(this._rowCount > 1 && (this._stageHeight < THRESHOLD || this._smallDoubleCarouselEnable))
            {
                if(!(_loc1_ is TankCarousel))
                {
                    _loc1_ = new SmallTankCarouselHelper();
                    invalidate(InvalidationType.SETTINGS);
                }
            }
            else if(!(_loc1_ is TankCarousel))
            {
                _loc1_ = new TankCarouselHelper();
                invalidate(InvalidationType.SETTINGS);
            }
            return _loc1_;
        }

        private function updateScrollListSettings() : void
        {
            var _loc1_:int = this._helper.verticalGap;
            var _loc2_:int = this._helper.horizontalGap;
            var _loc3_:int = this._helper.rendererHeight;
            var _loc4_:int = this._helper.rendererWidth;
            scrollList.itemRendererClassReference = this._helper.linkRenderer;
            horizontalGap = _loc2_;
            verticalGap = _loc1_;
            rendererWidth = _loc4_;
            rendererHeight = _loc3_;
            pageWidth = _loc4_ + _loc2_;
            scrollList.height = (_loc1_ + _loc3_) * this._rowCount - _loc1_;
            this._listVisibleHeight = (_loc1_ + this._helper.rendererVisibleHeight) * this._rowCount - _loc1_ + this._helper.rendererHeightDiff * Math.max(0,this._rowCount - 1);
            var _loc5_:int = this._helper.padding.top;
            scrollList.y = _loc5_;
            this.background.height = -this.background.y + this._listVisibleHeight + _loc5_ + this._helper.padding.bottom;
            leftArrow.height = rightArrow.height = this._listVisibleHeight;
            startFadeMask.height = endFadeMask.height = this._listVisibleHeight;
            startFadeMask.y = endFadeMask.y = _loc5_;
            leftArrow.y = _loc5_;
            rightArrow.y = _loc5_ + this._listVisibleHeight;
            this.vehicleFilters.height = this._listVisibleHeight;
            dispatchEvent(new Event(Event.RESIZE));
        }

        public function get helper() : ITankCarouselHelper
        {
            return this._helper;
        }

        private function onSelectNewYearSlotHandler(param1:TankItemEvent) : void
        {
            newYearVehiclesS();
        }

        private function onSelectRestoreTankHandler(param1:TankItemEvent) : void
        {
            restoreTankS();
        }

        private function onSelectBuyTankHandler(param1:TankItemEvent) : void
        {
            buyTankS();
        }

        private function onSelectBuySlotHandler(param1:TankItemEvent) : void
        {
            buySlotS();
        }

        private function onSelectRentPromotionSlotHandler(param1:TankItemEvent) : void
        {
            buyRentPromotionS(param1.itemId);
        }

        private function onVehicleFiltersItemClickHandler(param1:RendererEvent) : void
        {
            setFilterS(param1.index);
        }

        private function onVehicleFiltersResizeHandler(param1:Event) : void
        {
            this.vehicleFilters.y = scrollList.y + (this._listVisibleHeight - this.vehicleFilters.height >> 1);
            updateHotFiltersS();
        }
    }
}

import net.wg.gui.lobby.hangar.tcarousel.helper.ITankCarouselHelper;
import scaleform.clik.utils.Padding;

class TankCarouselHelper extends Object implements ITankCarouselHelper
{

    private static const PADDING:Padding = new Padding(10);

    private static const RENDER_HEIGHT:int = 102;

    private static const RENDERER_VISIBLE_HEIGHT:int = 102;

    private static const RENDERER_HEIGHT_DIFF:int = RENDER_HEIGHT - RENDERER_VISIBLE_HEIGHT;

    function TankCarouselHelper()
    {
        super();
    }

    public function get linkRenderer() : String
    {
        return "TankCarouselItemRendererUI";
    }

    public function get rendererWidth() : int
    {
        return 162;
    }

    public function get rendererHeight() : int
    {
        return RENDER_HEIGHT;
    }

    public function get horizontalGap() : int
    {
        return 10;
    }

    public function get verticalGap() : int
    {
        return 10;
    }

    public function get padding() : Padding
    {
        return PADDING;
    }

    public function get rendererVisibleHeight() : int
    {
        return RENDERER_VISIBLE_HEIGHT;
    }

    public function get rendererHeightDiff() : int
    {
        return RENDERER_HEIGHT_DIFF;
    }
}

import net.wg.gui.lobby.hangar.tcarousel.helper.ITankCarouselHelper;
import scaleform.clik.utils.Padding;

class SmallTankCarouselHelper extends Object implements ITankCarouselHelper
{

    private static const PADDING:Padding = new Padding(19,20);

    private static const RENDER_HEIGHT:int = 37;

    private static const RENDERER_VISIBLE_HEIGHT:int = 37;

    private static const RENDERER_HEIGHT_DIFF:int = RENDER_HEIGHT - RENDERER_VISIBLE_HEIGHT;

    function SmallTankCarouselHelper()
    {
        super();
    }

    public function get linkRenderer() : String
    {
        return "SmallTankCarouselItemRendererUI";
    }

    public function get rendererWidth() : int
    {
        return 162;
    }

    public function get rendererHeight() : int
    {
        return RENDER_HEIGHT;
    }

    public function get horizontalGap() : int
    {
        return 10;
    }

    public function get verticalGap() : int
    {
        return 10;
    }

    public function get padding() : Padding
    {
        return PADDING;
    }

    public function get rendererVisibleHeight() : int
    {
        return RENDERER_VISIBLE_HEIGHT;
    }

    public function get rendererHeightDiff() : int
    {
        return RENDERER_HEIGHT_DIFF;
    }
}
