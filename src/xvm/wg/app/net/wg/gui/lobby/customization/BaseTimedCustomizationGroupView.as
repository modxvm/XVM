package net.wg.gui.lobby.customization
{
   import scaleform.clik.core.UIComponent;
   import net.wg.infrastructure.interfaces.IViewStackContent;
   import flash.text.TextField;
   import net.wg.gui.components.controls.TileList;
   import net.wg.gui.components.controls.ScrollingListAutoScroll;
   import net.wg.gui.lobby.customization.data.DAAPIItemsDataProvider;
   import net.wg.gui.lobby.customization.data.RentalPackageDAAPIDataProvider;
   import scaleform.clik.events.ListEvent;
   import flash.events.Event;


   public class BaseTimedCustomizationGroupView extends UIComponent implements IViewStackContent
   {
          
      public function BaseTimedCustomizationGroupView() {
         super();
      }

      public var timeSectionLabel:TextField = null;

      public var list:TileList = null;

      public var rentalPackageList:ScrollingListAutoScroll = null;

      public var itemsDP:DAAPIItemsDataProvider = null;

      public var rentalPackageDP:RentalPackageDAAPIDataProvider = null;

      public var timeLabel:String = null;

      private var _selectedItemIdx:int = -1;

      private var _selectedPriceIdx:int = -1;

      public function update(param1:Object) : void {
         DebugUtils.LOG_DEBUG("BaseTimedCustomizationGroupView.update",param1);
      }

      override public function dispose() : void {
         super.dispose();
         this.clearData();
      }

      public function invalidateListData(param1:Boolean=false) : void {
         if((this.list.initialized) && !param1)
         {
            this.list.scrollPosition = 0;
         }
         this.itemsDP.invalidateRemote(param1);
      }

      public function setListSelectedIndex(param1:String, param2:Object) : void {
         if(initialized)
         {
            this.selectedItemIdx = this.selectedGroupName == param1 && (param2)?param2.index:-1;
            if((this.selectedItemIdx > -1) && (param2) && (param2.hasOwnProperty("priceIndex")))
            {
               this.rentalPackageList.selectedIndex = param2.priceIndex;
            }
            this.list.selectedIndex = this.selectedItemIdx;
         }
      }

      public function get selectedGroupName() : String {
         return this.itemsDP.groupName;
      }

      public function set selectedGroupName(param1:String) : void {
         this.itemsDP.groupName = param1;
      }

      public function get selectedItemIdx() : int {
         return this._selectedItemIdx;
      }

      public function set selectedItemIdx(param1:int) : void {
         this._selectedItemIdx = param1;
      }

      public function get selectedPriceIdx() : int {
         return this._selectedPriceIdx;
      }

      public function set selectedPriceIdx(param1:int) : void {
         this._selectedPriceIdx = param1;
      }

      public function initData() : void {
         if(this.rentalPackageList != null)
         {
            this.rentalPackageList.labelField = "userString";
            this.rentalPackageList.addEventListener(ListEvent.INDEX_CHANGE,this.handlePeriodDaysItemChange);
            this.rentalPackageList.dataProvider = this.rentalPackageDP;
            this.rentalPackageList.selectedIndex = this.rentalPackageDP.getSelectedPackageIndex();
         }
         if(this.list != null)
         {
            this.list.dataProvider = this.itemsDP;
            this.list.selectedIndex = this.selectedItemIdx;
            this.list.addEventListener(ListEvent.INDEX_CHANGE,this.handleItemChange);
         }
         if(this.timeSectionLabel != null)
         {
            this.timeSectionLabel.text = this.timeLabel;
         }
         this.itemsDP.addEventListener(Event.CHANGE,this.handleItemDataChanged);
      }

      public function clearData() : void {
         this.selectedItemIdx = -1;
         this.selectedPriceIdx = -1;
         if(this.list)
         {
            this.list.dataProvider = null;
            this.list.removeEventListener(ListEvent.INDEX_CHANGE,this.handleItemChange);
         }
         if(this.rentalPackageList)
         {
            this.rentalPackageList.dataProvider = null;
            this.rentalPackageList.removeEventListener(ListEvent.INDEX_CHANGE,this.handlePeriodDaysItemChange);
         }
         if(this.itemsDP)
         {
            this.itemsDP.removeEventListener(Event.CHANGE,this.handleItemDataChanged);
         }
         this.itemsDP = null;
         this.rentalPackageDP = null;
      }

      protected function handleItemDataChanged(param1:Event=null) : void {
         var _loc2_:Object = null;
         var _loc3_:CustomizationEvent = null;
         if(this.selectedItemIdx > -1)
         {
            _loc2_ = this.itemsDP.requestItemAt(this.selectedItemIdx);
            if((_loc2_) && (_loc2_.id) && this.selectedPriceIdx > -1)
            {
               _loc3_ = new CustomizationEvent(CustomizationEvent.SELECT_NEW);
               _loc3_.data = _loc2_;
               _loc3_.index = this.selectedItemIdx;
               dispatchEvent(_loc3_);
            }
         }
      }

      private function handlePeriodDaysItemChange(param1:ListEvent) : void {
         this.selectedPriceIdx = param1.index;
         if(param1.index > -1)
         {
            this.rentalPackageDP.setSelectedPackageIndex(param1.index);
         }
      }

      private function handleItemChange(param1:ListEvent) : void {
         this.selectedItemIdx = param1.index;
         this.handleItemDataChanged();
      }
   }

}