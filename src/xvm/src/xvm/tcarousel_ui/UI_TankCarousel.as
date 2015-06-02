/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package xvm.tcarousel_ui
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.controls.*;
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
        private static const FILTER_MARGIN:int = 5;
        private static const SETTINGS_CAROUSEL_FILTERS_KEY:String = "tcarousel.filters";

        private var cfg:CCarousel;

        private var _vehiclesVOManager:VehicleCarouselVOManager = null;

        private var levelFilter:LevelMultiSelectionDropDown;
        private var prefFilter:PrefMultiSelectionDropDown;
        private var lvlFilter:TileList;

        private var disableAllFilters:Boolean = false;

        public function UI_TankCarousel()
        {
            //Logger.add("UI_TankCarousel()");
            super();
            init();
        }

        private function init():void
        {
            this.cfg = Config.config.hangar.carousel;

            disableAllFilters = !(cfg.filters.nation || cfg.filters.type || cfg.filters.level || cfg.filters.prefs || cfg.filters.favorite);

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
            //Logger.add("UI_TankCarousel.onDispose()");

            if (this._vehiclesVOManager != null)
            {
                this._vehiclesVOManager.clear();
                this._vehiclesVOManager = null;
            }

            super.onDispose();
        }

        override protected function configUI():void
        {
            //Logger.add("UI_TankCarousel.configUI()");
            try
            {
                super.configUI();

                //return; // temporary disabled
                createFilters();
                onFiltersLoaded(JSONx.parse(Xfw.cmd(XvmCommands.LOAD_SETTINGS, SETTINGS_CAROUSEL_FILTERS_KEY, null)));
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
                //Logger.add("scrollToIndex: " + index + " xfw_visibleSlots: " + xfw_visibleSlots);
                if (!container || !_renderers)
                    return;
                var n:uint = Math.floor(xfw_visibleSlots / cfg.rows / 2);
                index = Math.floor(index / cfg.rows);
                currentFirstRenderer = Math.max(0, index - n);
                goToFirstRenderer();
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        // TankCarousel
        override public function as_setParams(params:Object):void
        {
            //Logger.add("UI_TankCarousel.as_setParams(...)");
            try
            {
                super.as_setParams(params);
                repositionAdvancedSlots();
                removeEmptySlots();
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        // TankCarousel
        override public function as_updateVehicles(data:Object, initial:Boolean):void
        {
            //Logger.add("UI_TankCarousel.as_updateVehicles(...)");
            try
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
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        // TankCarousel
        override public function as_showVehicles(vehIds:Array):void
        {
            //Logger.add("UI_TankCarousel.as_showVehicles(...)");
            try
            {
                super.as_showVehicles(applyXvmFilters(vehIds));
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        private var _isMouseOver:Boolean = false;
        override protected function onRendererItemRollOver(param1:VehicleCarouselVO):void
        {
            _isMouseOver = true;
            super.onRendererItemRollOver(param1);
        }

        override protected function onItemRollOut():void
        {
            _isMouseOver = false;
            super.onItemRollOut();
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
                if (isInvalid(InvalidationType.RENDERERS))
                {
                    //Logger.add("RENDERERS");
                    repositionRenderers();
                    //Logger.add("xfw_visibleSlots=" + xfw_visibleSlots + " _totalRenderers=" + _totalRenderers);
                }

                //Logger.add("updateUIPosition");
                repositionAdvancedSlots();
                removeEmptySlots();

                var slotWidth:Number = this.slotWidth;
                this.xfw_slotWidth = this.slotWidth / cfg.rows;
                super.updateUIPosition();
                this.xfw_slotWidth = slotWidth;

                if (this.bg)
                    bg.height = height;
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
                //Logger.add(" value=" + value + " currentFirstRenderer=" + v);
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
                if (disableAllFilters)
                {
                    leftArrow.x = this.vehicleFilters.x;
                    this.vehicleFilters.visible = false;
                    this.vehicleFilters.close();
                }
                else if (Config.config.hangar.carousel.alwaysShowFilters == true)
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
                else
                {
                    super.showHideFilters();
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

        private function repositionRenderers():void
        {
            //Logger.add("UI_TankCarousel.repositionRenderers()");
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
            //Logger.add("UI_TankCarousel.repositionAdvancedSlots()");

            var i:int;
            var renderer:UIComponent;

            _totalRenderers = _currentShowRendersCount;

            i = findSlotIndex(SLOT_TYPE_BUYTANK);
            if (i >= 0)
            {
                renderer = getRendererAt(i) as UIComponent;
                renderer.visible = Config.config.hangar.carousel.hideBuyTank != true;
                if (renderer.visible)
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
                renderer.visible = Config.config.hangar.carousel.hideBuySlot != true;
                if (renderer.visible)
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

        private function createFilters():void
        {
            //Logger.add("UI_TankCarousel.createFilters()");

            try
            {
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

                /*
                lvlFilter = vehicleFilters.addChild(App.utils.classFactory.getComponent("TileListUI", TileList)) as TileList;
                lvlFilter.x = 0;
                lvlFilter.y = 0;
                lvlFilter.visible = true;
                lvlFilter.columnCount = 5;
                lvlFilter.columnWidth = 10;
                lvlFilter.rowHeight = 10;
                */
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        private function rearrangeFilters():void
        {
            //Logger.add("UI_TankCarousel.rearrangeFilters()");

            try
            {
                if (levelFilter == null)
                    return;

                var visibleFilters:Vector.<UIComponent> = new Vector.<UIComponent>();
                vehicleFilters.nationFilter.visible = cfg.filters.nation.enabled;
                vehicleFilters.tankFilter.visible = cfg.filters.type.enabled;
                levelFilter.visible = cfg.filters.level.enabled;
                prefFilter.visible = cfg.filters.prefs.enabled;
                vehicleFilters.checkBoxToMain.visible = cfg.filters.favorite.enabled;

                if (cfg.filters.nation.enabled)
                    visibleFilters.push(vehicleFilters.nationFilter);
                if (cfg.filters.type.enabled)
                    visibleFilters.push(vehicleFilters.tankFilter);
                if (cfg.filters.level.enabled)
                    visibleFilters.push(levelFilter);
                if (cfg.filters.prefs.enabled)
                    visibleFilters.push(prefFilter);
                if (cfg.filters.favorite.enabled)
                    visibleFilters.push(vehicleFilters.checkBoxToMain);

                var w:int = 0;
                var maxRows:int = Math.floor((height - 4) / 34);
                for (var i:int = 0; i < visibleFilters.length; ++i)
                {
                    var offsetX:Number = 0;
                    var offsetY:Number = 0;
                    if (visibleFilters[i] == vehicleFilters.checkBoxToMain)
                    {
                        offsetX += 3;
                        offsetY += 3;
                    }

                    var col:int = Math.floor(i / maxRows);
                    var row:int = i % maxRows;

                    visibleFilters[i].x = col * 60 + offsetX;
                    visibleFilters[i].y = row * 34 + 2 + offsetY;
                    w = (col + 1) * 60 - 4;
                }

                vehicleFilters.width = w;
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        private function onFiltersLoaded(filter:Object):void
        {
            //Logger.add("UI_TankCarousel.onFiltersLoaded()");

            try
            {
                if (filter != null)
                {
                    levelFilter.selectedItems = filter.levels;
                    prefFilter.selectedItems = filter.prefs;
                    onFilterChanged();
                }
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        private function setFilters(e:ListEvent):void
        {
            //Logger.add("UI_TankCarousel.setFilters()");

            try
            {
                Xfw.cmd(XvmCommands.SAVE_SETTINGS, SETTINGS_CAROUSEL_FILTERS_KEY,
                    JSONx.stringify({ levels:levelFilter.selectedItems, prefs:prefFilter.selectedItems }, "", true));
                onFilterChanged();
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        private function applyXvmFilters(vehIds:Array):Array
        {
            //Logger.add("UI_TankCarousel.applyXvmFilters(...)");

            try
            {
                if (levelFilter == null)
                    return vehIds;

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

                    //Logger.addObject(dataVO);

                    var remove:Boolean = false;
                    remove = levelFilter.selectedItems.length > 0 && levelFilter.selectedItems.indexOf(vdata.level) < 0;
                    remove = remove || (prefFilter.selectedItems.indexOf(PrefMultiSelectionDropDown.PREF_NON_ELITE) >= 0 && dataVO.elite == true);
                    remove = remove || (prefFilter.selectedItems.indexOf(PrefMultiSelectionDropDown.PREF_MULTIXP) >= 0 && dataVO.doubleXPReceived < 0);
                    remove = remove || (prefFilter.selectedItems.indexOf(PrefMultiSelectionDropDown.PREF_NOMASTER) >= 0 && vdossier.mastery == 4);
                    remove = remove || (prefFilter.selectedItems.indexOf(PrefMultiSelectionDropDown.PREF_FULLCREW) >= 0 && dataVO.stat == VehicleState.CREW_NOT_FULL);
                    remove = remove || (prefFilter.selectedItems.indexOf(PrefMultiSelectionDropDown.PREF_NON_DOMINATION) >= 0 && dataVO.groupIndicatorVisible);

                    var removePrem:Boolean = prefFilter.selectedItems.indexOf(PrefMultiSelectionDropDown.PREF_PREMIUM) >= 0;
                    var removeNorm:Boolean = prefFilter.selectedItems.indexOf(PrefMultiSelectionDropDown.PREF_NORMAL) >= 0;
                    if (removePrem != removeNorm)
                    {
                        remove = remove || removePrem && dataVO.premium == false;
                        remove = remove || removeNorm && dataVO.premium == true;
                    }

                    if (remove)
                        vehIds.splice(i, 1);
                }
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }

            //Logger.add("< " + vehIds.length);
            return vehIds;
        }
    }
}
