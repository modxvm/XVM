package net.wg.gui.lobby.store.views
{
    import net.wg.gui.components.controls.RadioButton;
    import net.wg.gui.lobby.store.views.base.ViewUIElementVO;
    import net.wg.gui.lobby.store.views.data.FiltersVO;
    import net.wg.gui.lobby.store.views.data.ShopVehiclesFiltersVO;
    import net.wg.data.constants.generated.STORE_CONSTANTS;
    import flash.events.Event;
    import net.wg.gui.lobby.store.StoreViewsEvent;
    import net.wg.gui.lobby.store.views.data.VehiclesFiltersVO;
    import scaleform.clik.controls.ButtonGroup;

    public class ShopVehicleView extends VehicleView
    {

        private static const OBTAINING_NAME:String = "obtainingType";

        private static const ONE_ELEMENT_Y_SHIFT:uint = 20;

        private static const ALL_BLOCK_Y_SHIFT:uint = 68;

        public var obtainingTypeBuyBtn:RadioButton;

        public var obtainingTypeRestoreBtn:RadioButton;

        public var obtainingTypeTradeInBtn:RadioButton;

        private var _obtainingTypeArr:Vector.<ViewUIElementVO> = null;

        private var _isTradeInEnabled:Boolean = false;

        private var _isVehicleRestoreEnabled:Boolean = false;

        public function ShopVehicleView()
        {
            super();
        }

        override public function getFiltersData() : FiltersVO
        {
            var _loc1_:ShopVehiclesFiltersVO = ShopVehiclesFiltersVO(this.createFiltersDataVO());
            var _loc2_:String = this.fittingType;
            setListsSelectedStats(_loc1_);
            if(_loc2_ == STORE_CONSTANTS.VEHICLE)
            {
                _loc1_.extra = getSelectedFilters(getFitsArray());
            }
            _loc1_.obtainingType = this.getSelectedObtainingType();
            return _loc1_;
        }

        override public function resetTemporaryHandlers() : void
        {
            resetHandlers(this.getObtainingTypeArray(),this.obtainingTypeBuyBtn);
            super.resetTemporaryHandlers();
        }

        override public function setFiltersData(param1:FiltersVO, param2:Boolean) : void
        {
            super.setFiltersData(param1,param2);
            var _loc3_:ShopVehiclesFiltersVO = ShopVehiclesFiltersVO(param1);
            this.obtainingTypeBuyBtn.group.removeEventListener(Event.CHANGE,this.onObtainingTypeChangeHandler);
            selectFilterSimple(this.getObtainingTypeArray(),_loc3_.obtainingType,false);
            this.obtainingTypeBuyBtn.group.addEventListener(Event.CHANGE,this.onObtainingTypeChangeHandler);
            this.onObtainingTypeChangeHandler();
        }

        override protected function onKindChanged() : void
        {
            initializeControlsByHash(STORE_CONSTANTS.VEHICLE,this.getObtainingTypeArray(),OBTAINING_NAME);
            initializeControlsByHash(STORE_CONSTANTS.VEHICLE,getFitsArray(),getFitsName());
            dispatchEvent(getStoreViewEvent(StoreViewsEvent.POPULATE_MENU_FILTER));
        }

        override protected function onDispose() : void
        {
            this.obtainingTypeBuyBtn.group.removeEventListener(Event.CHANGE,this.onObtainingTypeChangeHandler);
            this.obtainingTypeBuyBtn.dispose();
            this.obtainingTypeBuyBtn = null;
            this.obtainingTypeRestoreBtn.dispose();
            this.obtainingTypeRestoreBtn = null;
            this.obtainingTypeTradeInBtn.dispose();
            this.obtainingTypeTradeInBtn = null;
            if(this._obtainingTypeArr != null)
            {
                disposeUIElementVOs(this._obtainingTypeArr);
                this._obtainingTypeArr = null;
            }
            super.onDispose();
        }

        override protected function configUI() : void
        {
            super.configUI();
            this._isVehicleRestoreEnabled = App.globalVarsMgr.isVehicleRestoreEnabledS();
            this._isTradeInEnabled = App.globalVarsMgr.isTradeInEnabledS();
            this.updateObtainingTypeState();
        }

        override protected function createFiltersDataVO() : VehiclesFiltersVO
        {
            return new ShopVehiclesFiltersVO(filtersDataHash);
        }

        protected final function getObtainingTypeArray() : Vector.<ViewUIElementVO>
        {
            if(this._obtainingTypeArr == null)
            {
                this._obtainingTypeArr = new <ViewUIElementVO>[new ViewUIElementVO(STORE_CONSTANTS.VEHICLE,this.obtainingTypeBuyBtn),new ViewUIElementVO(STORE_CONSTANTS.RESTORE_VEHICLE,this.obtainingTypeRestoreBtn),new ViewUIElementVO(STORE_CONSTANTS.TRADE_IN_VEHICLE,this.obtainingTypeTradeInBtn)];
            }
            return this._obtainingTypeArr;
        }

        private function updateObtainingTypeState() : void
        {
            var _loc1_:* = false;
            _loc1_ = this._isTradeInEnabled || this._isVehicleRestoreEnabled;
            this.obtainingTypeRestoreBtn.visible = this._isVehicleRestoreEnabled;
            this.obtainingTypeTradeInBtn.visible = this._isTradeInEnabled;
            var _loc2_:uint = 0;
            if(_loc1_)
            {
                _loc2_ = this._isVehicleRestoreEnabled?0:ONE_ELEMENT_Y_SHIFT;
                _loc2_ = _loc2_ + (this._isTradeInEnabled?0:ONE_ELEMENT_Y_SHIFT);
                this.obtainingTypeTradeInBtn.y = this.obtainingTypeTradeInBtn.y - _loc2_;
            }
            else
            {
                _loc2_ = ALL_BLOCK_Y_SHIFT;
                this.obtainingTypeBuyBtn.visible = false;
                this.obtainingTypeRestoreBtn.visible = false;
                this.obtainingTypeTradeInBtn.visible = false;
            }
            listVehicleType.y = listVehicleType.y - _loc2_;
            listVehicleLevels.y = listVehicleLevels.y - _loc2_;
            lockedChkBx.y = lockedChkBx.y - _loc2_;
            inHangarChkBx.y = inHangarChkBx.y - _loc2_;
            vehTypeHeader.y = vehTypeHeader.y - _loc2_;
            vehLevelHeader.y = vehLevelHeader.y - _loc2_;
            vehicleFilterExtraName.y = vehicleFilterExtraName.y - _loc2_;
        }

        private function setVehicleTypesVisible(param1:Boolean) : void
        {
            vehTypeHeader.visible = param1;
            listVehicleType.visible = param1;
            vehLevelHeader.visible = param1;
            listVehicleLevels.visible = param1;
        }

        private function getSelectedObtainingType() : String
        {
            var _loc1_:ButtonGroup = this.obtainingTypeBuyBtn.group;
            return String(_loc1_.selectedButton != null?_loc1_.data:this.obtainingTypeBuyBtn.data);
        }

        private function updateBloksVisibility() : void
        {
            var _loc1_:String = this.fittingType;
            this.setVehicleTypesVisible(_loc1_ != STORE_CONSTANTS.TRADE_IN_VEHICLE);
            setExtraVisible(_loc1_ == STORE_CONSTANTS.VEHICLE);
        }

        override public function get fittingType() : String
        {
            return this.getSelectedObtainingType();
        }

        override protected function get isHangarChkBxEnabled() : Boolean
        {
            return true;
        }

        private function onObtainingTypeChangeHandler(param1:Event = null) : void
        {
            dispatchEvent(getStoreViewEvent(StoreViewsEvent.VIEW_CHANGE));
            this.updateBloksVisibility();
        }
    }
}
