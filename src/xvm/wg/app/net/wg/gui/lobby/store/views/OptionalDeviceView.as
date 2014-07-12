package net.wg.gui.lobby.store.views
{
   import net.wg.gui.lobby.store.views.base.SimpleStoreMenuView;
   import net.wg.data.constants.generated.STORE_TYPES;
   import scaleform.clik.data.DataProvider;
   
   public class OptionalDeviceView extends SimpleStoreMenuView
   {
      
      public function OptionalDeviceView() {
         super();
      }
      
      override public function resetTemporaryHandlers() : void {
         resetHandlers(getTagsArray(),myVehicleRadioBtn);
      }
      
      override public function setViewData(param1:Array) : void {
         super.setViewData(param1);
         if(getUIName() == STORE_TYPES.SHOP)
         {
            if(!onVehicleChkBx.selected)
            {
               onVehicleChkBx.selected = true;
            }
            onVehicleChkBx.visible = vehChBxHeader.visible = false;
         }
         var _loc2_:String = String(param1.shift());
         selectFilterSimple(getFitsArray(),_loc2_,true);
         setCurrentVehicle(param1.shift());
         updateSubFilter(getNation());
         selectFilter(getTagsArray(),param1,true,false);
         dispatchViewChange();
      }
      
      override public function getFilter() : Array {
         var _loc1_:Array = [myVehicleRadioBtn.group.data];
         _loc1_.push(getFilterData().current);
         _loc1_ = _loc1_.concat(getSelectedFilters(getTagsArray(),false,null));
         return _loc1_;
      }
      
      override protected function onVehicleFilterUpdated(param1:DataProvider, param2:Number, param3:int) : void {
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
         otherVehiclesRadioBtn.enabled = true;
      }
   }
}
