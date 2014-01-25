package net.wg.gui.lobby.store.views.base
{
   import net.wg.gui.components.controls.RadioButton;
   import net.wg.gui.components.controls.DropdownMenu;
   import scaleform.clik.events.ListEvent;
   import net.wg.data.VO.ShopSubFilterData;
   import net.wg.data.VO.ShopVehicleFilterElementData;
   import scaleform.clik.data.DataProvider;
   import net.wg.data.constants.Linkages;


   public class FitsSelectableStoreMenuView extends BaseStoreMenuView
   {
          
      public function FitsSelectableStoreMenuView() {
         super();
      }

      private static const MIN_ITEMS_FOR_SCROLL:uint = 13;

      public var myVehicleRadioBtn:RadioButton = null;

      public var fitsSelectDropDn:DropdownMenu = null;

      private var _currentVehicle:Object = null;

      private var _programUpdating:Boolean = false;

      override protected function onDispose() : void {
         super.onDispose();
         resetTemporaryHandlers();
         this.fitsSelectDropDn.removeEventListener(ListEvent.INDEX_CHANGE,this.fitsSelectDropDnChangeHandler);
      }

      override public function setViewData(param1:Array) : void {
         this.fitsSelectDropDn.addEventListener(ListEvent.INDEX_CHANGE,this.fitsSelectDropDnChangeHandler);
      }

      override public final function setSubFilterData(param1:int, param2:ShopSubFilterData) : void {
         if(param2)
         {
            setFilterData(param2);
            this.setCurrentVehicle(getFilterData().current);
         }
         if(!(getFilterData().nation == param1) || (param2))
         {
            this.updateSubFilter(param1);
         }
      }

      override public function updateSubFilter(param1:int) : void {
         var _loc5_:ShopVehicleFilterElementData = null;
         var _loc2_:Number = 0;
         var _loc3_:DataProvider = new DataProvider();
         var _loc4_:Number = 0;
         while(_loc4_ < getFilterData().dataProvider.length)
         {
            if(param1 == -1 || getFilterData().dataProvider[_loc4_].nation == param1)
            {
               _loc5_ = ShopVehicleFilterElementData(getFilterData().dataProvider[_loc4_]);
               if(this.getCurrentVehicle() == _loc5_.id)
               {
                  _loc2_ = _loc3_.length;
               }
               _loc3_.push(
                  {
                     "label":_loc5_.name,
                     "data":_loc5_.id
                  }
               );
            }
            _loc4_++;
         }
         this.fitsSelectDropDn.enabled = false;
         this.fitsSelectDropDn.dataProvider = _loc3_;
         this.fitsSelectDropDn.menuRowCount = Math.min(_loc3_.length,MIN_ITEMS_FOR_SCROLL);
         this.fitsSelectDropDn.scrollBar = _loc3_.length > MIN_ITEMS_FOR_SCROLL?Linkages.SCROLL_BAR:"";
         this.onVehicleFilterUpdated(_loc3_,_loc2_,param1);
      }

      protected function onVehicleFilterUpdated(param1:DataProvider, param2:Number, param3:int) : void {
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

      protected function getCurrentVehicle() : Object {
         return this._currentVehicle;
      }

      protected function setCurrentVehicle(param1:Object) : void {
         this._currentVehicle = param1;
      }

      private function fitsSelectDropDnChangeHandler(param1:ListEvent) : void {
         if((this.fitsSelectDropDn.enabled) && !(getFilterData().current == param1.itemData) && !this._programUpdating)
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