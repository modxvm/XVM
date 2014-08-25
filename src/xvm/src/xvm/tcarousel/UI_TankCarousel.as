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
        private var cfg:CCarousel;

        private const SLOT_TYPE_TANK:int = 1;
        private const SLOT_TYPE_BUYTANK:int = 2;
        private const SLOT_TYPE_BUYSLOT:int = 3;
        private const SLOT_TYPE_EMPTY:int = 4;

        public function UI_TankCarousel(cfg:CCarousel)
        {
            //Logger.add("UI_TankCarousel");
            super();

            this.cfg = cfg;
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
        override protected function set currentFirstRenderer(value:uint):void
        {
            var v:uint = value;
            v = Math.min(Math.ceil((_renderers.length - _visibleSlots) / cfg.rows), value);
            //Logger.add("currentFirstRenderer=" + v + " value=" + value);
            super.currentFirstRenderer = v;
        }

        // Carousel
        override protected function goToFirstRenderer():void
        {
            this.currentFirstRenderer = Math.floor(this.currentFirstRenderer / cfg.rows);
            super.goToFirstRenderer();
        }

        // Carousel
        override protected function handleMouseWheel(param1:MouseEvent):void
        {
            if (param1.delta <= 0 && this.currentFirstRenderer * cfg.rows >= _renderers.length - this._visibleSlots)
                return;
            super.handleMouseWheel(param1);
        }

        // TankCarousel
        override protected function draw():void
        {
            super.draw();
            if (isInvalid(InvalidationType.RENDERERS))
            {
                repositionRenderers();
                repositionAdvancedAndEmptySlots();
                //Logger.add("_visibleSlots=" + _visibleSlots + " _renderers.length=" + _renderers.length);
            }
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

        private function repositionRenderers():void
        {
            var renderer:IListItemRenderer = null;
            var _loc3_:DisplayObject = null;
            var selectedIndex:Number = 0;
            for (var i:Number = 0; i < this._currentShowRendersByIndex.length; ++i)
            {
                renderer = this._currentShowRendersByIndex[i];
                renderer.x = padding.horizontal + Math.floor(i / cfg.rows) * (slotImageWidth + padding.horizontal);
                renderer.y = padding.vertical + (i % cfg.rows) * (slotImageHeight + padding.vertical);
                if (renderer.selected)
                    selectedIndex = i;
            }
            //_totalRenderers = this._availableSlotsForBuyVehicle > 0?this._currentShowRendersByIndex.length + 2:this._currentShowRendersByIndex.length + 1;
            scrollToIndex(selectedIndex);
        }

        private function repositionAdvancedAndEmptySlots():void
        {
            var renderer:IListItemRenderer;

            var i:int = this._currentShowRendersByIndex.length;
            renderer = findSlot(SLOT_TYPE_BUYTANK);
            if (renderer != null)
            {
                renderer.x = padding.horizontal + Math.floor(i / cfg.rows) * (slotImageWidth + padding.horizontal);
                renderer.y = padding.vertical + (i % cfg.rows) * (slotImageHeight + padding.vertical);
                ++i;
            }

            renderer = findSlot(SLOT_TYPE_BUYSLOT);
            if (renderer != null)
            {
                renderer.x = padding.horizontal + Math.floor(i / cfg.rows) * (slotImageWidth + padding.horizontal);
                renderer.y = padding.vertical + (i % cfg.rows) * (slotImageHeight + padding.vertical);
                ++i;
            }

            // reposition empty slots ...
            /*var index:int = findSlotIndex(SLOT_TYPE_EMPTY);
            if (index < 0)
                return;
            while (index < _renderers.length)
            {
                renderer = getRendererAt(index);
                renderer.x = padding.horizontal + Math.floor(i / cfg.rows) * (slotImageWidth + padding.horizontal);
                renderer.y = padding.vertical + (i % cfg.rows) * (slotImageHeight + padding.vertical);
                ++i;
                ++index;
            }*/
            // ... or remove empty slots
            while(true)
            {
                renderer = getRendererAt(_renderers.length - 1);
                if ((renderer as TankCarouselItemRenderer).dataVO.empty)
                {
                    _renderers.splice(_renderers.length - 1, 1);
                    cleanUpRenderer(renderer);
                    continue;
                }
                break;
            }
        }
    }
}
