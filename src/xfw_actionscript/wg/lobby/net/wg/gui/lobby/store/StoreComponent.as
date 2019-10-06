package net.wg.gui.lobby.store
{
    import net.wg.infrastructure.base.meta.impl.StoreComponentMeta;
    import net.wg.infrastructure.base.meta.IStoreComponentMeta;
    import flash.text.TextField;
    import net.wg.gui.lobby.store.views.ActionsFilterView;
    import flash.utils.Dictionary;
    import net.wg.gui.lobby.store.views.base.interfaces.IStoreMenuView;
    import net.wg.data.VO.ShopSubFilterData;
    import net.wg.gui.lobby.store.interfaces.IStoreTable;
    import scaleform.clik.utils.Constraints;
    import scaleform.clik.constants.ConstrainMode;
    import net.wg.data.Aliases;
    import net.wg.data.components.StoreMenuViewData;
    import scaleform.clik.events.ListEvent;
    import scaleform.clik.events.IndexEvent;
    import net.wg.gui.events.ViewStackEvent;
    import flash.events.Event;
    import net.wg.data.VO.ShopNationFilterDataVo;
    import net.wg.data.constants.generated.FITTING_TYPES;
    import net.wg.gui.lobby.store.data.FiltersDataVO;
    import net.wg.data.constants.Errors;
    import net.wg.infrastructure.exceptions.NullPointerException;
    import net.wg.infrastructure.exceptions.AbstractException;
    import net.wg.gui.lobby.store.views.data.FiltersVO;
    import net.wg.data.constants.generated.STORE_CONSTANTS;
    import net.wg.gui.components.advanced.Accordion;
    import scaleform.clik.data.DataProvider;

    public class StoreComponent extends StoreComponentMeta implements IStoreComponentMeta
    {

        private static const FITTING_TYPE_VIEW_POSTFIX:String = "ViewUI";

        private static const CURRENT_VIEW:String = "currentView";

        private static const NAME_LABEL_SUFFIX:String = "/name";

        private static const GET_LOCALIZATOR:String = "getLocalizator";

        private static const FITTING_TYPE:String = "fittingType";

        private static const LOCALE_ENUM_PROCESSOR:String = "localeEnumProcessor";

        private static const MODULE_ITEM_RENDERER_LINKAGE:String = "moduleItemRendererLinkage";

        private static const VEHICLE_ITEM_RENDERER_LINKAGE:String = "vehicleItemRendererLinkage";

        private static const MENU_CHANGED_INV:String = "menuChangedInv";

        public var form:StoreForm = null;

        public var header:TextField = null;

        public var actionsFilterView:ActionsFilterView = null;

        private var _viewsHash:Dictionary = null;

        private var _currentView:IStoreMenuView = null;

        private var _programUpdating:Boolean = false;

        private var _subFilterData:ShopSubFilterData = null;

        private var _storeTable:IStoreTable;

        private var _initializing:Boolean = true;

        private var _tableIsInvalid:Boolean = true;

        public function StoreComponent()
        {
            super();
            this._viewsHash = new Dictionary(false);
            this._storeTable = this.form.storeTable;
        }

        override public function setViewSize(param1:Number, param2:Number) : void
        {
            super.setViewSize(param1,param2);
            this.form.x = _width - this.form.width >> 1;
            this.header.x = _width - this.header.width >> 1;
            this.actionsFilterView.x = this.form.x + this.form.width - this.actionsFilterView.width;
            this._storeTable.height = height - this.form.y - this._storeTable.y;
        }

        override protected final function preInitialize() : void
        {
            super.preInitialize();
            constraints = new Constraints(this,ConstrainMode.REFLOW);
        }

        override protected function onPopulate() : void
        {
            super.onPopulate();
            this.storeTable.setModuleRendererLinkage(this.moduleItemRendererLinkage);
            this.storeTable.setVehicleRendererLinkage(this.vehicleItemRendererLinkage);
            registerFlashComponentS(this.storeTable,Aliases.SHOP_TABLE);
            this.storeTable.addEventListener(StoreEvent.INFO,this.onStoreTableInfoHandler);
            this.storeTable.addEventListener(StoreEvent.ADD_TO_COMPARE,this.onStoreTableAddToCompareHandler);
        }

        override protected function onDispose() : void
        {
            var _loc1_:StoreMenuViewData = null;
            this.storeTable.removeEventListener(StoreEvent.INFO,this.onStoreTableInfoHandler);
            this.storeTable.removeEventListener(StoreEvent.ADD_TO_COMPARE,this.onStoreTableAddToCompareHandler);
            this._storeTable = null;
            this.setCurrentView(null);
            this._subFilterData = null;
            this.form.nationDropDown.removeEventListener(ListEvent.INDEX_CHANGE,this.onNationDropDownIndexChangeHandler);
            this.form.menu.removeEventListener(IndexEvent.INDEX_CHANGE,this.onMenuIndexChangeHandler);
            this.form.menu.view.removeEventListener(ViewStackEvent.NEED_UPDATE,this.onViewNeedUpdateHandler);
            this.form.dispose();
            this.form = null;
            this.actionsFilterView.removeEventListener(Event.SELECT,this.onActionsFilterViewSelectHandler);
            this.actionsFilterView.dispose();
            this.actionsFilterView = null;
            for each(_loc1_ in this._viewsHash)
            {
                _loc1_.dispose();
                delete this._viewsHash[_loc1_];
            }
            this._viewsHash = null;
            this._currentView = null;
            this.header = null;
            super.onDispose();
        }

        override protected function setFilterType(param1:ShopNationFilterDataVo) : void
        {
            var _loc3_:IStoreMenuView = null;
            this.form.setNationIdx(param1.language);
            var _loc2_:Number = FITTING_TYPES.STORE_SLOTS.indexOf(param1.tabType);
            if(_loc2_ != -1)
            {
                this.form.menu.selectedIndex = _loc2_;
                this.updateHeader(_loc2_);
                this.form.menu.validateNow();
                if(this.initializing)
                {
                    _loc3_ = IStoreMenuView(this.form.menu.view.currentView);
                    this.onViewNeedUpdate(_loc3_,this.getLinkageFromFittingType(param1.fittingType),param1.fittingType);
                }
            }
            this.actionsFilterView.selected = param1.actionsSelected;
        }

        override protected function setFilterOptions(param1:FiltersDataVO) : void
        {
            App.utils.asserter.assertNotNull(this.getCurrentView(),CURRENT_VIEW + Errors.CANT_NULL,NullPointerException);
            this.getCurrentView().setFiltersData(param1.filtersData,param1.showExtra);
        }

        override protected function setSubFilter(param1:ShopSubFilterData) : void
        {
            this._subFilterData = param1;
            App.utils.asserter.assertNotNull(this.getCurrentView(),CURRENT_VIEW + Errors.CANT_NULL,NullPointerException);
            this.getCurrentView().setSubFilterData(this.form.nationIdx,this._subFilterData);
        }

        override protected function initFiltersData(param1:Array, param2:String) : void
        {
            App.utils.asserter.assert(param1.length > 0,Errors.CANT_EMPTY);
            this.form.nationDropDown.menuRowCount = param1.length;
            this.form.nationDropDown.createNationFilter(param1);
            this.actionsFilterView.text = param2;
            if(this.initializing)
            {
                this.initMenu(this.createFilterLabel);
            }
        }

        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(MENU_CHANGED_INV) && !this.initializing)
            {
                this.updateTable();
            }
        }

        public function as_completeInit() : void
        {
            this.form.menu.view.addEventListener(ViewStackEvent.NEED_UPDATE,this.onViewNeedUpdateHandler);
            this.form.menu.addEventListener(IndexEvent.INDEX_CHANGE,this.onMenuIndexChangeHandler);
            this.form.nationDropDown.addEventListener(ListEvent.INDEX_CHANGE,this.onNationDropDownIndexChangeHandler);
            this.actionsFilterView.addEventListener(Event.SELECT,this.onActionsFilterViewSelectHandler);
            this._initializing = false;
        }

        public function as_scrollPosition(param1:int) : void
        {
            this.storeTable.scrollPosition = param1;
        }

        public function as_setActionAvailable(param1:Boolean) : void
        {
            this.storeTable.updateActionAvailable(param1);
        }

        public function as_setVehicleCompareAvailable(param1:Boolean) : void
        {
            this.storeTable.updateVehicleCompareAvailable(param1);
        }

        public function as_update() : void
        {
            this.updateTable();
        }

        protected function getLocalizator() : Function
        {
            throw new AbstractException(GET_LOCALIZATOR + Errors.ABSTRACT_INVOKE);
        }

        protected final function updateTable() : void
        {
            var _loc1_:FiltersVO = null;
            var _loc2_:String = null;
            var _loc3_:Object = null;
            var _loc4_:* = false;
            if(this._tableIsInvalid)
            {
                if(this._currentView != null)
                {
                    this._currentView.updateSubFilter(this.form.nationIdx);
                    this._tableIsInvalid = false;
                }
            }
            if(this.form.menu.enabled && this._currentView && !this._programUpdating)
            {
                _loc1_ = this._currentView.getFiltersData();
                _loc2_ = this._currentView.fittingType;
                App.utils.asserter.assertNotNull(_loc2_,FITTING_TYPE);
                _loc3_ = _loc1_.toHash();
                requestTableDataS(this.form.nationIdx,this.actionsFilterView.selected,_loc2_,_loc3_);
                _loc1_.dispose();
                _loc4_ = _loc2_ == STORE_CONSTANTS.TRADE_IN_VEHICLE;
                this.storeTable.updateTradeInAvailable(_loc4_);
            }
        }

        protected function getLinkageFromFittingType(param1:String) : String
        {
            App.utils.asserter.assertNotNull(param1,FITTING_TYPE,NullPointerException);
            return param1 + FITTING_TYPE_VIEW_POSTFIX;
        }

        protected function getViewData(param1:String) : StoreMenuViewData
        {
            App.utils.asserter.assert(this._viewsHash.hasOwnProperty(param1),Errors.BAD_LINKAGE + param1);
            return this._viewsHash[param1];
        }

        protected function onViewNeedUpdate(param1:IStoreMenuView, param2:String, param3:String) : void
        {
            this.setCurrentView(param1);
            if(!this.initializing)
            {
                param1.setSubFilterData(this.form.nationIdx,this._subFilterData);
            }
            var _loc4_:StoreMenuViewData = this.getViewData(param2);
            if(param3 != null)
            {
                _loc4_.fittingType = param3;
            }
            param1.update(_loc4_);
            this.storeTable.updateHeaderCountTitle(MENU.shop_table_header_count(param1.fittingType));
        }

        protected function getCurrentView() : IStoreMenuView
        {
            return this._currentView;
        }

        protected function setCurrentView(param1:IStoreMenuView) : void
        {
            if(this._currentView != param1)
            {
                if(this._currentView)
                {
                    this._currentView.removeEventListener(StoreViewsEvent.POPULATE_MENU_FILTER,this.onCurrentViewPopulateMenuFilterHandler);
                    this._currentView.removeEventListener(StoreViewsEvent.VIEW_CHANGE,this.onCurrentViewViewChangeHandler);
                    this._currentView.resetTemporaryHandlers();
                }
                this._currentView = param1;
                if(this._currentView != null)
                {
                    this._currentView.setUIName(getNameS(),this.createFilterLabel);
                    this._currentView.addEventListener(StoreViewsEvent.POPULATE_MENU_FILTER,this.onCurrentViewPopulateMenuFilterHandler);
                    this._currentView.addEventListener(StoreViewsEvent.VIEW_CHANGE,this.onCurrentViewViewChangeHandler);
                }
            }
        }

        protected function onPopulateMenuFilterNeed(param1:String) : void
        {
            if(!this.initializing)
            {
                requestFilterDataS(param1);
            }
        }

        protected function initMenu(param1:Function) : void
        {
            var _loc3_:StoreMenuViewData = null;
            var _loc4_:String = null;
            var _loc5_:String = null;
            var _loc6_:Accordion = null;
            App.utils.asserter.assertNotNull(param1,LOCALE_ENUM_PROCESSOR + Errors.CANT_NULL,NullPointerException);
            var _loc2_:DataProvider = new DataProvider();
            for each(_loc5_ in FITTING_TYPES.STORE_SLOTS)
            {
                _loc4_ = this.getLinkageFromFittingType(_loc5_);
                _loc3_ = new StoreMenuViewData({
                    "label":param1(_loc5_ + NAME_LABEL_SUFFIX),
                    "linkage":_loc4_,
                    "fittingType":_loc5_,
                    "enabled":true
                });
                this._viewsHash[_loc4_] = _loc3_;
                _loc2_.push(_loc3_);
            }
            _loc6_ = this.form.menu;
            if(_loc6_.dataProvider != null)
            {
                _loc6_.dataProvider.cleanUp();
            }
            _loc6_.dataProvider = _loc2_;
        }

        private function createFilterLabel(param1:String, param2:String = null) : String
        {
            var _loc3_:String = this.getLocalizator()(param1);
            if(param2)
            {
                return App.utils.locale.makeString(_loc3_,{"icon":param2});
            }
            return _loc3_;
        }

        private function updateHeader(param1:int) : void
        {
            this.header.text = MENU.shop_menu(FITTING_TYPES.STORE_SLOTS[param1] + NAME_LABEL_SUFFIX);
        }

        override public function set visible(param1:Boolean) : void
        {
            super.visible = param1;
            this.form.isViewVisible = param1;
        }

        public function get storeTable() : IStoreTable
        {
            return this._storeTable;
        }

        protected function get moduleItemRendererLinkage() : String
        {
            throw new AbstractException(MODULE_ITEM_RENDERER_LINKAGE + Errors.ABSTRACT_INVOKE);
        }

        protected function get vehicleItemRendererLinkage() : String
        {
            throw new AbstractException(VEHICLE_ITEM_RENDERER_LINKAGE + Errors.ABSTRACT_INVOKE);
        }

        protected function get initializing() : Boolean
        {
            return this._initializing;
        }

        private function onActionsFilterViewSelectHandler(param1:Event) : void
        {
            invalidate(MENU_CHANGED_INV);
        }

        private function onViewNeedUpdateHandler(param1:ViewStackEvent) : void
        {
            this._programUpdating = true;
            this.onViewNeedUpdate(IStoreMenuView(param1.view),param1.viewId,null);
            this._programUpdating = false;
        }

        private function onNationDropDownIndexChangeHandler(param1:ListEvent) : void
        {
            this._tableIsInvalid = true;
            invalidate(MENU_CHANGED_INV);
        }

        private function onCurrentViewViewChangeHandler(param1:Event) : void
        {
            invalidate(MENU_CHANGED_INV);
        }

        private function onMenuIndexChangeHandler(param1:IndexEvent) : void
        {
            var _loc2_:IStoreMenuView = null;
            if(!this.initializing)
            {
                _loc2_ = this.getCurrentView();
                App.utils.asserter.assertNotNull(_loc2_,CURRENT_VIEW + Errors.CANT_NULL);
                _loc2_.setSubFilterData(this.form.nationIdx,this._subFilterData);
                this.updateHeader(param1.index);
            }
            invalidate(MENU_CHANGED_INV);
        }

        private function onCurrentViewPopulateMenuFilterHandler(param1:StoreViewsEvent) : void
        {
            this.onPopulateMenuFilterNeed(param1.viewType);
        }

        private function onStoreTableInfoHandler(param1:StoreEvent) : void
        {
            onShowInfoS(param1.itemCD);
        }

        private function onStoreTableAddToCompareHandler(param1:StoreEvent) : void
        {
            onAddVehToCompareS(param1.itemCD);
        }
    }
}
