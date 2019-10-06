package net.wg.gui.lobby.store.views.base
{
    import net.wg.gui.components.controls.RadioButton;
    import net.wg.gui.components.controls.CheckBox;
    import flash.text.TextField;
    import net.wg.gui.lobby.store.views.data.FiltersVO;
    import net.wg.gui.lobby.store.views.data.FitItemsFiltersVO;
    import net.wg.data.constants.generated.STORE_CONSTANTS;

    public class SimpleStoreMenuView extends FitsSelectableStoreMenuView
    {

        private static const EXTRA_FITS_NAME:String = "extra";

        public var myVehiclesRadioBtn:RadioButton = null;

        public var otherVehiclesRadioBtn:RadioButton = null;

        public var onVehicleChkBx:CheckBox = null;

        public var vehChBxHeader:TextField = null;

        public function SimpleStoreMenuView()
        {
            super();
        }

        override public function getFiltersData() : FiltersVO
        {
            var _loc1_:FitItemsFiltersVO = null;
            _loc1_ = new FitItemsFiltersVO(filtersDataHash);
            _loc1_.fitsType = String(myVehicleRadioBtn.group.data);
            _loc1_.vehicleCD = getFilterData().current;
            _loc1_.extra = getSelectedFilters(getTagsArray());
            return _loc1_;
        }

        override protected function onDispose() : void
        {
            this.myVehiclesRadioBtn.dispose();
            this.myVehiclesRadioBtn = null;
            this.otherVehiclesRadioBtn.dispose();
            this.otherVehiclesRadioBtn = null;
            this.onVehicleChkBx.dispose();
            this.onVehicleChkBx = null;
            this.vehChBxHeader = null;
            super.onDispose();
        }

        override protected function onTagsArrayRequest() : Vector.<ViewUIElementVO>
        {
            return new <ViewUIElementVO>[new ViewUIElementVO(STORE_CONSTANTS.ON_VEHICLE_EXTRA_NAME,this.onVehicleChkBx)];
        }

        override protected function onFitsArrayRequest() : Vector.<ViewUIElementVO>
        {
            return new <ViewUIElementVO>[new ViewUIElementVO(STORE_CONSTANTS.CURRENT_VEHICLE_ARTEFACT_FIT,myVehicleRadioBtn),new ViewUIElementVO(STORE_CONSTANTS.MY_VEHICLES_ARTEFACT_FIT,this.myVehiclesRadioBtn),new ViewUIElementVO(STORE_CONSTANTS.OTHER_VEHICLES_ARTEFACT_FIT,this.otherVehiclesRadioBtn)];
        }

        override protected function getTagsName() : String
        {
            return EXTRA_FITS_NAME;
        }
    }
}
