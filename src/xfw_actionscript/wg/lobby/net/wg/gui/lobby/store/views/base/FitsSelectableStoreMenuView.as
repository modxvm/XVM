package net.wg.gui.lobby.store.views.base
{
    import net.wg.gui.components.controls.RadioButton;
    import net.wg.gui.components.controls.DropdownMenu;
    import flash.text.TextField;
    import net.wg.gui.lobby.store.views.data.FiltersVO;
    import scaleform.clik.events.ListEvent;
    import net.wg.gui.lobby.store.views.data.FitItemsFiltersVO;
    import net.wg.data.VO.ShopSubFilterData;
    import net.wg.data.VO.ShopVehicleFilterElementData;
    import scaleform.clik.data.DataProvider;
    import net.wg.data.constants.Linkages;

    public class FitsSelectableStoreMenuView extends BaseStoreMenuView
    {

        private static const MIN_ITEMS_FOR_SCROLL:uint = 13;

        public var myVehicleRadioBtn:RadioButton = null;

        public var fitsSelectDropDn:DropdownMenu = null;

        public var fitsTextField:TextField = null;

        private var _currentVehicle:Number = 0;

        private var _programUpdating:Boolean = false;

        public function FitsSelectableStoreMenuView()
        {
            super();
        }

        override public function resetTemporaryHandlers() : void
        {
            resetHandlers(null,this.myVehicleRadioBtn);
        }

        override public function setFiltersData(param1:FiltersVO, param2:Boolean) : void
        {
            super.setFiltersData(param1,param2);
            this.fitsSelectDropDn.addEventListener(ListEvent.INDEX_CHANGE,this.onFitsSelectDropDnIndexChangeHandler);
            selectFilterSimple(getFitsArray(),FitItemsFiltersVO(param1).fitsType,true);
        }

        override public final function setSubFilterData(param1:int, param2:ShopSubFilterData) : void
        {
            if(param2)
            {
                setFilterData(param2);
                this.setCurrentVehicle(getFilterData().current);
            }
            if(getFilterData().nation != param1 || param2)
            {
                this.updateSubFilter(param1);
            }
        }

        override public function updateSubFilter(param1:int) : void
        {
            var _loc8_:ShopVehicleFilterElementData = null;
            var _loc2_:Number = 0;
            var _loc3_:DataProvider = new DataProvider();
            var _loc4_:DataProvider = getFilterData().dataProvider;
            var _loc5_:int = _loc4_.length;
            var _loc6_:Object = this.getCurrentVehicle();
            var _loc7_:Number = 0;
            while(_loc7_ < _loc5_)
            {
                if(param1 == -1 || _loc4_[_loc7_].nation == param1)
                {
                    _loc8_ = ShopVehicleFilterElementData(_loc4_[_loc7_]);
                    if(_loc6_ == _loc8_.id)
                    {
                        _loc2_ = _loc3_.length;
                    }
                    _loc3_.push({
                        "label":_loc8_.name,
                        "data":_loc8_.id
                    });
                }
                _loc7_++;
            }
            this.fitsSelectDropDn.enabled = false;
            if(this.fitsSelectDropDn.dataProvider != null)
            {
                this.fitsSelectDropDn.dataProvider.cleanUp();
            }
            this.fitsSelectDropDn.dataProvider = _loc3_;
            this.fitsSelectDropDn.menuRowCount = Math.min(_loc3_.length,MIN_ITEMS_FOR_SCROLL);
            this.fitsSelectDropDn.scrollBar = _loc3_.length > MIN_ITEMS_FOR_SCROLL?Linkages.SCROLL_BAR:null;
            this.onVehicleFilterUpdated(_loc3_,_loc2_,param1);
        }

        override protected function onDispose() : void
        {
            this.resetTemporaryHandlers();
            this.fitsSelectDropDn.removeEventListener(ListEvent.INDEX_CHANGE,this.onFitsSelectDropDnIndexChangeHandler);
            this.myVehicleRadioBtn.dispose();
            this.myVehicleRadioBtn = null;
            this.fitsSelectDropDn.dispose();
            this.fitsSelectDropDn = null;
            this.fitsTextField = null;
            super.onDispose();
        }

        protected function onVehicleFilterUpdated(param1:DataProvider, param2:Number, param3:int) : void
        {
            if(param1.length == 0)
            {
                this.myVehicleRadioBtn.enabled = false;
            }
            else
            {
                this.myVehicleRadioBtn.enabled = true;
                this.fitsSelectDropDn.enabled = true;
                this._programUpdating = true;
                this.fitsSelectDropDn.selectedIndex = param2;
                this._programUpdating = false;
            }
        }

        protected function getCurrentVehicle() : Number
        {
            return this._currentVehicle;
        }

        protected function setCurrentVehicle(param1:Number) : void
        {
            this._currentVehicle = param1;
        }

        private function onFitsSelectDropDnIndexChangeHandler(param1:ListEvent) : void
        {
            if(this.fitsSelectDropDn.enabled && getFilterData().current != param1.itemData && !this._programUpdating)
            {
                getFilterData().current = param1.itemData.data;
                if(this.myVehicleRadioBtn.selected)
                {
                    dispatchViewChange();
                }
                else
                {
                    this.myVehicleRadioBtn.selected = true;
                }
            }
        }
    }
}
