package net.wg.gui.lobby.customization 
{
    import flash.events.*;
    import flash.text.*;
    import net.wg.gui.components.controls.*;
    import net.wg.gui.lobby.customization.data.*;
    import net.wg.infrastructure.interfaces.*;
    import scaleform.clik.controls.*;
    import scaleform.clik.core.*;
    import scaleform.clik.events.*;
    
    public class BaseTimedCustomizationGroupView extends scaleform.clik.core.UIComponent implements net.wg.infrastructure.interfaces.IViewStackContent
    {
        public function BaseTimedCustomizationGroupView()
        {
            super();
            return;
        }

        public function update(arg1:Object):void
        {
            DebugUtils.LOG_DEBUG("BaseTimedCustomizationGroupView.update", arg1);
            return;
        }

        public override function dispose():void
        {
            super.dispose();
            this.clearData();
            return;
        }

        public function invalidateListData(arg1:Boolean=false):void
        {
            if (this.list.initialized && !arg1) 
                this.list.scrollPosition = 0;
            this.itemsDP.invalidateRemote(arg1);
            return;
        }

        public function setListSelectedIndex(arg1:String, arg2:Object):void
        {
            if (initialized) 
            {
                this.selectedItemIdx = this.selectedGroupName == arg1 && arg2 ? arg2.index : -1;
                if (this.selectedItemIdx > -1 && arg2 && arg2.hasOwnProperty("priceIndex")) 
                    this.rentalPackageList.selectedIndex = arg2.priceIndex;
                this.list.selectedIndex = this.selectedItemIdx;
            }
            return;
        }

        public function get selectedGroupName():String
        {
            return this.itemsDP.groupName;
        }

        public function set selectedGroupName(arg1:String):void
        {
            this.itemsDP.groupName = arg1;
            return;
        }

        public function get selectedItemIdx():int
        {
            return this._selectedItemIdx;
        }

        public function set selectedItemIdx(arg1:int):void
        {
            this._selectedItemIdx = arg1;
            return;
        }

        public function get selectedPriceIdx():int
        {
            return this._selectedPriceIdx;
        }

        public function set selectedPriceIdx(arg1:int):void
        {
            this._selectedPriceIdx = arg1;
            return;
        }

        public function initData():void
        {
            if (this.rentalPackageList != null) 
            {
                this.rentalPackageList.labelField = "userString";
                this.rentalPackageList.addEventListener(scaleform.clik.events.ListEvent.INDEX_CHANGE, this.handlePeriodDaysItemChange);
                this.rentalPackageList.dataProvider = this.rentalPackageDP;
                this.rentalPackageList.selectedIndex = this.rentalPackageDP.getSelectedPackageIndex();
            }
            if (this.list != null) 
            {
                this.list.dataProvider = this.itemsDP;
                this.list.selectedIndex = this.selectedItemIdx;
                this.list.addEventListener(scaleform.clik.events.ListEvent.INDEX_CHANGE, this.handleItemChange);
            }
            if (this.timeSectionLabel != null) 
                this.timeSectionLabel.text = this.timeLabel;
            this.itemsDP.addEventListener(flash.events.Event.CHANGE, this.handleItemDataChanged);
            return;
        }

        public function clearData():void
        {
            this.selectedItemIdx = -1;
            this.selectedPriceIdx = -1;
            if (this.list) 
            {
                this.list.dataProvider = null;
                this.list.removeEventListener(scaleform.clik.events.ListEvent.INDEX_CHANGE, this.handleItemChange);
            }
            if (this.rentalPackageList) 
            {
                this.rentalPackageList.dataProvider = null;
                this.rentalPackageList.removeEventListener(scaleform.clik.events.ListEvent.INDEX_CHANGE, this.handlePeriodDaysItemChange);
            }
            if (this.itemsDP) 
                this.itemsDP.removeEventListener(flash.events.Event.CHANGE, this.handleItemDataChanged);
            this.itemsDP = null;
            this.rentalPackageDP = null;
            return;
        }

        protected function handleItemDataChanged(arg1:flash.events.Event=null):void
        {
            var loc1:*=null;
            var loc2:*=null;
            if (this.selectedItemIdx > -1) 
            {
                loc1 = this.itemsDP.requestItemAt(this.selectedItemIdx);
                if (loc1 && loc1.id && this.selectedPriceIdx > -1) 
                {
                    loc2 = new net.wg.gui.lobby.customization.CustomizationEvent(net.wg.gui.lobby.customization.CustomizationEvent.SELECT_NEW);
                    loc2.data = loc1;
                    loc2.index = this.selectedItemIdx;
                    dispatchEvent(loc2);
                }
            }
            return;
        }

        internal function handlePeriodDaysItemChange(arg1:scaleform.clik.events.ListEvent):void
        {
            this.selectedPriceIdx = arg1.index;
            if (arg1.index > -1) 
                this.rentalPackageDP.setSelectedPackageIndex(arg1.index);
            return;
        }

        internal function handleItemChange(arg1:scaleform.clik.events.ListEvent):void
        {
            this.selectedItemIdx = arg1.index;
            this.handleItemDataChanged();
            return;
        }

        public var timeSectionLabel:flash.text.TextField=null;

        public var list:net.wg.gui.components.controls.TileList=null;

        public var rentalPackageList:scaleform.clik.controls.ScrollingList=null;

        public var itemsDP:net.wg.gui.lobby.customization.data.DAAPIItemsDataProvider=null;

        public var rentalPackageDP:net.wg.gui.lobby.customization.data.RentalPackageDAAPIDataProvider=null;

        public var timeLabel:String=null;

        internal var _selectedItemIdx:int=-1;

        internal var _selectedPriceIdx:int=-1;
    }
}
