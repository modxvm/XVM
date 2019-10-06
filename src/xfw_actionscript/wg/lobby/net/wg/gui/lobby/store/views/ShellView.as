package net.wg.gui.lobby.store.views
{
    import net.wg.gui.lobby.store.views.base.FitsSelectableStoreMenuView;
    import net.wg.gui.components.controls.CheckBox;
    import net.wg.gui.components.controls.RadioButton;
    import flash.text.TextField;
    import net.wg.gui.lobby.store.views.data.FiltersVO;
    import net.wg.gui.lobby.store.views.data.ExtFitItemsFiltersVO;
    import net.wg.gui.lobby.store.views.base.ViewUIElementVO;
    import net.wg.data.constants.generated.STORE_CONSTANTS;
    import scaleform.clik.data.DataProvider;

    public class ShellView extends FitsSelectableStoreMenuView
    {

        private static const KINDS_TAG_NAME:String = "kinds";

        public var armorPiercingChkBox:CheckBox = null;

        public var armorPiercingCRChkBox:CheckBox = null;

        public var hollowChargeChkBox:CheckBox = null;

        public var highExplosiveChkBox:CheckBox = null;

        public var myVehiclesInventoryGunsRadioBtn:RadioButton = null;

        public var myInventoryGunsRadioBtn:RadioButton = null;

        public var otherGunsRadioBtn:RadioButton = null;

        public var kindsTextField:TextField = null;

        public function ShellView()
        {
            super();
        }

        override public function getFiltersData() : FiltersVO
        {
            var _loc1_:ExtFitItemsFiltersVO = new ExtFitItemsFiltersVO(filtersDataHash);
            _loc1_.fitsType = String(myVehicleRadioBtn.group.data);
            _loc1_.vehicleCD = getFilterData().current;
            _loc1_.itemTypes = getSelectedFilters(getTagsArray());
            return _loc1_;
        }

        override public function resetTemporaryHandlers() : void
        {
            super.resetTemporaryHandlers();
            resetHandlers(getTagsArray(),null);
        }

        override public function setFiltersData(param1:FiltersVO, param2:Boolean) : void
        {
            super.setFiltersData(param1,param2);
            var _loc3_:ExtFitItemsFiltersVO = ExtFitItemsFiltersVO(param1);
            setCurrentVehicle(_loc3_.vehicleCD);
            updateSubFilter(getNation());
            selectFilter(getTagsArray(),_loc3_.itemTypes,true,false);
            dispatchViewChange();
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.kindsTextField.text = MENU.SHOP_MENU_SHELL_KINDS_NAME;
            fitsTextField.text = MENU.SHOP_MENU_SHELL_FITS_NAME;
        }

        override protected function onDispose() : void
        {
            this.armorPiercingChkBox.dispose();
            this.armorPiercingChkBox = null;
            this.armorPiercingCRChkBox.dispose();
            this.armorPiercingCRChkBox = null;
            this.hollowChargeChkBox.dispose();
            this.hollowChargeChkBox = null;
            this.highExplosiveChkBox.dispose();
            this.highExplosiveChkBox = null;
            this.myVehiclesInventoryGunsRadioBtn.dispose();
            this.myVehiclesInventoryGunsRadioBtn = null;
            this.myInventoryGunsRadioBtn.dispose();
            this.myInventoryGunsRadioBtn = null;
            this.otherGunsRadioBtn.dispose();
            this.otherGunsRadioBtn = null;
            this.kindsTextField = null;
            super.onDispose();
        }

        override protected function onTagsArrayRequest() : Vector.<ViewUIElementVO>
        {
            return new <ViewUIElementVO>[new ViewUIElementVO(STORE_CONSTANTS.ARMOR_PIERCING_SHELL,this.armorPiercingChkBox),new ViewUIElementVO(STORE_CONSTANTS.ARMOR_PIERCING_CR_SHELL,this.armorPiercingCRChkBox),new ViewUIElementVO(STORE_CONSTANTS.HOLLOW_CHARGE_SHELL,this.hollowChargeChkBox),new ViewUIElementVO(STORE_CONSTANTS.HIGH_EXPLOSIVE_SHELL,this.highExplosiveChkBox)];
        }

        override protected function onFitsArrayRequest() : Vector.<ViewUIElementVO>
        {
            return new <ViewUIElementVO>[new ViewUIElementVO(STORE_CONSTANTS.CURRENT_VEHICLE_SHELL_FIT,myVehicleRadioBtn),new ViewUIElementVO(STORE_CONSTANTS.INVENTORY_VEHICLE_SHELL_FIT,this.myInventoryGunsRadioBtn),new ViewUIElementVO(STORE_CONSTANTS.MY_VEHICLES_SHELL_FIT,this.myVehiclesInventoryGunsRadioBtn),new ViewUIElementVO(STORE_CONSTANTS.OTHER_VEHICLES_SHELL_FIT,this.otherGunsRadioBtn)];
        }

        override protected function getTagsName() : String
        {
            return KINDS_TAG_NAME;
        }

        override protected function onVehicleFilterUpdated(param1:DataProvider, param2:Number, param3:int) : void
        {
            super.onVehicleFilterUpdated(param1,param2,param3);
            if(param1.length == 0)
            {
                this.otherGunsRadioBtn.selected = true;
                this.myInventoryGunsRadioBtn.enabled = false;
                this.myVehiclesInventoryGunsRadioBtn.enabled = false;
            }
            else
            {
                getFilterData().current = param1[param2].data;
                this.myInventoryGunsRadioBtn.enabled = true;
                this.myVehiclesInventoryGunsRadioBtn.enabled = true;
            }
        }
    }
}
