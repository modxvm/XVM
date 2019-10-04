package net.wg.gui.lobby.store.views
{
    import net.wg.gui.lobby.store.views.base.SimpleStoreMenuView;
    import net.wg.gui.components.controls.CheckBox;
    import net.wg.gui.lobby.store.views.base.ViewUIElementVO;
    import net.wg.gui.lobby.store.views.data.FiltersVO;
    import net.wg.utils.IAssertable;
    import net.wg.gui.lobby.store.views.data.ExtFitItemsFiltersVO;
    import net.wg.data.constants.generated.STORE_TYPES;
    import net.wg.data.constants.generated.STORE_CONSTANTS;
    import scaleform.clik.data.DataProvider;

    public class ModuleView extends SimpleStoreMenuView
    {

        private static const TYPES_LOCALE_NAME:String = "types";

        public var vehicleGunChkBx:CheckBox = null;

        public var vehicleTurretChkBx:CheckBox = null;

        public var vehicleEngineChkBx:CheckBox = null;

        public var vehicleChassisChkBx:CheckBox = null;

        public var vehicleRadioChkBx:CheckBox = null;

        public var lockedChkBx:CheckBox = null;

        public var inHangarChkBx:CheckBox = null;

        private var _kindsArr:Vector.<ViewUIElementVO> = null;

        public function ModuleView()
        {
            super();
        }

        override public function getFiltersData() : FiltersVO
        {
            var _loc2_:IAssertable = null;
            if(App.instance)
            {
                _loc2_ = App.utils.asserter;
                _loc2_.assertNotNull(getFilterData(),"filter data in \'" + fittingType + "\' view must be initialized before getting!");
                _loc2_.assert(getFilterData().current != 0,"invalid value in filter data!");
            }
            var _loc1_:ExtFitItemsFiltersVO = new ExtFitItemsFiltersVO(filtersDataHash);
            _loc1_.fitsType = String(myVehicleRadioBtn.group.data);
            _loc1_.vehicleCD = getFilterData().current;
            _loc1_.itemTypes = getSelectedFilters(this.getKindsArray());
            _loc1_.extra = getSelectedFilters(getTagsArray());
            return _loc1_;
        }

        override public function resetTemporaryHandlers() : void
        {
            super.resetTemporaryHandlers();
            resetHandlers(this.getKindsArray(),null);
            resetHandlers(getTagsArray(),null);
        }

        override public function setFiltersData(param1:FiltersVO, param2:Boolean) : void
        {
            var _loc3_:ExtFitItemsFiltersVO = null;
            super.setFiltersData(param1,param2);
            if(App.instance)
            {
                _loc3_ = ExtFitItemsFiltersVO(param1);
                selectFilter(this.getKindsArray(),_loc3_.itemTypes,true,false);
                setCurrentVehicle(_loc3_.vehicleCD);
                updateSubFilter(getNation());
                selectFilter(getTagsArray(),param1.extra,true,false);
                this.dispatchViewChange();
            }
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.inHangarChkBx.enableDynamicFrameUpdating();
            this.lockedChkBx.enableDynamicFrameUpdating();
            vehChBxHeader.text = MENU.SHOP_MENU_MODULE_EXTRA_NAME;
            fitsTextField.text = MENU.SHOP_MENU_MODULE_FITS_NAME;
        }

        override protected function onDispose() : void
        {
            this.vehicleGunChkBx.dispose();
            this.vehicleGunChkBx = null;
            this.vehicleTurretChkBx.dispose();
            this.vehicleTurretChkBx = null;
            this.vehicleEngineChkBx.dispose();
            this.vehicleEngineChkBx = null;
            this.vehicleChassisChkBx.dispose();
            this.vehicleChassisChkBx = null;
            this.vehicleRadioChkBx.dispose();
            this.vehicleRadioChkBx = null;
            this.lockedChkBx.dispose();
            this.lockedChkBx = null;
            this.inHangarChkBx.dispose();
            this.inHangarChkBx = null;
            fitsTextField = null;
            super.onDispose();
            if(this._kindsArr != null)
            {
                disposeUIElementVOs(this._kindsArr);
                this._kindsArr = null;
            }
        }

        override protected function onKindChanged() : void
        {
            initializeControlsByHash(fittingType,this.getKindsArray(),TYPES_LOCALE_NAME);
            super.onKindChanged();
        }

        override protected function onTagsArrayRequest() : Vector.<ViewUIElementVO>
        {
            if(getUIName() == STORE_TYPES.SHOP)
            {
                return new <ViewUIElementVO>[new ViewUIElementVO(STORE_CONSTANTS.LOCKED_EXTRA_NAME,this.lockedChkBx),new ViewUIElementVO(STORE_CONSTANTS.ON_VEHICLE_EXTRA_NAME,onVehicleChkBx),new ViewUIElementVO(STORE_CONSTANTS.IN_HANGAR_EXTRA_NAME,this.inHangarChkBx)];
            }
            return new <ViewUIElementVO>[new ViewUIElementVO(STORE_CONSTANTS.ON_VEHICLE_EXTRA_NAME,onVehicleChkBx)];
        }

        override protected function onVehicleFilterUpdated(param1:DataProvider, param2:Number, param3:int) : void
        {
            super.onVehicleFilterUpdated(param1,param2,param3);
            if(param1.length == 0)
            {
                otherVehiclesRadioBtn.selected = true;
                myVehiclesRadioBtn.enabled = false;
            }
            else
            {
                getFilterData().current = param1[param2].data;
                myVehiclesRadioBtn.enabled = true;
            }
        }

        private function getKindsArray() : Vector.<ViewUIElementVO>
        {
            if(this._kindsArr == null)
            {
                this._kindsArr = new <ViewUIElementVO>[new ViewUIElementVO(STORE_CONSTANTS.GUN_MODULE_NAME,this.vehicleGunChkBx),new ViewUIElementVO(STORE_CONSTANTS.TURRET_MODULE_NAME,this.vehicleTurretChkBx),new ViewUIElementVO(STORE_CONSTANTS.ENGINE_MODULE_NAME,this.vehicleEngineChkBx),new ViewUIElementVO(STORE_CONSTANTS.CHASSIS_MODULE_NAME,this.vehicleChassisChkBx),new ViewUIElementVO(STORE_CONSTANTS.RADIO_MODULE_NAME,this.vehicleRadioChkBx)];
            }
            return this._kindsArr;
        }
    }
}
