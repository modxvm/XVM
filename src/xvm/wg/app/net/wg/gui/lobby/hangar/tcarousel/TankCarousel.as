package net.wg.gui.lobby.hangar.tcarousel 
{
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.events.*;
    import net.wg.data.components.*;
    import net.wg.data.constants.*;
    import net.wg.gui.components.controls.*;
    import net.wg.gui.events.*;
    import net.wg.infrastructure.base.meta.*;
    import net.wg.infrastructure.base.meta.impl.*;
    import net.wg.infrastructure.interfaces.*;
    import net.wg.infrastructure.interfaces.entity.*;
    import net.wg.utils.*;
    import scaleform.clik.data.*;
    import scaleform.clik.events.*;
    import scaleform.clik.interfaces.*;
    
    public class TankCarousel extends net.wg.infrastructure.base.meta.impl.TankCarouselMeta implements net.wg.infrastructure.base.meta.ITankCarouselMeta, net.wg.infrastructure.interfaces.IDAAPIModule, net.wg.infrastructure.interfaces.IHelpLayoutComponent
    {
        public function TankCarousel()
        {
            this.filterData = {};
            super();
            dragHitArea = this.dragHitArea1;
            leftArrow = this.leftArrow1;
            rightArrow = this.rightArrow1;
            renderersMask = this.renderersMask1;
            this.nationFilter = this.vehicleFilters.nationFilter;
            this.tankFilter = this.vehicleFilters.tankFilter;
            this.checkBoxToMain = this.vehicleFilters.checkBoxToMain;
            bg = this.bg1;
            return;
        }

        protected override function onItemRollOver(arg1:net.wg.gui.events.ListEventEx):void
        {
            var loc1:*=arg1.itemData;
            if (net.wg.gui.lobby.hangar.tcarousel.TankCarouselItemRenderer(arg1.itemRenderer).empty) 
            {
                return;
            }
            if (loc1.buyTank) 
            {
                App.toolTipMgr.showComplex(TOOLTIPS.TANKS_CAROUSEL_BUY_VEHICLE);
                return;
            }
            if (loc1.buySlot) 
            {
                App.toolTipMgr.showComplex(TOOLTIPS.TANKS_CAROUSEL_BUY_SLOT);
                return;
            }
            App.toolTipMgr.showSpecial(net.wg.data.constants.Tooltips.CAROUSEL_VEHICLE, null, loc1.inventoryId);
            return;
        }

        protected override function onItemRollOut(arg1:net.wg.gui.events.ListEventEx):void
        {
            App.toolTipMgr.hide();
            return;
        }

        protected override function onItemStartDrag(arg1:net.wg.gui.events.ListEventEx):void
        {
            App.toolTipMgr.hide();
            super.onItemStartDrag(arg1);
            return;
        }

        protected override function handleItemClick(arg1:scaleform.clik.events.ButtonEvent):void
        {
            App.toolTipMgr.hide();
            if (needCanceledClick) 
            {
                return;
            }
            var loc1:*=arg1.currentTarget as scaleform.clik.interfaces.IListItemRenderer;
            var loc2:*=loc1.index;
            if (loc2 > (dataProvider.length - 1)) 
            {
                return;
            }
            var loc3:*=dataProvider[loc1.index];
            var loc4:*=(arg1 as scaleform.clik.events.ButtonEvent).buttonIdx;
            if (isNaN(loc2)) 
            {
                return;
            }
            if (dispatchItemEvent(arg1)) 
            {
                if ((useRightButton && useRightButtonForSelect || loc4 == 0) && !loc3.buyTank && !loc3.buySlot) 
                {
                    selectedIndex = loc2;
                }
            }
            return;
        }

        protected override function onItemClick(arg1:net.wg.gui.events.ListEventEx):void
        {
            var loc1:*=arg1.itemData;
            if (loc1.empty) 
            {
                return;
            }
            if (loc1.buyTank && arg1.buttonIdx == 0) 
            {
                (arg1.itemRenderer as flash.display.MovieClip).mouseEnabled = false;
                (arg1.itemRenderer as flash.display.MovieClip).mouseChildren = false;
                this.tryBuyTank(loc1);
                return;
            }
            if (loc1.buySlot && arg1.buttonIdx == 0) 
            {
                this.tryBuySlot(loc1);
                return;
            }
            if (arg1.buttonIdx != 0) 
            {
                if (arg1.buttonIdx == 1 && !loc1.buyTank && !loc1.buySlot && slidingIntervalId == 0 && !isTween && arrowSlideIntervalId == 0) 
                {
                    this.showContextMenu(loc1);
                }
            }
            else 
            {
                this.selectItem(loc1.id);
            }
            return;
        }

        internal function initFilters():void
        {
            this.tankFilter.dataProvider = new scaleform.clik.data.DataProvider(getVehicleTypeProviderS());
            this.tankFilter.menuRowCount = this.tankFilter.dataProvider.length;
            var loc1:*=App.utils.nations;
            var loc2:*=loc1.getNationsData();
            var loc3:*=[{"label":MENU.NATIONS_ALL, "data":net.wg.gui.lobby.hangar.tcarousel.TankCarouselFilters.FILTER_ALL_NATION, "icon":"../maps/icons/filters/nations/all.png"}];
            var loc4:*=0;
            while (loc4 < loc2.length) 
            {
                loc2[loc4]["icon"] = "../maps/icons/filters/nations/" + loc1.getNationName(loc2[loc4]["data"]) + ".png";
                loc3.push(loc2[loc4]);
                ++loc4;
            }
            this.nationFilter.dataProvider = new scaleform.clik.data.DataProvider(loc3);
            if (!this.filterData.hasOwnProperty("nation")) 
            {
                this.filterData.nation = net.wg.gui.lobby.hangar.tcarousel.TankCarouselFilters.FILTER_ALL_NATION;
                this.filterData.tankType = net.wg.gui.lobby.hangar.tcarousel.TankCarouselFilters.FILTER_ALL_TYPES;
                this.filterData.ready = false;
                this.tankFilter.selectedIndex = 0;
                this.nationFilter.selectedIndex = 0;
            }
            this.updateFiltersData();
            this.tankFilter.addEventListener(scaleform.clik.events.ListEvent.INDEX_CHANGE, this.onTankDropDownFilterChanged);
            this.nationFilter.addEventListener(scaleform.clik.events.ListEvent.INDEX_CHANGE, this.onNatiDropDownFilterChanged);
            this.checkBoxToMain.addEventListener(flash.events.Event.SELECT, this.onFilterCheckBoxChanged);
            return;
        }

        internal function showHideFilters(arg1:Boolean):void
        {
            if (arg1) 
            {
                if (arg1) 
                {
                    leftArrow.x = this.vehicleFilters.x + this.vehicleFilters.width + FILTERS_CAROUSEL_OFFSET ^ 0;
                    this.vehicleFilters.visible = true;
                }
            }
            else 
            {
                leftArrow.x = this.vehicleFilters.x;
                this.vehicleFilters.visible = false;
                this.vehicleFilters.close();
            }
            if (container && slidingIntervalId == 0 && !isTween) 
            {
                container.x = getDefContainerPos() - currentFirstRenederer * getSlotWidth();
                renderersMask.x = leftArrow.x + leftArrow.width;
                dragHitArea.x = renderersMask.x;
            }
            return;
        }

        public function get emptySlotsCountForByTank():Number
        {
            return this.__emptySlotsCountForByTank;
        }

        internal function updateFiltersData():void
        {
            var loc1:*=NaN;
            var loc2:*=NaN;
            if (!initialized) 
            {
                invalidate();
                return;
            }
            if (this.filterDataInvalid) 
            {
                this.filterDataInvalid = false;
                loc1 = 0;
                while (loc1 < this.nationFilter.dataProvider.length) 
                {
                    if (this.nationFilter.dataProvider[loc1].data == this.filterData.nation) 
                    {
                        this.nationFilter.selectedIndex = loc1;
                        break;
                    }
                    ++loc1;
                }
                loc2 = 0;
                while (loc2 < this.tankFilter.dataProvider.length) 
                {
                    if (this.tankFilter.dataProvider[loc2].data == this.filterData.tankType) 
                    {
                        this.tankFilter.selectedIndex = loc2;
                        break;
                    }
                    ++loc2;
                }
                this.checkBoxToMain.selected = this.filterData.ready;
            }
            return;
        }

        internal function tryBuyTank(arg1:Object):void
        {
            buyTankClickS();
            return;
        }

        internal function tryBuySlot(arg1:Object):void
        {
            buySlotS();
            return;
        }

        internal function selectItem(arg1:String):void
        {
            vehicleChangeS(arg1);
            return;
        }

        internal function setData(arg1:Object):void
        {
            if (this.availableTanksCount != arg1.slots.length) 
            {
                tryClearTween();
            }
            this.slotPrice = arg1.slotPrice;
            this.selectedTankID = arg1.selectedTankID;
            this.availableTanksCount = arg1.slots.length;
            this.emptySlotsCountForByTank = arg1.availableSlotsForBuy;
            this.allTanksCount = arg1.allTanksCount;
            if (this.allTanksCount == 0) 
            {
                visible = false;
                return;
            }
            visible = true;
            var loc1:*=-1;
            var loc2:*=0;
            while (loc2 < arg1.slots.length) 
            {
                if (arg1.slots[loc2].id == this.selectedTankID) 
                {
                    loc1 = loc2;
                    break;
                }
                ++loc2;
            }
            this.firstRun = selectedIndex == loc1 ? false : true;
            selectedIndex = loc1;
            if (this.emptySlotsCountForByTank > 0) 
            {
                arg1.slots.push(this.getSlotDataForBuyTank());
            }
            arg1.slots.push(this.getSlotDataForBuySlot());
            dataProvider = new scaleform.clik.data.DataProvider(arg1.slots);
            return;
        }

        internal function getSlotDataForBuyTank():Object
        {
            var loc1:*={"stat":"buyTank", "favorite":false, "canSell":false, "clanLock":-1, "elite":false, "premium":false, "enabled":true, "empty":false, "buyTank":true, "buySlot":false, "avalibleSlots":this.emptySlotsCountForByTank, "slotPrice":this.slotPrice};
            return loc1;
        }

        internal function getSlotDataForBuySlot():Object
        {
            var loc1:*={"stat":"buySlot", "favorite":false, "canSell":false, "clanLock":-1, "elite":false, "premium":false, "enabled":true, "empty":false, "buyTank":false, "buySlot":true, "avalibleSlots":this.emptySlotsCountForByTank, "slotPrice":this.slotPrice};
            return loc1;
        }

        internal function onFilterCheckBoxChanged(arg1:flash.events.Event):void
        {
            this.filterData.ready = this.checkBoxToMain.selected;
            this.onFilterChanged();
            return;
        }

        internal function onTankDropDownFilterChanged(arg1:scaleform.clik.events.ListEvent):void
        {
            this.filterData.tankType = arg1.itemData.data;
            this.onFilterChanged();
            return;
        }

        internal function onNatiDropDownFilterChanged(arg1:scaleform.clik.events.ListEvent):void
        {
            this.filterData.nation = arg1.itemData.data;
            this.onFilterChanged();
            return;
        }

        internal function onContectMenuItemSelect(arg1:net.wg.gui.events.ContextMenuEvent):void
        {
            var loc1:*=arg1.memberItemData;
            var loc2:*=arg1.id;
            switch (loc2) 
            {
                case "vehicleInfo":
                {
                    showVehicleInfoS(loc1.id);
                    break;
                }
                case "vehicleSell":
                {
                    vehicleSellS(loc1.inventoryId);
                    break;
                }
                case "vehicleResearch":
                {
                    toResearchS(loc1.compactDescr);
                    break;
                }
                case "vehicleCheck":
                {
                    favoriteVehicleS(loc1.id, true);
                    break;
                }
                case "vehicleUncheck":
                {
                    favoriteVehicleS(loc1.id, false);
                    break;
                }
            }
            return;
        }

        public function onFilterChanged():void
        {
            setVehiclesFilterS(this.filterData.nation, this.filterData.tankType, this.filterData.ready);
            return;
        }

        public function showHelpLayout():void
        {
            var loc1:*=null;
            var loc2:*=null;
            if (container) 
            {
                this._isShowHelpLayout = true;
                loc1 = App.utils.helpLayout;
                loc2 = loc1.getProps(162, 102, net.wg.data.constants.Directions.RIGHT, LOBBY_HELP.HANGAR_VEHICLE_CAROUSEL, getDefContainerPos() + padding.left + padding.right, container.y);
                this._rendererHelpLayout = loc1.create(root, loc2, this);
            }
            return;
        }

        public function closeHelpLayout():void
        {
            this._isShowHelpLayout = false;
            var loc1:*=App.utils.helpLayout;
            loc1.destroy(this._rendererHelpLayout);
            return;
        }

        public function normalizeData(arg1:Object):Object
        {
            var loc1:*=0;
            if (arg1) 
            {
                if (arg1.slots) 
                {
                    loc1 = 0;
                    while (loc1 < arg1.slots.length) 
                    {
                        arg1.slots[loc1].data = arg1.slots[loc1].data == undefined ? 0 : arg1.slots[loc1].data;
                        arg1.slots[loc1].id = arg1.slots[loc1].id == undefined ? "id_" + loc1 : arg1.slots[loc1].id;
                        arg1.slots[loc1].inventoryId = arg1.slots[loc1].inventoryId == undefined ? loc1 : arg1.slots[loc1].inventoryId;
                        arg1.slots[loc1].label = arg1.slots[loc1].label == undefined ? "" : arg1.slots[loc1].label;
                        arg1.slots[loc1].image = arg1.slots[loc1].image == undefined ? "" : arg1.slots[loc1].image;
                        arg1.slots[loc1].nation = arg1.slots[loc1].nation == undefined ? 1 : arg1.slots[loc1].nation;
                        arg1.slots[loc1].level = arg1.slots[loc1].level == undefined ? 1 : arg1.slots[loc1].level;
                        arg1.slots[loc1].stat = arg1.slots[loc1].stat == undefined ? "" : arg1.slots[loc1].stat;
                        arg1.slots[loc1].stateLevel = arg1.slots[loc1].stateLevel == undefined ? "" : arg1.slots[loc1].stateLevel;
                        arg1.slots[loc1].doubleXPReceived = arg1.slots[loc1].doubleXPReceived == undefined ? 0 : arg1.slots[loc1].doubleXPReceived;
                        arg1.slots[loc1].compactDescr = arg1.slots[loc1].compactDescr == undefined ? 0 : arg1.slots[loc1].compactDescr;
                        arg1.slots[loc1].favorite = arg1.slots[loc1].favorite == undefined ? false : arg1.slots[loc1].favorite;
                        arg1.slots[loc1].canSell = arg1.slots[loc1].canSell == undefined ? false : arg1.slots[loc1].canSell;
                        arg1.slots[loc1].clanLock = arg1.slots[loc1].clanLock == undefined ? -1 : arg1.slots[loc1].clanLock;
                        arg1.slots[loc1].elite = arg1.slots[loc1].elite == undefined ? false : arg1.slots[loc1].elite;
                        arg1.slots[loc1].premium = arg1.slots[loc1].premium == undefined ? false : arg1.slots[loc1].premium;
                        arg1.slots[loc1].tankType = arg1.slots[loc1].tankType == undefined ? "" : arg1.slots[loc1].tankType;
                        arg1.slots[loc1].exp = arg1.slots[loc1].exp == undefined ? 0 : arg1.slots[loc1].exp;
                        arg1.slots[loc1].current = arg1.slots[loc1].current == undefined ? loc1 : arg1.slots[loc1].current;
                        arg1.slots[loc1].enabled = arg1.slots[loc1].enabled == undefined ? false : arg1.slots[loc1].enabled;
                        arg1.slots[loc1].empty = arg1.slots[loc1].empty == undefined ? null : arg1.slots[loc1].empty;
                        arg1.slots[loc1].buyTank = arg1.slots[loc1].buyTank == undefined ? false : arg1.slots[loc1].buyTank;
                        arg1.slots[loc1].buySlot = arg1.slots[loc1].buySlot == undefined ? false : arg1.slots[loc1].buySlot;
                        arg1.slots[loc1].avalibleSlots = arg1.slots[loc1].avalibleSlots == undefined ? 0 : arg1.slots[loc1].avalibleSlots;
                        ++loc1;
                    }
                }
            }
            return arg1;
        }

        public function as_vehiclesResponse(arg1:Object):void
        {
            var loc1:*=this.normalizeData(arg1);
            this.setData(loc1);
            return;
        }

        public function as_setCarouselFilter(arg1:Object):void
        {
            this.filterData = arg1;
            this.filterDataInvalid = true;
            this.updateFiltersData();
            return;
        }

        public function as_changeVehicleByCompDescr(arg1:Number):void
        {
            return;
        }

        public function as_populate():void
        {
            return;
        }

        public function as_dispose():void
        {
            if (this.tankFilter.hasEventListener(scaleform.clik.events.ListEvent.INDEX_CHANGE)) 
            {
                this.tankFilter.removeEventListener(scaleform.clik.events.ListEvent.INDEX_CHANGE, this.onTankDropDownFilterChanged);
            }
            if (this.checkBoxToMain.hasEventListener(flash.events.Event.SELECT)) 
            {
                this.checkBoxToMain.removeEventListener(flash.events.Event.SELECT, this.onFilterCheckBoxChanged);
            }
            if (this.nationFilter.hasEventListener(scaleform.clik.events.ListEvent.INDEX_CHANGE)) 
            {
                this.nationFilter.removeEventListener(scaleform.clik.events.ListEvent.INDEX_CHANGE, this.onNatiDropDownFilterChanged);
            }
            super.dispose();
            App.contextMenuMgr.hide();
            return;
        }

        public function get availableTanksCount():Number
        {
            return this.__availableTanksCount;
        }

        public function set availableTanksCount(arg1:Number):void
        {
            this.__availableTanksCount = arg1;
            return;
        }

        public function get allTanksCount():Number
        {
            return this.__allTanksCount;
        }

        public function set allTanksCount(arg1:Number):void
        {
            this.__allTanksCount = arg1;
            return;
        }

        internal function showContextMenu(arg1:Object):void
        {
            var loc1:*=arg1.favorite ? "vehicleUncheck" : "vehicleCheck";
            App.contextMenuMgr.show(Vector.<net.wg.infrastructure.interfaces.IContextItem>([new net.wg.data.components.UserContextItem("vehicleInfo"), new net.wg.data.components.UserContextItem("vehicleSell", {"enabled":arg1.canSell}), new net.wg.data.components.UserContextItem("vehicleResearch"), new net.wg.data.components.UserContextItem(loc1)]), this, this.onContectMenuItemSelect, arg1);
            return;
        }

        public function set emptySlotsCountForByTank(arg1:Number):void
        {
            this.__emptySlotsCountForByTank = arg1;
            return;
        }

        public function get disposed():Boolean
        {
            return false;
        }

        protected override function configUI():void
        {
            this.initFilters();
            super.configUI();
            return;
        }

        protected override function handleMouseWheel(arg1:flash.events.MouseEvent):void
        {
            if (enabled && dragHitArea.hitTestPoint(stage.mouseX, stage.mouseY) && !isDragging) 
            {
                super.handleMouseWheel(arg1);
            }
            return;
        }

        protected override function initUIStartPosition():void
        {
            this.vehicleFilters.x = contentMargin;
            this.vehicleFilters.y = contentMargin;
            super.initUIStartPosition();
            return;
        }

        protected override function updateVisibleSlots():Number
        {
            var loc1:*=0;
            if (this.availableTanksCount == this.allTanksCount) 
            {
                loc1 = this.vehicleFilters.x;
                visibleSlots = (_allowW - (loc1 + leftArrow.width + rightArrow.width + CAROUSEL_BUTTON_ARROW_OFFSET * 2 + contentMargin + padding.horizontal)) / getSlotWidth() ^ 0;
                if (visibleSlots < this.calculateRendererTotal(0, 0)) 
                {
                    loc1 = this.vehicleFilters.x + this.vehicleFilters.width + FILTERS_CAROUSEL_OFFSET ^ 0;
                }
            }
            else 
            {
                loc1 = this.vehicleFilters.x + this.vehicleFilters.width + FILTERS_CAROUSEL_OFFSET ^ 0;
            }
            visibleSlots = (_allowW - (loc1 + leftArrow.width + rightArrow.width + CAROUSEL_BUTTON_ARROW_OFFSET * 2 + contentMargin + padding.horizontal)) / getSlotWidth() ^ 0;
            return visibleSlots;
        }

        protected override function calculateRendererTotal(arg1:Number, arg2:Number):uint
        {
            var loc1:*=0;
            if (_dataProvider.length > 0) 
            {
                loc1 = this.emptySlotsCountForByTank > 0 ? this.availableTanksCount + 2 : this.availableTanksCount + 1;
            }
            return loc1;
        }

        protected override function updateLayout():void
        {
            if (initialized && _renderers) 
            {
                this.showHideFilters(visibleSlots < this.calculateRendererTotal(0, 0) || !(this.availableTanksCount == this.allTanksCount));
                super.updateLayout();
                if (this._isShowHelpLayout) 
                {
                    this.closeHelpLayout();
                    this.showHelpLayout();
                }
            }
            return;
        }

        protected override function draw():void
        {
            super.draw();
            return;
        }

        protected override function refreshData():void
        {
            super.refreshData();
            if (this.firstRun) 
            {
                scrollToIndex(Math.max(selectedIndex, 0));
                this.firstRun = false;
            }
            return;
        }

        protected override function populateData(arg1:Array):void
        {
            var loc4:*=null;
            var loc5:*=0;
            var loc6:*=null;
            var loc1:*=arg1.length;
            var loc2:*=_renderers.length;
            var loc3:*=0;
            while (loc3 < loc2) 
            {
                loc4 = getRendererAt(loc3) as net.wg.gui.lobby.hangar.tcarousel.TankCarouselItemRenderer;
                loc5 = loc3;
                loc6 = new scaleform.clik.data.ListData(loc5, itemToLabel(arg1[loc3]), _selectedIndex == loc5);
                loc4.enabled = loc3 < loc1 && enabled;
                loc4.dragEnabled = dragEnabled;
                loc4.setListData(loc6);
                loc4.setData(loc3 >= loc1 ? this.getEmptyRendererData() : arg1[loc3]);
                loc4.validateNow();
                ++loc3;
            }
            updateArrowsState();
            return;
        }

        protected override function createdEmptyRenderers():void
        {
            var loc1:*=0;
            var loc2:*=null;
            var loc3:*=0;
            var loc4:*=NaN;
            var loc5:*=0;
            if (_renderers) 
            {
                loc3 = getEmptySlotsNumForShow();
                loc4 = padding.left + padding.right;
                loc1 = _renderers.length;
                loc5 = loc1;
                while (loc5 < loc1 + loc3) 
                {
                    loc2 = createRenderer(loc5);
                    if (loc2 != null) 
                    {
                    };
                    loc2.x = loc4 + loc5 * (slotImageWidth + loc4);
                    loc2.setListData(new scaleform.clik.data.ListData(loc5));
                    loc2.setData(this.getEmptyRendererData());
                    _renderers.push(loc2);
                    container.addChild(loc2 as flash.display.DisplayObject);
                    loc2.validateNow();
                    ++loc5;
                }
            }
            return;
        }

        protected override function clearEmptyRenderers():void
        {
            var loc1:*=null;
            var loc2:*=0;
            var loc3:*=null;
            var loc4:*=null;
            var loc5:*=0;
            if (_renderers) 
            {
                loc2 = _renderers.length;
                --loc5;
                while (loc5 >= 0) 
                {
                    loc1 = getRendererAt(loc5);
                    if (!(loc1 == null) && net.wg.gui.lobby.hangar.tcarousel.TankCarouselItemRenderer(loc1).empty) 
                    {
                        cleanUpRenderer(loc1);
                        (loc4 = loc1 as net.wg.infrastructure.interfaces.entity.IDisposable).dispose();
                        loc3 = loc1 as flash.display.DisplayObject;
                        if (container.contains(loc3)) 
                        {
                            container.removeChild(loc3);
                        }
                        loc1 = null;
                        loc3 = null;
                        loc4 = null;
                        _renderers.splice(loc5, 1);
                    }
                    --loc5;
                }
            }
            return;
        }

        protected override function getEmptyRendererData():Object
        {
            var loc1:*={"data":-1, "id":"", "inventoryId":-1, "label":"", "image":"", "nation":0, "level":0, "stat":"", "stateLevel":"", "doubleXPReceived":0, "compactDescr":0, "favorite":false, "canSell":false, "clanLock":-1, "elite":false, "premium":false, "tankType":"", "exp":0, "current":0, "enabled":false, "empty":true, "buyTank":false, "buySlot":false, "avalibleSlots":0};
            return loc1;
        }

        public var vehicleFilters:net.wg.gui.lobby.hangar.tcarousel.TankCarouselFilters;

        public var dragHitArea1:flash.display.MovieClip;

        public var leftArrow1:net.wg.gui.components.controls.SoundButton;

        public var rightArrow1:net.wg.gui.components.controls.SoundButton;

        public var renderersMask1:flash.display.MovieClip;

        public var bg1:flash.display.MovieClip;

        internal var filterData:Object;

        internal var nationFilter:net.wg.gui.components.controls.DropDownImageText;

        internal var tankFilter:net.wg.gui.components.controls.DropDownImageText;

        internal var checkBoxToMain:net.wg.gui.components.controls.CheckBox;

        internal var slotPrice:Number=0;

        internal var selectedTankID:String="";

        internal var __availableTanksCount:Number=0;

        internal var __allTanksCount:Number=0;

        internal var __emptySlotsCountForByTank:Number=0;

        internal var firstRun:Boolean=true;

        internal var _rendererHelpLayout:flash.display.DisplayObject;

        internal var _isShowHelpLayout:Boolean=false;

        internal var filterDataInvalid:Boolean=false;
    }
}
