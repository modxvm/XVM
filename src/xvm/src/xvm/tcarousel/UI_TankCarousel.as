package xvm.tcarousel
{
    import com.xvm.*;
    import com.xvm.controls.*;
    import com.xvm.io.*;
    import com.xvm.misc.*;
    import com.xvm.types.cfg.*;
    import com.xvm.types.dossier.*;
    import com.xvm.types.veh.*;
    import flash.display.*;
    import flash.events.*;
    import net.wg.gui.components.controls.*;
    import net.wg.gui.lobby.hangar.tcarousel.*;
    import net.wg.gui.lobby.hangar.tcarousel.data.*;
    import net.wg.gui.lobby.hangar.tcarousel.helper.*;
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
        private static const SETTINGS_CAROUSEL_FILTERS_KEY:String = "tcarousel.filters";

        private var cfg:CCarousel;

        private var _vehiclesVOManager:VehicleCarouselVOManager = null;

        private var levelFilter:LevelMultiSelectionDropDown;
        private var prefFilter:PrefMultiSelectionDropDown;

        public function UI_TankCarousel(cfg:CCarousel)
        {
            //Logger.add("UI_TankCarousel");
            super();
            this.cfg = cfg;

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

            slotImageWidth = int(162 * cfg.zoom);
            slotImageHeight = int(102 * cfg.zoom);
            var h:int = (slotImageHeight + padding.vertical) * cfg.rows - padding.vertical;
            height = h + 10;
            leftArrow.height = rightArrow.height = renderersMask.height = dragHitArea.height = h;

            componentInspectorSetting = false;
        }

        override protected function onDispose():void
        {
            this._vehiclesVOManager.clear();
            this._vehiclesVOManager = null;
            if (_baseDisposed)
                return;
            super.onDispose();
        }

        override protected function configUI():void
        {
            super.configUI();

            //return; // temporary disabled
            createFilters();
            Cmd.loadSettings(this, onFiltersLoaded, SETTINGS_CAROUSEL_FILTERS_KEY);
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
        override public function as_setParams(params:Object):void
        {
            super.as_setParams(params);
            repositionAdvancedSlots();
            removeEmptySlots();
        }

        override public function as_updateVehicles(data:Object, initial:Boolean):void
        {
            //Logger.addObject(data);
            if (!this._vehiclesVOManager)
                this._vehiclesVOManager = new VehicleCarouselVOManager();
            if (initial)
                this._vehiclesVOManager.setData(data);
            else
                this._vehiclesVOManager.updateData(data);
            super.as_updateVehicles(data, initial);
        }

        override public function as_showVehicles(vehIds:Array):void
        {
            super.as_showVehicles(applyXvmFilters(vehIds));
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
            rearrangeFilters();
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
            //Logger.add("repositionRenderers");
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
            //Logger.add("createFilters");

            /*addChild(createLabel("Filter", 0, 0));
            filterTextInput = App.utils.classFactory.getComponent("TextInput", TextInput);
            filterTextInput.x = 0;
            filterTextInput.y = 17;
            filterTextInput.width = 250; //65;
            filterTextInput.text = Config.config.userInfo.defaultFilterValue;
            filterTextInput.addEventListener(Event.CHANGE, onChange);
            filterTextInput.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
            addChild(filterTextInput);*/

            /*
            var nationFilter:NationMultiSelectionDropDown = addChild(new NationMultiSelectionDropDown()) as NationMultiSelectionDropDown;
            nationFilter.addEventListener(ListEvent.INDEX_CHANGE, setFilters);
            nationFilter.x = 5;
            nationFilter.y = 30;

            var classFilter:ClassMultiSelectionDropDown = addChild(new ClassMultiSelectionDropDown()) as ClassMultiSelectionDropDown;
            classFilter.addEventListener(ListEvent.INDEX_CHANGE, setFilters);
            classFilter.x = 5;
            classFilter.y = 60;
            */

            levelFilter = vehicleFilters.addChild(new LevelMultiSelectionDropDown()) as LevelMultiSelectionDropDown;
            levelFilter.addEventListener(ListEvent.INDEX_CHANGE, setFilters);

            prefFilter = vehicleFilters.addChild(new PrefMultiSelectionDropDown()) as PrefMultiSelectionDropDown;
            prefFilter.addEventListener(ListEvent.INDEX_CHANGE, setFilters);
        }

        private function rearrangeFilters():void
        {
            //Logger.add("rearrangeFilters");

            if (levelFilter == null)
                return;

            if (height >= 174)
            {
                vehicleFilters.width = 56;

                levelFilter.x = vehicleFilters.nationFilter.x;
                levelFilter.y = vehicleFilters.tankFilter.y + 33;

                prefFilter.x = levelFilter.x;
                prefFilter.y = levelFilter.y + 33;

                vehicleFilters.checkBoxToMain.y = prefFilter.y + 33;
            }
            else
            {
                vehicleFilters.width = 112;

                levelFilter.x = vehicleFilters.nationFilter.x + vehicleFilters.nationFilter.width + FILTER_MARGIN;
                levelFilter.y = vehicleFilters.nationFilter.y;

                prefFilter.x = levelFilter.x;
                prefFilter.y = vehicleFilters.tankFilter.y;

                vehicleFilters.checkBoxToMain.y = vehicleFilters.tankFilter.y + 33;
            }
        }

        private function onFiltersLoaded(filter_str:String):void
        {
            //Logger.add("onFilterLoaded: " + filter_str);
            try
            {
                var filter:Object = JSONx.parse(filter_str);
                if (filter != null)
                {
                    levelFilter.selectedItems = filter.levels;
                    prefFilter.selectedItems = filter.prefs;
                    onFilterChanged();
                }
            }
            catch (ex:Error)
            {
                Logger.add(ex.getStackTrace());
            }
        }

        private function setFilters(e:ListEvent):void
        {
            //Logger.add("setFilters");
            Cmd.saveSettings(SETTINGS_CAROUSEL_FILTERS_KEY,
                JSONx.stringify( { levels:levelFilter.selectedItems, prefs:prefFilter.selectedItems }, '', true));
            onFilterChanged();
        }

        private function applyXvmFilters(vehIds:Array):Array
        {
            if (levelFilter == null)
                return vehIds;

            //Logger.add("applyXvmFilters: " + vehIds.length);
            try
            {
                for (var i:int = vehIds.length - 1; i >= 0; --i)
                {
                    var vehId:int = vehIds[i];

                    var vdata:VehicleData = VehicleInfo.get(vehId);
                    if (vdata == null)
                        continue;

                    var dossier:AccountDossier = Dossier.getAccountDossier();
                    if (dossier == null)
                        continue;
                    var vdossier:VehicleDossierCut = dossier.getVehicleDossierCut(vehId);
                    if (vdossier == null)
                        continue;

                    var dataVO:VehicleCarouselVO = null;
                    for (var j:int = 0; j < _vehiclesVOManager.getVehiclesLen(); ++j)
                    {
                        var vo:VehicleCarouselVO = _vehiclesVOManager.getVOByNum(j);
                        if (vo != null && vo.compactDescr == vehId)
                        {
                            dataVO = vo;
                            break;
                        }
                    }
                    if (dataVO == null)
                        continue;

                    var remove:Boolean = false;
                    remove = levelFilter.selectedItems.length > 0 && levelFilter.selectedItems.indexOf(vdata.level) < 0;
                    remove = remove || (prefFilter.selectedItems.indexOf(PrefMultiSelectionDropDown.PREF_ELITE) >= 0 && dataVO.elite == false);
                    remove = remove || (prefFilter.selectedItems.indexOf(PrefMultiSelectionDropDown.PREF_PREMIUM) >= 0 && dataVO.premium == false);
                    remove = remove || (prefFilter.selectedItems.indexOf(PrefMultiSelectionDropDown.PREF_NORMAL) >= 0 && dataVO.premium == true);
                    remove = remove || (prefFilter.selectedItems.indexOf(PrefMultiSelectionDropDown.PREF_MULTIXP) >= 0 && dataVO.doubleXPReceived == true);
                    remove = remove || (prefFilter.selectedItems.indexOf(PrefMultiSelectionDropDown.PREF_NOMASTER) >= 0 && vdossier.mastery == 4);

                    if (remove)
                        vehIds.splice(i, 1);
                }
            }
            catch (ex:Error)
            {
                Logger.add(ex.getStackTrace());
            }

            //Logger.add("< " + vehIds.length);
            return vehIds;
        }
    }
}
