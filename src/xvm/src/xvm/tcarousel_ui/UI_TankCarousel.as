/**
/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package xvm.tcarousel_ui
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.types.cfg.*;
    import com.xvm.types.dossier.*;
    import com.xvm.types.veh.*;
    import flash.display.*;
    import flash.events.*;
    import net.wg.data.constants.*;
    import net.wg.gui.components.controls.*;
    import net.wg.gui.events.*;
    import net.wg.gui.lobby.hangar.tcarousel.*;
    import net.wg.gui.lobby.hangar.tcarousel.data.*;
    import net.wg.gui.lobby.hangar.tcarousel.helper.*;
    import scaleform.clik.core.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.events.*;
    import scaleform.clik.interfaces.*;

    public /*dynamic*/ class UI_TankCarousel extends TankCarouselUI
    {
        private static const SLOT_TYPE_TANK:int = 1;
        private static const SLOT_TYPE_BUYTANK:int = 2;
        private static const SLOT_TYPE_BUYSLOT:int = 3;
        private static const SLOT_TYPE_EMPTY:int = 4;

        private var cfg:CCarousel;

        private var _isMultiselectionModeEnabled:Boolean = false;
        private var _carousel_height:int;

        private var _skipScrollToIndex:Boolean = false;
        private var _in_as_setParams:Boolean = false;

        public function UI_TankCarousel()
        {
            //Logger.add("UI_TankCarousel()");
            super();

            this.cfg = Config.config.hangar.carousel;

            componentInspectorSetting = true;

            enabled = true;
            visible = true;
            focusable = false;
            margin = 5;
            useRightButton = true;
            useRightButtonForSelect = false;

            itemRenderer = UI_TankCarouselItemRenderer;

            inspectablePadding = {
                top: 0,
                right: cfg.padding.horizontal / 2,
                bottom: cfg.padding.vertical,
                left: cfg.padding.horizontal / 2
            };

            xfw_scrollSpeed = isNaN(cfg.scrollingSpeed) || Number(cfg.scrollingSpeed) < 0 ? 20 : Number(cfg.scrollingSpeed) < 1 ? 1 : Number(cfg.scrollingSpeed);

            componentInspectorSetting = false;
        }

        override protected function configUI():void
        {
            //Logger.add("UI_TankCarousel.configUI()");
            try
            {
                super.configUI();

                this.vehicleFiltersOld.visible = false; // TODO: delete when vehicleFiltersOld will be removed
                vehicleFilters.validateNow();

                if (!cfg.filters.params.enabled)
                    resetFiltersS();
                if (!cfg.filters.bonus.enabled)
                    vehicleFilters.bonusFilter.selected = false;
                if (!cfg.filters.favorite.enabled)
                    vehicleFilters.favoriteFilter.selected = false;
                call_setVehiclesFilter();
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        // TankCarousel
        override public function scrollToIndex(index:uint):void
        {
            //Logger.add("UI_TankCarousel.scrollToIndex(" + index + ")");
            try
            {
                //Logger.add("scrollToIndex: " + index + " xfw_visibleSlots: " + xfw_visibleSlots + " _totalRenderers=" +_totalRenderers);
                if (!container || !_renderers)
                    return;

                if (_in_as_setParams)
                {
                    updateTotalRenderers();
                }

                var n:uint = Math.floor(xfw_visibleSlots / cfg.rows / 2);
                index = Math.floor(index / cfg.rows);
                currentFirstRenderer = Math.max(0, int(index) - n);
                goToFirstRenderer();
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        // TankCarousel
        override public function as_setMultiselectionMode(param:Object):void
        {
            //Logger.addObject(arguments, 1, "as_setMultiselectionMode");

            var vo:MultiselectionInfoVO = new MultiselectionInfoVO(param);

            _isMultiselectionModeEnabled = vo.multiSelectionIsEnabled;

            slotImageWidth = int(UI_TankCarouselItemRenderer.ITEM_WIDTH * cfg.zoom);
            slotImageHeight = int(UI_TankCarouselItemRenderer.ITEM_HEIGHT * cfg.zoom);
            if (_isMultiselectionModeEnabled)
                slotImageHeight += (UI_TankCarouselItemRenderer.ITEM_HEIGHT_MULTISELECTION - UI_TankCarouselItemRenderer.ITEM_HEIGHT) * cfg.fields.activateButton.scale * cfg.zoom;

            _carousel_height = (slotImageHeight + padding.vertical) * cfg.rows - padding.vertical + 3;

            height = _carousel_height + 8;

            super.as_setMultiselectionMode(param);
        }

        // TankCarousel
        override public function as_setParams(params:Object):void
        {
            //Logger.add("UI_TankCarousel.as_setParams(...)");
            try
            {
                _in_as_setParams = true;
                super.as_setParams(params);
                _in_as_setParams = false;
                updateAdvancedSlots();
                removeEmptySlots();
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
            finally
            {
                _in_as_setParams = false;
            }
        }

        // Carousel
        override protected function updateArrowsState():void
        {
            //Logger.add("UI_TankCarousel.updateArrowsState()");
            try
            {
                //Logger.add("updateArrowsState: " + _totalRenderers  + " " + this.xfw_visibleSlots + " " + currentFirstRenderer);

                if (_totalRenderers > this.xfw_visibleSlots && this.currentFirstRenderer * cfg.rows >= _totalRenderers - this.xfw_visibleSlots)
                {
                    this.leftArrow.enabled = true;
                    this.rightArrow.enabled = false;
                    this.xfw_allowDrag = true;
                }
                else
                {
                    super.updateArrowsState();
                }
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        // Carousel
        override protected function updateVisibleSlotsCount():Number
        {
            //Logger.add("UI_TankCarousel.updateVisibleSlotsCount()");
            try
            {
                super.updateVisibleSlotsCount();
                xfw_visibleSlots *= cfg.rows;
                //Logger.add("xfw_visibleSlots=" + xfw_visibleSlots);
                return xfw_visibleSlots;
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
            return xfw_visibleSlots;
        }

        // Carousel
        override protected function updateUIPosition():void
        {
            //Logger.add("UI_TankCarousel.updateUIPosition()");
            try
            {
                leftArrow.height = rightArrow.height = renderersMask.height = dragHitArea.height = _carousel_height;

                if (isInvalid(InvalidationType.RENDERERS))
                {
                    //Logger.add("RENDERERS");
                    repositionRenderers();
                    //Logger.add("xfw_visibleSlots=" + xfw_visibleSlots + " _totalRenderers=" + _totalRenderers);
                }
                else
                {
                    // TODO: is required?
                    updateAdvancedSlots();
                    removeEmptySlots();
                }

                var slotWidth:Number = this.slotWidth;
                this.xfw_slotWidth = this.slotWidth / cfg.rows;
                super.updateUIPosition();
                this.xfw_slotWidth = slotWidth;
                renderersMask.width = rightArrow.x - xfw_defContainerPos - rightArrow.width;

                multiselectionBg.visible = false;

                defaultBg.visible = true;
                defaultBg.mouseEnabled = defaultBg.mouseChildren = false;
                defaultBg.x = -100;
                defaultBg.y = 0;
                defaultBg.scaleX = 1;
                defaultBg.graphics.clear();
                defaultBg.graphics.beginFill(0x000000, cfg.backgroundAlpha / 100.0);
                defaultBg.graphics.drawRect(0, 0, width + 200, height);
                if (_isMultiselectionModeEnabled)
                {
                    defaultBg.graphics.drawRect(0, -64, width + 200, 54);
                }
                defaultBg.graphics.endFill();
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        // Carousel
        override protected function updateScopeWidth():void
        {
            //Logger.add("UI_TankCarousel.updateScopeWidth()");
            try
            {
                if (_renderers == null)
                    return;
                this.xfw_scopeWidth = Math.ceil(Math.max(_totalRenderers, xfw_visibleSlots) / cfg.rows) * this.slotWidth + this.padding.horizontal;
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        // Carousel
        override protected function set currentFirstRenderer(value:uint):void
        {
            //Logger.add("UI_TankCarousel.currentFirstRenderer(" + value + ")");
            try
            {
                var v:uint = Math.min(Math.max(Math.ceil((_totalRenderers - xfw_visibleSlots) / cfg.rows), 0), value);
                //Logger.add("UI_TankCarousel.currentFirstRenderer: _totalRenderers=" + _totalRenderers + " value=" + value + " currentFirstRenderer=" + v);
                super.currentFirstRenderer = v;
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        // Carousel
        override protected function getCurrentFirstRendererOnAnim():Number
        {
            //Logger.add("UI_TankCarousel.getCurrentFirstRendererOnAnim()");
            try
            {
                super.getCurrentFirstRendererOnAnim();
                if (container && _renderers)
                {
                    var n:Number = -Math.round((container.x - this.xfw_defContainerPos) / this.slotWidth);
                    if (n >= _totalRenderers - this.xfw_visibleSlots)
                        xfw_currentFirstRendererOnAnim = Math.max(0, _totalRenderers - this.xfw_visibleSlots);
                    //Logger.add("xfw_currentFirstRendererOnAnim: " + xfw_currentFirstRendererOnAnim);
                }
                //Logger.add("getCurrentFirstRendererOnAnim: " + xfw_currentFirstRendererOnAnim);
                return xfw_currentFirstRendererOnAnim;
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
            return xfw_currentFirstRendererOnAnim;
        }

        // Carousel
        override protected function arrowSlide():void
        {
            //Logger.add("UI_TankCarousel.arrowSlide()");
            try
            {
                super.arrowSlide();
                if (this.xfw_courseFactor == -1)
                {
                    if (this.xfw_currentFirstRendererOnAnim >= Math.ceil((_totalRenderers - xfw_visibleSlots) / cfg.rows))
                    {
                        this.currentFirstRenderer = _totalRenderers - this.xfw_visibleSlots;
                        this.xfw_courseFactor = 0;
                    }
                }
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        // Carousel
        override protected function handleMouseWheel(param1:MouseEvent):void
        {
            //Logger.add("UI_TankCarousel.handleMouseWheel(...)");
            try
            {
                if (param1.delta <= 0 && this.currentFirstRenderer * cfg.rows >= _totalRenderers - this.xfw_visibleSlots)
                    return;
                super.handleMouseWheel(param1);
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        override protected function showHideFilters():void
        {
            //Logger.add("UI_TankCarousel.showHideFilters()");
            try
            {
                rearrangeFilters();
                if (!Config.config.hangar.carousel.alwaysShowFilters)
                    super.showHideFilters();
                if (vehicleFilters.visible)
                {
                    leftArrow.x = this.vehicleFilters.x + this.vehicleFilters.width + FILTERS_CAROUSEL_OFFSET ^ 0;
                    this.vehicleFilters.visible = true;

                    updateDefContainerPos();
                    if (container && !slidingIsRunning && !isTween)
                    {
                        container.x = xfw_defContainerPos - currentFirstRenderer * slotWidth;
                        renderersMask.x = leftArrow.x + leftArrow.width;
                        dragHitArea.x = renderersMask.x;
                    }
                    updateVisibleSlotsCount();
                }
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        // PRIVATE

        private function checkRendererType(renderer:IListItemRenderer, slotType:int):Boolean
        {
            //Logger.add("UI_TankCarousel.checkRendererType(...)");
            try
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
            catch (ex:Error)
            {
                Logger.err(ex);
            }
            return false;
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

        private var _currentShowRendersCount:int;

        override protected function handleItemClick(e:ButtonEvent) : void
        {
            super.handleItemClick(e);
            if ((e.currentTarget as TankCarouselItemRenderer).activateButton == e.target)
            {
                _skipScrollToIndex = true;
            }
        }

        private function repositionRenderers():void
        {
            if (!_renderers)
                return;
            //Logger.add("UI_TankCarousel.repositionRenderers()");
            var renderer:IListItemRenderer = null;
            var selectedIndex:Number = 0;
            _currentShowRendersCount = 0;
            var n:int = 0;
            for (var i:Number = 0; i < _renderers.length; ++i)
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

            updateAdvancedSlots();
            removeEmptySlots();

            if (!_skipScrollToIndex)
            {
                scrollToIndex(selectedIndex);
            }
            _skipScrollToIndex = false;
        }

        private function updateTotalRenderers():void
        {
            //Logger.add("UI_TankCarousel.updateTotalRenderers()");

            var i:int;
            var renderer:UIComponent;

            _totalRenderers = _currentShowRendersCount;

            var visible:Boolean;
            i = findSlotIndex(SLOT_TYPE_BUYTANK);
            if (i >= 0)
            {
                renderer = getRendererAt(i) as UIComponent;
                visible = renderer.visible && Config.config.hangar.carousel.hideBuyTank != true;
                if (visible)
                {
                    ++_totalRenderers;
                }
            }

            i = findSlotIndex(SLOT_TYPE_BUYSLOT);
            if (i >= 0)
            {
                renderer = getRendererAt(i) as UIComponent;
                visible = renderer.visible && Config.config.hangar.carousel.hideBuySlot != true;
                if (visible)
                {
                    ++_totalRenderers;
                }
            }
        }

        private function updateAdvancedSlots():void
        {
            //Logger.add("UI_TankCarousel.updateAdvancedSlots()");

            var i:int;
            var renderer:UIComponent;

            _totalRenderers = _currentShowRendersCount;

            var visible:Boolean;
            i = findSlotIndex(SLOT_TYPE_BUYTANK);
            if (i >= 0)
            {
                renderer = getRendererAt(i) as UIComponent;
                visible = renderer.visible && Config.config.hangar.carousel.hideBuyTank != true;
                renderer.visible = visible;
                if (visible)
                {
                    renderer.x = padding.horizontal + Math.floor(_totalRenderers / cfg.rows) * (slotImageWidth + padding.horizontal);
                    renderer.y = (_totalRenderers % cfg.rows) * (slotImageHeight + padding.vertical);
                    ++_totalRenderers;
                }
            }

            i = findSlotIndex(SLOT_TYPE_BUYSLOT);
            if (i >= 0)
            {
                renderer = getRendererAt(i) as UIComponent;
                visible = renderer.visible && Config.config.hangar.carousel.hideBuySlot != true;
                renderer.visible = visible;
                if (visible)
                {
                    renderer.x = padding.horizontal + Math.floor(_totalRenderers / cfg.rows) * (slotImageWidth + padding.horizontal);
                    renderer.y = (_totalRenderers % cfg.rows) * (slotImageHeight + padding.vertical);
                    ++_totalRenderers;
                }
            }
        }

        private function removeEmptySlots():void
        {
            //Logger.add("UI_TankCarousel.removeEmptySlots()");

            if (_renderers == null)
                return;
            while (true)
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

        // FILTERS

        private function rearrangeFilters():void
        {
            //Logger.add("UI_TankCarousel.rearrangeFilters()");

            try
            {
                vehicleFilters.paramsFilter.visible = cfg.filters.params.enabled;
                vehicleFilters.bonusFilter.visible = cfg.filters.bonus.enabled;
                vehicleFilters.favoriteFilter.visible = cfg.filters.favorite.enabled;

                var visibleFilters:Vector.<UIComponent> = new Vector.<UIComponent>();
                if (cfg.filters.params.enabled)
                    visibleFilters.push(vehicleFilters.paramsFilter);
                if (cfg.filters.bonus.enabled)
                    visibleFilters.push(vehicleFilters.bonusFilter);
                if (cfg.filters.favorite.enabled)
                    visibleFilters.push(vehicleFilters.favoriteFilter);

                var rowWidth:int = cfg.filtersPadding.horizontal + 49;
                var columnHeight:int = cfg.filtersPadding.vertical + 20;

                var maxRows:int = Math.floor((height - 4) / columnHeight);
                for (var i:int = 0; i < visibleFilters.length; ++i)
                {
                    var col:int = Math.floor(i / maxRows);
                    var row:int = i % maxRows;
                    visibleFilters[i].x = col * rowWidth;
                    visibleFilters[i].y = row * columnHeight + 2;
                }

                vehicleFilters.width = (Math.floor((visibleFilters.length - 1) / maxRows) + 1) * rowWidth - 4;
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        private function call_setVehiclesFilter():void
        {
            setVehiclesFilter(vehicleFilters.bonusFilter.selected, vehicleFilters.favoriteFilter.selected, vehicleFilters.gameModeFilter.selected);
        }
    }
}
