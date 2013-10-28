package net.wg.gui.lobby.store.views
{
   import net.wg.gui.lobby.store.views.base.FitsSelectableStoreMenuView;
   import net.wg.gui.components.controls.CheckBox;
   import net.wg.gui.components.controls.RadioButton;
   import net.wg.gui.lobby.store.views.base.ViewUIElementVO;
   import scaleform.clik.data.DataProvider;


   public class ShellView extends FitsSelectableStoreMenuView
   {
          
      public function ShellView() {
         super();
      }

      public var armorPiercingChkBox:CheckBox = null;

      public var armorPiercingCRChkBox:CheckBox = null;

      public var hollowChargeChkBox:CheckBox = null;

      public var highExplosiveChkBox:CheckBox = null;

      public var myVehiclesInventoryGunsRadioBtn:RadioButton = null;

      public var myInventoryGunsRadioBtn:RadioButton = null;

      public var otherGunsRadioBtn:RadioButton = null;

      override public function resetTemporaryHandlers() : void {
         resetHandlers(getTagsArray(),null);
      }

      override public function getFilter() : Array {
         var _loc1_:Array = getSelectedFilters(getTagsArray(),true,null);
         _loc1_.push(myVehicleRadioBtn.group.data);
         _loc1_.push(getFilterData().current);
         return _loc1_;
      }

      override public function setViewData(param1:Array) : void {
         super.setViewData(param1);
         var _loc2_:Number = Number(param1.shift());
         var _loc3_:Array = param1.splice(0,_loc2_);
         var _loc4_:String = String(param1.shift());
         selectFilterSimple(getFitsArray(),_loc4_,true);
         setCurrentVehicle(param1.shift());
         updateSubFilter(getNation());
         selectFilter(getTagsArray(),_loc3_,true,false);
         dispatchViewChange();
      }

      override protected function onTagsArrayRequest() : Array {
         return [new ViewUIElementVO("ARMOR_PIERCING",this.armorPiercingChkBox),new ViewUIElementVO("ARMOR_PIERCING_CR",this.armorPiercingCRChkBox),new ViewUIElementVO("HOLLOW_CHARGE",this.hollowChargeChkBox),new ViewUIElementVO("HIGH_EXPLOSIVE",this.highExplosiveChkBox)];
      }

      override protected function onFitsArrayRequest() : Array {
         return [new ViewUIElementVO("myVehicleGun",myVehicleRadioBtn),new ViewUIElementVO("myInventoryGuns",this.myInventoryGunsRadioBtn),new ViewUIElementVO("myVehiclesInventoryGuns",this.myVehiclesInventoryGunsRadioBtn),new ViewUIElementVO("otherGuns",this.otherGunsRadioBtn)];
      }

      override protected function getTagsName() : String {
         return "kinds";
      }

      override protected function onVehicleFilterUpdated(param1:DataProvider, param2:Number, param3:int) : void {
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