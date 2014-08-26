package xvm.tcarousel
{
    import com.xvm.*;
    import com.xvm.types.cfg.*;
    import flash.display.*;
    import flash.events.*;
    import net.wg.gui.lobby.hangar.tcarousel.*;
    import net.wg.gui.lobby.hangar.tcarousel.data.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.interfaces.*;

    public /*dynamic*/ class UI_TankCarousel extends TankCarouselUI
    {
        private static const SLOT_TYPE_TANK:int = 1;
        private static const SLOT_TYPE_BUYTANK:int = 2;
        private static const SLOT_TYPE_BUYSLOT:int = 3;
        private static const SLOT_TYPE_EMPTY:int = 4;

        private var cfg:CCarousel;

        public function UI_TankCarousel(cfg:CCarousel)
        {
            //Logger.add("UI_TankCarousel");
            super();
            this.cfg = cfg;
        }

        // TankCarousel
        override protected function draw():void
        {
            super.draw();
            if (isInvalid(InvalidationType.RENDERERS))
            {
                repositionRenderers();
                repositionAdvancedSlots();
                removeEmptySlots();
                //Logger.add("_visibleSlots=" + _visibleSlots + " _renderers.length=" + _renderers.length);
            }
            if (isInvalid(InvalidationType.SIZE))
            {
                repositionAdvancedSlots();
                removeEmptySlots();
            }
        }

        // Carousel
        override protected function goToFirstRenderer():void
        {
            //Logger.add("goToFirstRenderer: " + currentFirstRenderer);
            this.currentFirstRenderer = Math.floor(this.currentFirstRenderer / cfg.rows);
            super.goToFirstRenderer();
        }

        // Carousel
        override protected function updateArrowsState():void
        {
            //Logger.add("updateArrowsState: " + _totalRenderers  + " " + this._visibleSlots + " " + currentFirstRenderer);

            if (_totalRenderers > this._visibleSlots && this.currentFirstRenderer * cfg.rows >= _totalRenderers - this._visibleSlots)
            {
                this.leftArrow.enabled = true;
                this.rightArrow.enabled = false;
                this.allowDrag = true;
            }
            else
            {
                super.updateArrowsState();
            }
        }

        // Carousel
        override protected function updateVisibleSlotsCount():Number
        {
            super.updateVisibleSlotsCount();
            _visibleSlots *= cfg.rows;
            //Logger.add("_visibleSlots=" + _visibleSlots);
            return _visibleSlots;
        }

        // Carousel
        override protected function updateUIPosition():void
        {
            var slotWidth:Number = this.slotWidth;
            this.slotWidth /= cfg.rows;
            super.updateUIPosition();
            this.slotWidth = slotWidth;

            if (this.bg)
                bg.height = height;
        }

        // Carousel
        override protected function updateScopeWidth():void
        {
            this.scopeWidth = Math.ceil(_renderers.length / cfg.rows) * this.slotWidth + this.padding.horizontal;
        }

        // Carousel
        override protected function set currentFirstRenderer(value:uint):void
        {
            var v:uint = Math.min(Math.max(Math.ceil((_renderers.length - _visibleSlots) / cfg.rows), 0), value);
            //Logger.add(" value=" + value + " currentFirstRenderer=" + v);
            super.currentFirstRenderer = v;
        }

        // Carousel
        override protected function getCurrentFirstRendererOnAnim():Number
        {
            super.getCurrentFirstRendererOnAnim();
            if (container && _renderers)
            {
                var n:Number = -Math.round((container.x - this._defContainerPos) / this.slotWidth);
                if (n >= _renderers.length - this._visibleSlots)
                    _currentFirstRendererOnAnim = Math.max(0, _renderers.length - this._visibleSlots);
                //Logger.add("_currentFirstRendererOnAnim: " + _currentFirstRendererOnAnim);
            }
            return _currentFirstRendererOnAnim;
        }

        // Carousel
        override protected function arrowSlide():void
        {
            super.arrowSlide();
            if (this.courseFactor == -1)
            {
                if (this._currentFirstRendererOnAnim >= Math.ceil((_renderers.length - _visibleSlots) / cfg.rows))
                {
                    this.currentFirstRenderer = _renderers.length - this._visibleSlots;
                    this.courseFactor = 0;
                }
            }
        }

        // Carousel
        override protected function handleMouseWheel(param1:MouseEvent):void
        {
            if (param1.delta <= 0 && this.currentFirstRenderer * cfg.rows >= _renderers.length - this._visibleSlots)
                return;
            super.handleMouseWheel(param1);
        }

        // PRIVATE

        private function checkRendererType(renderer:IListItemRenderer, slotType:int):Boolean
        {
            if (renderer == null)
                return false;

            var data:VehicleCarouselVO = (renderer as TankCarouselItemRenderer).dataVO;
            switch (slotType)
            {
                case SLOT_TYPE_BUYTANK:
                    return data.buyTank == true;
                case SLOT_TYPE_BUYSLOT:
                    return data.buySlot == true;
                case SLOT_TYPE_EMPTY:
                    return data.empty == true;
                case SLOT_TYPE_TANK:
                    return data.buyTank == false && data.buySlot == false && data.empty == false;
                default:
                    Logger.add("WARNING: unknown slot type: " + slotType);
                    return false;
            }
        }

        private function findSlotIndex(slotType:int):int
        {
            if (_renderers == null)
                return -1;
            for (var i:int = 0; i < _renderers.length; ++i)
            {
                if (checkRendererType(getRendererAt(i), slotType))
                    return i;
            }
            return -1;
        }

        private function findSlot(slotType:int):IListItemRenderer
        {
            var index:int = findSlotIndex(slotType);
            return index < 0 ? null : getRendererAt(index);
        }

        private var _currentShowRendersCount:int;

        private function repositionRenderers():void
        {
            var renderer:IListItemRenderer = null;
            var selectedIndex:Number = 0;
            _currentShowRendersCount = 0;
            var n:int = 0;
            for (var i:Number = 0; i < this._renderers.length; ++i)
            {
                renderer = _renderers[i];
                if ((renderer as DisplayObject).visible == false)
                    continue;
                renderer.x = padding.horizontal + Math.floor(n / cfg.rows) * (slotImageWidth + padding.horizontal);
                renderer.y = (n % cfg.rows) * (slotImageHeight + padding.vertical);
                if (renderer.selected)
                    selectedIndex = n;
                if (checkRendererType(renderer, SLOT_TYPE_TANK))
                    ++_currentShowRendersCount;
                ++n;
            }
            scrollToIndex(selectedIndex);
        }

        private function repositionAdvancedSlots():void
        {
            var i:int;
            var renderer:IListItemRenderer;

            var n:int = _currentShowRendersCount;

            i = findSlotIndex(SLOT_TYPE_BUYTANK);
            if (i >= 0)
            {
                renderer = getRendererAt(i);
                if (Config.config.hangar.carousel.hideBuyTank == true)
                {
                    _renderers.splice(i, 1);
                    (renderer as DisplayObject).visible = false;
                }
                else
                {
                    renderer.x = padding.horizontal + Math.floor(n / cfg.rows) * (slotImageWidth + padding.horizontal);
                    renderer.y = (n % cfg.rows) * (slotImageHeight + padding.vertical);
                    ++n;
                }
            }

            i = findSlotIndex(SLOT_TYPE_BUYSLOT);
            if (i > 0)
            {
                renderer = getRendererAt(i);
                if (Config.config.hangar.carousel.hideBuySlot == true)
                {
                    _renderers.splice(i, 1);
                    (renderer as DisplayObject).visible = false;
                }
                else
                {
                    renderer.x = padding.horizontal + Math.floor(n / cfg.rows) * (slotImageWidth + padding.horizontal);
                    renderer.y = (n % cfg.rows) * (slotImageHeight + padding.vertical);
                    ++n;
                }
            }
        }

        private function removeEmptySlots():void
        {
            while(true)
            {
                var renderer:IListItemRenderer = getRendererAt(_renderers.length - 1);
                if (checkRendererType(renderer, SLOT_TYPE_EMPTY))
                {
                    cleanUpRenderer(renderer);
                    continue;
                }
                break;
            }
        }
    }
}
