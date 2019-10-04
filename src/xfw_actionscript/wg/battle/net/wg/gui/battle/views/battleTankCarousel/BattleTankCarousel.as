package net.wg.gui.battle.views.battleTankCarousel
{
    import net.wg.infrastructure.base.meta.impl.BattleTankCarouselMeta;
    import net.wg.infrastructure.base.meta.IBattleTankCarouselMeta;
    import net.wg.infrastructure.interfaces.IUIComponentEx;
    import flash.display.MovieClip;
    import net.wg.data.VO.TankCarouselFilterSelectedVO;
    import net.wg.data.VO.TankCarouselFilterInitVO;
    import net.wg.gui.components.controls.scroller.data.ScrollConfig;
    import net.wg.gui.components.controls.events.RendererEvent;
    import flash.events.Event;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.utils.helpLayout.HelpLayoutVO;

    public class BattleTankCarousel extends BattleTankCarouselMeta implements IBattleTankCarouselMeta, IUIComponentEx
    {

        private static const HELP_ID_SEPARATOR:String = "_";

        private static const FILTERS_WIDTH:Number = 58;

        private static const ELASTICITY:Number = 0.25;

        private static const MASK_OFFSET:int = -10;

        private static const THROW_ACCELERATION_RATE:int = 4;

        private static const OFFSET_FILTERS:int = 20;

        private static const OFFSET_ARROW:int = 14;

        private static const GO_TO_OFFSET:Number = 0.5;

        private static const DIRECTIONS_RIGHT:String = "R";

        public var vehicleFilters:BattleTankCarouselFilters = null;

        public var background:MovieClip = null;

        private var _helper:BattleTankCarouselHelper = null;

        public function BattleTankCarousel()
        {
            super();
        }

        override protected function setCarouselFilter(param1:TankCarouselFilterSelectedVO) : void
        {
            this.vehicleFilters.setSelectedData(param1);
        }

        override protected function initCarouselFilter(param1:TankCarouselFilterInitVO) : void
        {
            this.vehicleFilters.visible = param1.isVisible;
            this.vehicleFilters.initData(param1);
        }

        override protected function updateLayout(param1:int, param2:int = 0) : void
        {
            var _loc3_:Number = param2 + FILTERS_WIDTH + OFFSET_FILTERS + OFFSET_ARROW;
            var _loc4_:Number = param1 - _loc3_ - OFFSET_ARROW >> 0;
            this.background.width = param1 >> 0;
            var _loc5_:* = _loc4_ + leftArrowOffset - rightArrowOffset >> 0;
            super.updateLayout(_loc4_,(_loc4_ - _loc5_ >> 1) + _loc3_ >> 0);
            endFadeMask.x = rightArrow.x - rightArrow.width - endFadeMask.width >> 0;
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
            scrollList.maskOffsetLeft = scrollList.maskOffsetRight = MASK_OFFSET;
            scrollList.goToOffset = GO_TO_OFFSET;
            this._helper = new BattleTankCarouselHelper();
            this.updateScrollListSettings();
            leftArrow.mouseEnabledOnDisabled = rightArrow.mouseEnabledOnDisabled = true;
            this.vehicleFilters.addEventListener(RendererEvent.ITEM_CLICK,this.onVehicleFiltersItemClickHandler);
            this.vehicleFilters.addEventListener(Event.RESIZE,this.onVehicleFiltersResizeHandler);
            this.background.mouseEnabled = false;
            this.background.mouseChildren = false;
            mouseEnabled = false;
        }

        override protected function onDispose() : void
        {
            App.contextMenuMgr.hide();
            this.vehicleFilters.removeEventListener(Event.RESIZE,this.onVehicleFiltersResizeHandler);
            this.vehicleFilters.removeEventListener(RendererEvent.ITEM_CLICK,this.onVehicleFiltersItemClickHandler);
            this.vehicleFilters.dispose();
            this.vehicleFilters = null;
            this.background = null;
            this._helper = null;
            super.onDispose();
        }

        override protected function draw() : void
        {
            var _loc1_:Boolean = isInvalid(InvalidationType.SIZE);
            if(_loc1_)
            {
                this._helper = this.getNewHelper();
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
                goToSelectedItem();
                dispatchEvent(new Event(Event.RESIZE));
            }
        }

        public function getBottom() : Number
        {
            return this.background.height + this.background.y;
        }

        public function getLayoutProperties() : Vector.<HelpLayoutVO>
        {
            var _loc1_:Vector.<HelpLayoutVO> = new Vector.<HelpLayoutVO>();
            var _loc2_:HelpLayoutVO = new HelpLayoutVO();
            _loc2_.x = leftArrow.x;
            _loc2_.y = scrollList.y;
            _loc2_.width = rightArrow.x - leftArrow.x;
            _loc2_.height = scrollList.height;
            _loc2_.extensibilityDirection = DIRECTIONS_RIGHT;
            _loc2_.message = LOBBY_HELP.HANGAR_VEHICLE_CAROUSEL;
            _loc2_.id = name + HELP_ID_SEPARATOR + Math.random();
            _loc2_.scope = this;
            _loc1_.push(_loc2_);
            var _loc3_:HelpLayoutVO = new HelpLayoutVO();
            _loc3_.x = this.vehicleFilters.x;
            _loc3_.y = this.vehicleFilters.y;
            _loc3_.width = this.vehicleFilters.width;
            _loc3_.height = this.vehicleFilters.height;
            _loc3_.extensibilityDirection = DIRECTIONS_RIGHT;
            _loc3_.message = LOBBY_HELP.HANGAR_VEHFILTERS;
            _loc3_.id = name + HELP_ID_SEPARATOR + Math.random();
            _loc3_.scope = this;
            _loc1_.push(_loc3_);
            return _loc1_;
        }

        public function updateStage(param1:Number, param2:Number) : void
        {
            width = param1;
            invalidate(InvalidationType.SIZE);
        }

        protected function getNewHelper() : BattleTankCarouselHelper
        {
            var _loc1_:BattleTankCarouselHelper = this._helper;
            if(!(_loc1_ is BattleTankCarouselHelper))
            {
                _loc1_ = new BattleTankCarouselHelper();
                invalidate(InvalidationType.SETTINGS);
            }
            return _loc1_;
        }

        private function updateScrollListSettings() : void
        {
            scrollList.itemRendererClassReference = this._helper.linkRenderer;
            horizontalGap = this._helper.horizontalGap;
            verticalGap = this._helper.verticalGap;
            rendererWidth = this._helper.rendererWidth;
            rendererHeight = this._helper.rendererHeight;
            pageWidth = this._helper.rendererWidth + this._helper.horizontalGap;
            scrollList.height = (this._helper.verticalGap + this._helper.rendererHeight) * 1 - this._helper.verticalGap;
            scrollList.y = this._helper.padding.top;
            this.background.height = -this.background.y + scrollList.height + scrollList.y + this._helper.padding.bottom;
            startFadeMask.height = endFadeMask.height = leftArrow.height = rightArrow.height = scrollList.height;
            startFadeMask.y = endFadeMask.y = scrollList.y;
            leftArrow.y = scrollList.y;
            rightArrow.y = scrollList.y + rightArrow.height;
            this.vehicleFilters.height = scrollList.height;
        }

        private function onVehicleFiltersItemClickHandler(param1:RendererEvent) : void
        {
            setFilterS(param1.index);
        }

        private function onVehicleFiltersResizeHandler(param1:Event) : void
        {
            this.vehicleFilters.y = scrollList.y + (scrollList.height - this.vehicleFilters.height >> 1);
            updateHotFiltersS();
        }
    }
}

import scaleform.clik.utils.Padding;

class BattleTankCarouselHelper extends Object
{

    private static const PADDING:Padding = new Padding(10);

    private static const RENDER_WIDTH:int = 162;

    private static const RENDER_HEIGHT:int = 102;

    private static const GAP:int = 10;

    private static const REMDERER_LINKAGE:String = "BattleTankCarouselItemRendererUI";

    function BattleTankCarouselHelper()
    {
        super();
    }

    public function get linkRenderer() : String
    {
        return REMDERER_LINKAGE;
    }

    public function get rendererWidth() : int
    {
        return RENDER_WIDTH;
    }

    public function get rendererHeight() : int
    {
        return RENDER_HEIGHT;
    }

    public function get horizontalGap() : int
    {
        return GAP;
    }

    public function get verticalGap() : int
    {
        return GAP;
    }

    public function get padding() : Padding
    {
        return PADDING;
    }
}
