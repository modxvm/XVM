package net.wg.gui.lobby.store.views
{
    import net.wg.gui.lobby.store.views.base.BaseStoreMenuView;
    import net.wg.gui.components.controls.SimpleTileList;
    import net.wg.gui.components.controls.CheckBox;
    import flash.text.TextField;
    import net.wg.gui.lobby.store.views.data.FiltersVO;
    import net.wg.gui.lobby.store.views.data.VehiclesFiltersVO;
    import net.wg.data.VO.ShopSubFilterData;
    import net.wg.data.constants.generated.STORE_TYPES;
    import net.wg.data.constants.Linkages;
    import scaleform.clik.constants.DirectionMode;
    import net.wg.gui.components.controls.events.RendererEvent;
    import net.wg.gui.lobby.store.views.base.ViewUIElementVO;
    import net.wg.data.constants.generated.STORE_CONSTANTS;
    import net.wg.infrastructure.interfaces.IImageUrlProperties;
    import scaleform.clik.data.DataProvider;
    import net.wg.gui.components.controls.VO.SimpleRendererVO;

    public class VehicleView extends BaseStoreMenuView
    {

        private static const EXTRA_FITS_NAME:String = "extra";

        private static const CHECKBOX_Y_STEP:Number = 20;

        private static const TOGGLE_TILE_WIDTH:uint = 40;

        private static const TOGGLE_TILE_HEIGHT:uint = 30;

        private static const FILTERS_COUNT_INVALID:String = "filtersCountInvalid";

        private static const IMG_IGR_WIDTH:int = 34;

        private static const IMG_IGR_HEIGHT:int = 16;

        private static const IMG_IGR_VSPACE:int = -4;

        public var listVehicleType:SimpleTileList = null;

        public var listVehicleLevels:SimpleTileList = null;

        public var lockedChkBx:CheckBox = null;

        public var inHangarChkBx:CheckBox = null;

        public var brokenChckBx:CheckBox = null;

        public var rentalsChckBx:CheckBox = null;

        public var premiumIGRChckBx:CheckBox = null;

        public var vehTypeHeader:TextField = null;

        public var vehLevelHeader:TextField = null;

        public var vehicleFilterExtraName:TextField = null;

        private var _isPremIGREnabled:Boolean = false;

        private var _isRentalsEnabled:Boolean = false;

        public function VehicleView()
        {
            super();
        }

        override public function getFiltersData() : FiltersVO
        {
            var _loc1_:VehiclesFiltersVO = this.createFiltersDataVO();
            this.setListsSelectedStats(_loc1_);
            _loc1_.extra = getSelectedFilters(getFitsArray());
            return _loc1_;
        }

        override public function resetTemporaryHandlers() : void
        {
            resetHandlers(getFitsArray(),null);
        }

        override public function setFiltersData(param1:FiltersVO, param2:Boolean) : void
        {
            super.setFiltersData(param1,param2);
            var _loc3_:VehiclesFiltersVO = VehiclesFiltersVO(param1);
            this.updateList(this.listVehicleType,_loc3_.vehicleTypes);
            this.updateList(this.listVehicleLevels,_loc3_.levels);
            if(param1.extra != null)
            {
                selectFilter(getFitsArray(),param1.extra,true,false);
            }
            else
            {
                this.setSelectedFilters(getFitsArray(),false);
            }
            this.setExtraVisible(param2);
        }

        override public function setSubFilterData(param1:int, param2:ShopSubFilterData) : void
        {
        }

        override public function setUIName(param1:String, param2:Function) : void
        {
            super.setUIName(param1,param2);
            this.isPremIGREnabled = App.globalVarsMgr.isKoreaS() && getUIName() == STORE_TYPES.INVENTORY;
            invalidate(FILTERS_COUNT_INVALID);
        }

        override public function updateSubFilter(param1:int) : void
        {
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.listVehicleType.itemRenderer = this.listVehicleLevels.itemRenderer = App.utils.classFactory.getClass(Linkages.TOGGLE_RENDERER_UI);
            this.listVehicleType.tileWidth = this.listVehicleLevels.tileWidth = TOGGLE_TILE_WIDTH;
            this.listVehicleLevels.tileHeight = TOGGLE_TILE_HEIGHT;
            this.listVehicleType.directionMode = this.listVehicleLevels.directionMode = DirectionMode.HORIZONTAL;
            this.listVehicleType.addEventListener(RendererEvent.ITEM_CLICK,this.onVehicleTypeItemClickHandler);
            this.listVehicleLevels.addEventListener(RendererEvent.ITEM_CLICK,this.onVehicleTypeItemClickHandler);
            this.inHangarChkBx.enableDynamicFrameUpdating();
            this.brokenChckBx.enableDynamicFrameUpdating();
            this._isRentalsEnabled = App.globalVarsMgr.isRentalsEnabledS();
            this.rentalsChckBx.visible = this._isRentalsEnabled;
            if(this._isRentalsEnabled)
            {
                this.rentalsChckBx.enableDynamicFrameUpdating();
            }
            this.isPremIGREnabled = App.globalVarsMgr.isKoreaS() && getUIName() == STORE_TYPES.INVENTORY;
            this.vehicleFilterExtraName.text = MENU.SHOP_MENU_VEHICLE_EXTRA_NAME;
            this.vehTypeHeader.text = MENU.SHOP_MENU_VEHICLE_TYPE_HEADER;
            this.vehLevelHeader.text = MENU.SHOP_MENU_VEHICLE_LEVELS_HEADER;
        }

        override protected function onDispose() : void
        {
            this.listVehicleType.removeEventListener(RendererEvent.ITEM_CLICK,this.onVehicleTypeItemClickHandler);
            this.listVehicleType.dispose();
            this.listVehicleType = null;
            this.listVehicleLevels.removeEventListener(RendererEvent.ITEM_CLICK,this.onVehicleTypeItemClickHandler);
            this.listVehicleLevels.dispose();
            this.listVehicleLevels = null;
            this.lockedChkBx.dispose();
            this.lockedChkBx = null;
            this.inHangarChkBx.dispose();
            this.inHangarChkBx = null;
            this.brokenChckBx.dispose();
            this.brokenChckBx = null;
            this.rentalsChckBx.dispose();
            this.rentalsChckBx = null;
            this.premiumIGRChckBx.dispose();
            this.premiumIGRChckBx = null;
            this.vehicleFilterExtraName = null;
            this.vehTypeHeader = null;
            this.vehLevelHeader = null;
            super.onDispose();
        }

        override protected function draw() : void
        {
            var _loc1_:Vector.<ViewUIElementVO> = null;
            var _loc2_:* = NaN;
            var _loc3_:* = 0;
            var _loc4_:* = NaN;
            var _loc5_:ViewUIElementVO = null;
            super.draw();
            if(isInvalid(FILTERS_COUNT_INVALID))
            {
                _loc1_ = getFitsArray();
                _loc2_ = this.vehicleFilterExtraName.y;
                _loc3_ = _loc1_.length;
                _loc4_ = 1;
                while(_loc4_ <= _loc3_)
                {
                    _loc5_ = _loc1_[_loc4_ - 1];
                    _loc5_.instance.y = _loc2_ + CHECKBOX_Y_STEP * _loc4_;
                    _loc4_++;
                }
            }
        }

        override protected function onFitsArrayRequest() : Vector.<ViewUIElementVO>
        {
            var _loc1_:Vector.<ViewUIElementVO> = null;
            if(getUIName() == STORE_TYPES.SHOP)
            {
                _loc1_ = new <ViewUIElementVO>[new ViewUIElementVO(STORE_CONSTANTS.LOCKED_EXTRA_NAME,this.lockedChkBx),new ViewUIElementVO(STORE_CONSTANTS.IN_HANGAR_EXTRA_NAME,this.inHangarChkBx)];
                if(App.globalVarsMgr.isRentalsEnabledS())
                {
                    _loc1_.push(new ViewUIElementVO(STORE_CONSTANTS.RENTALS_EXTRA_NAME,this.rentalsChckBx));
                }
            }
            else
            {
                _loc1_ = new <ViewUIElementVO>[new ViewUIElementVO(STORE_CONSTANTS.LOCKED_EXTRA_NAME,this.lockedChkBx),new ViewUIElementVO(STORE_CONSTANTS.BROCKEN_EXTRA_NAME,this.brokenChckBx)];
                if(App.globalVarsMgr.isRentalsEnabledS())
                {
                    _loc1_.push(new ViewUIElementVO(STORE_CONSTANTS.RENTALS_EXTRA_NAME,this.rentalsChckBx));
                }
                if(this.isPremIGREnabled)
                {
                    _loc1_.push(new ViewUIElementVO(STORE_CONSTANTS.PREMIUM_IGR_EXTRA_NAME,this.premiumIGRChckBx,App.utils.getHtmlIconTextS(IImageUrlProperties(App.utils.getImageUrlProperties(RES_ICONS.MAPS_ICONS_LIBRARY_PREMIUM_SMALL,IMG_IGR_WIDTH,IMG_IGR_HEIGHT,IMG_IGR_VSPACE)))));
                }
            }
            return _loc1_;
        }

        override protected function getFitsName() : String
        {
            return EXTRA_FITS_NAME;
        }

        protected function setListsSelectedStats(param1:VehiclesFiltersVO) : void
        {
            var _loc3_:* = 0;
            var _loc2_:int = this.listVehicleType.length;
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
                param1.selectedTypes[_loc3_] = this.listVehicleType.getRendererAt(_loc3_).selectable;
                _loc3_++;
            }
            _loc2_ = this.listVehicleLevels.length;
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
                param1.selectedLevels[_loc3_] = this.listVehicleLevels.getRendererAt(_loc3_).selectable;
                _loc3_++;
            }
        }

        protected final function setSelectedFilters(param1:Vector.<ViewUIElementVO>, param2:Boolean) : void
        {
            var _loc3_:ViewUIElementVO = null;
            for each(_loc3_ in param1)
            {
                _loc3_.instance.selected = param2;
            }
        }

        protected function createFiltersDataVO() : VehiclesFiltersVO
        {
            return new VehiclesFiltersVO(filtersDataHash);
        }

        protected function setExtraVisible(param1:Boolean) : void
        {
            this.vehicleFilterExtraName.visible = param1;
            this.lockedChkBx.visible = param1;
            this.brokenChckBx.visible = param1 && this.isBrokenChkBxEnabled;
            this.inHangarChkBx.visible = param1 && this.isHangarChkBxEnabled;
            this.rentalsChckBx.visible = this._isRentalsEnabled && param1;
            this.premiumIGRChckBx.visible = this._isPremIGREnabled && param1;
        }

        private function updateList(param1:SimpleTileList, param2:DataProvider) : void
        {
            if(param1.dataProvider == null)
            {
                param1.dataProvider = param2;
                param1.validateNow();
            }
            var _loc3_:int = param2.length;
            var _loc4_:SimpleRendererVO = null;
            var _loc5_:* = 0;
            while(_loc5_ < _loc3_)
            {
                _loc4_ = SimpleRendererVO(param2[_loc5_]);
                param1.getRendererAt(_loc5_).selectable = _loc4_.selected;
                _loc5_++;
            }
        }

        public function get isPremIGREnabled() : Boolean
        {
            return this._isPremIGREnabled;
        }

        public function set isPremIGREnabled(param1:Boolean) : void
        {
            this._isPremIGREnabled = param1;
            if(this._isPremIGREnabled)
            {
                this.premiumIGRChckBx.enableDynamicFrameUpdating();
            }
            this.premiumIGRChckBx.visible = this._isPremIGREnabled;
        }

        protected function get isBrokenChkBxEnabled() : Boolean
        {
            return false;
        }

        protected function get isHangarChkBxEnabled() : Boolean
        {
            return false;
        }

        private function onVehicleTypeItemClickHandler(param1:RendererEvent) : void
        {
            dispatchViewChange();
        }
    }
}
