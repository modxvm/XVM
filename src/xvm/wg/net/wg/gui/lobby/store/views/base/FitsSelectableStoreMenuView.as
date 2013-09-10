package net.wg.gui.lobby.store.views.base 
{
    import net.wg.data.VO.*;
    import net.wg.data.constants.*;
    import net.wg.gui.components.controls.*;
    import scaleform.clik.data.*;
    import scaleform.clik.events.*;
    
    public class FitsSelectableStoreMenuView extends net.wg.gui.lobby.store.views.base.BaseStoreMenuView
    {
        public function FitsSelectableStoreMenuView()
        {
            super();
            return;
        }

        public override function dispose():void
        {
            super.dispose();
            resetTemporaryHandlers();
            this.fitsSelectDropDn.removeEventListener(scaleform.clik.events.ListEvent.INDEX_CHANGE, this.fitsSelectDropDnChangeHandler);
            return;
        }

        public override function setViewData(arg1:Array):void
        {
            this.fitsSelectDropDn.addEventListener(scaleform.clik.events.ListEvent.INDEX_CHANGE, this.fitsSelectDropDnChangeHandler);
            return;
        }

        public final override function setSubFilterData(arg1:int, arg2:net.wg.data.VO.ShopSubFilterData):void
        {
            if (arg2) 
            {
                setFilterData(arg2);
                this.setCurrentVehicle(getFilterData().current);
            }
            if (!(getFilterData().nation == arg1) || arg2) 
            {
                this.updateSubFilter(arg1);
            }
            return;
        }

        public override function updateSubFilter(arg1:int):void
        {
            var loc4:*=null;
            var loc1:*=0;
            var loc2:*=new scaleform.clik.data.DataProvider();
            var loc3:*=0;
            while (loc3 < getFilterData().dataProvider.length) 
            {
                if (arg1 == -1 || getFilterData().dataProvider[loc3].nation == arg1) 
                {
                    loc4 = net.wg.data.VO.ShopVehicleFilterElementData(getFilterData().dataProvider[loc3]);
                    if (this.getCurrentVehicle() == loc4.id) 
                    {
                        loc1 = loc2.length;
                    }
                    loc2.push({"label":loc4.name, "data":loc4.id});
                }
                ++loc3;
            }
            this.fitsSelectDropDn.enabled = false;
            this.fitsSelectDropDn.dataProvider = loc2;
            this.fitsSelectDropDn.menuRowCount = Math.min(loc2.length, MIN_ITEMS_FOR_SCROLL);
            this.fitsSelectDropDn.scrollBar = loc2.length > MIN_ITEMS_FOR_SCROLL ? net.wg.data.constants.Linkages.SCROLL_BAR : "";
            this.onVehicleFilterUpdated(loc2, loc1, arg1);
            return;
        }

        protected function onVehicleFilterUpdated(arg1:scaleform.clik.data.DataProvider, arg2:Number, arg3:int):void
        {
            if (arg1.length != 0) 
            {
                this.myVehicleRadioBtn.enabled = true;
                this.fitsSelectDropDn.enabled = true;
                this._programUpdating = true;
                this.fitsSelectDropDn.selectedIndex = arg2;
                this._programUpdating = false;
            }
            else 
            {
                this.myVehicleRadioBtn.enabled = false;
            }
            return;
        }

        protected function getCurrentVehicle():Object
        {
            return this._currentVehicle;
        }

        protected function setCurrentVehicle(arg1:Object):void
        {
            this._currentVehicle = arg1;
            return;
        }

        internal function fitsSelectDropDnChangeHandler(arg1:scaleform.clik.events.ListEvent):void
        {
            if (this.fitsSelectDropDn.enabled && !(getFilterData().current == arg1.itemData) && !this._programUpdating) 
            {
                getFilterData().current = arg1.itemData.data;
                if (this.myVehicleRadioBtn.selected) 
                {
                    dispatchViewChange();
                }
                else 
                {
                    this.myVehicleRadioBtn.selected = true;
                }
            }
            return;
        }

        internal static const MIN_ITEMS_FOR_SCROLL:uint=13;

        public var myVehicleRadioBtn:net.wg.gui.components.controls.RadioButton=null;

        public var fitsSelectDropDn:net.wg.gui.components.controls.DropdownMenu=null;

        internal var _currentVehicle:Object=null;

        internal var _programUpdating:Boolean=false;
    }
}
