package xvm.tcarousel
{
    import com.xvm.*;
    import com.xvm.controls.*;
    import com.xvm.types.cfg.*;
    import flash.display.*;
    import flash.events.*;
    import net.wg.gui.components.controls.*;
    import net.wg.gui.lobby.hangar.tcarousel.*;
    import net.wg.gui.lobby.hangar.tcarousel.data.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.events.*;
    import scaleform.clik.interfaces.*;

    public /*dynamic*/ class UI_TankCarousel extends TankCarouselUI
    {
        private static const SLOT_TYPE_TANK:int = 1;
        private static const SLOT_TYPE_BUYTANK:int = 2;
        private static const SLOT_TYPE_BUYSLOT:int = 3;
        private static const SLOT_TYPE_EMPTY:int = 4;
        private static const FILTER_MARGIN:int = 5;

        private var cfg:CCarousel;

        private var premiumFilter:CheckBox;
        private var multiXpFilter:CheckBox;
        private var eliteFilter:CheckBox;

        public function UI_TankCarousel(cfg:CCarousel)
        {
            //Logger.add("UI_TankCarousel");
            super();
            this.cfg = cfg;
            createFilters();
        }

        // TankCarousel
        override public function scrollToIndex(index:uint):void
        {
            //Logger.add("scrollToIndex: " + index + " _visibleSlots: " + _visibleSlots);
            if (!container || !_renderers)
                return;
            var n:uint = Math.floor(_visibleSlots / cfg.rows / 2);
            index = Math.floor(index / cfg.rows);
            currentFirstRenderer = Math.max(0, index - n);
            goToFirstRenderer();
        }

        // TankCarousel
        override public function as_setParams(param1:Object):void
        {
            super.as_setParams(param1);
            repositionAdvancedSlots();
            removeEmptySlots();
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
            if (isInvalid(InvalidationType.RENDERERS))
            {
                //Logger.add("RENDERERS");
                repositionRenderers();
                //Logger.add("_visibleSlots=" + _visibleSlots + " _renderers.length=" + _renderers.length);
            }

            //Logger.add("updateUIPosition");
            repositionAdvancedSlots();
            removeEmptySlots();

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
            if (_renderers == null)
                return;
            this.scopeWidth = Math.ceil(Math.max(_renderers.length, _visibleSlots) / cfg.rows) * this.slotWidth + this.padding.horizontal;
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
            //Logger.add("getCurrentFirstRendererOnAnim: " + _currentFirstRendererOnAnim);
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

        override protected function showHideFilters():void
        {
            if (Config.config.hangar.carousel.alwaysShowFilters == true)
            {
                leftArrow.x = this.vehicleFilters.x + this.vehicleFilters.width + FILTERS_CAROUSEL_OFFSET ^ 0;
                this.vehicleFilters.visible = true;
                updateDefContainerPos();
                if (container && (slidingIntervalId == 0) && !isTween)
                {
                    container.x = _defContainerPos - currentFirstRenderer * slotWidth;
                    renderersMask.x = leftArrow.x + leftArrow.width;
                    dragHitArea.x = renderersMask.x;
                }
                updateVisibleSlotsCount();
            }
            else
            {
                super.showHideFilters();
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
            //Logger.add("repositionAdvancedSlots");

            var i:int;
            var renderer:IListItemRenderer;

            _totalRenderers = _currentShowRendersCount;

            i = findSlotIndex(SLOT_TYPE_BUYTANK);
            if (i >= 0)
            {
                renderer = getRendererAt(i);
                if (Config.config.hangar.carousel.hideBuyTank == true)
                {
                    if (this._slotForBuyVehicle)
                    {
                        this.cleanUpRenderer(this._slotForBuyVehicle);
                        this._slotForBuyVehicle = null;
                    }
                }
                else
                {
                    renderer.x = padding.horizontal + Math.floor(_totalRenderers / cfg.rows) * (slotImageWidth + padding.horizontal);
                    renderer.y = (_totalRenderers % cfg.rows) * (slotImageHeight + padding.vertical);
                    ++_totalRenderers;
                }
            }

            i = findSlotIndex(SLOT_TYPE_BUYSLOT);
            if (i >= 0)
            {
                renderer = getRendererAt(i);
                if (Config.config.hangar.carousel.hideBuySlot == true)
                {
                    if (this._slotForBuySlot)
                    {
                        this.cleanUpRenderer(this._slotForBuySlot);
                        this._slotForBuySlot = null;
                    }
                }
                else
                {
                    renderer.x = padding.horizontal + Math.floor(_totalRenderers / cfg.rows) * (slotImageWidth + padding.horizontal);
                    renderer.y = (_totalRenderers % cfg.rows) * (slotImageHeight + padding.vertical);
                    ++_totalRenderers;
                }
            }
        }

        private function removeEmptySlots():void
        {
            //Logger.add("removeEmptySlots");
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

        private function createFilters():void
        {
            return;
            /*addChild(createLabel("Filter", 0, 0));
            filterTextInput = App.utils.classFactory.getComponent("TextInput", TextInput);
            filterTextInput.x = 0;
            filterTextInput.y = 17;
            filterTextInput.width = 250; //65;
            filterTextInput.text = Config.config.userInfo.defaultFilterValue;
            filterTextInput.addEventListener(Event.CHANGE, onChange);
            filterTextInput.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
            addChild(filterTextInput);*/

            var nationFilter:NationMultiSelectionDropDown = addChild(new NationMultiSelectionDropDown()) as NationMultiSelectionDropDown;
            nationFilter.addEventListener(ListEvent.INDEX_CHANGE, setFilters);
            nationFilter.x = 5;
            nationFilter.y = 30;

            var classFilter:ClassMultiSelectionDropDown = addChild(new ClassMultiSelectionDropDown()) as ClassMultiSelectionDropDown;
            classFilter.addEventListener(ListEvent.INDEX_CHANGE, setFilters);
            classFilter.x = 5;
            classFilter.y = 60;

            //addChild(createLabel("Level", 175, 0));
            var levelFilter:LevelMultiSelectionDropDown = addChild(new LevelMultiSelectionDropDown()) as LevelMultiSelectionDropDown;
            levelFilter.x = 5;
            levelFilter.y = 90;
            levelFilter.addEventListener(ListEvent.INDEX_CHANGE, setFilters);

            //addChild(createLabel("Type", 285, 0));
            var prefFilter:PrefMultiSelectionDropDown = addChild(new PrefMultiSelectionDropDown()) as PrefMultiSelectionDropDown;
            prefFilter.addEventListener(ListEvent.INDEX_CHANGE, setFilters);
            prefFilter.x = 5;
            prefFilter.y = 120;
        }

        private function setFilters() : void
        {
            /*var _loc_1:* = new Array();
            _loc_1.push(App.utils.JSON.encode({levels:this.levelFilter.selectedItems, types:this.typeFilter.selectedItems}));
            _loc_1.unshift("xvm.tankcarousel.setFilters", "tankcarousel");
            ExternalInterface.call.apply(null, _loc_1);
            this.page.carousel.onFilterChanged();
            */
        }
    }
}
