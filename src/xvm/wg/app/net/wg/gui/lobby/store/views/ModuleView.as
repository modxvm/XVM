package net.wg.gui.lobby.store.views
{
   import net.wg.gui.lobby.store.views.base.SimpleStoreMenuView;
   import net.wg.gui.components.controls.CheckBox;
   import net.wg.gui.lobby.store.views.base.ViewUIElementVO;
   import net.wg.utils.IAssertable;
   import net.wg.data.constants.generated.STORE_TYPES;
   import scaleform.clik.data.DataProvider;
   
   public class ModuleView extends SimpleStoreMenuView
   {
      
      public function ModuleView() {
         super();
      }
      
      public var vehicleGunChkBx:CheckBox = null;
      
      public var vehicleTurretChkBx:CheckBox = null;
      
      public var vehicleEngineChkBx:CheckBox = null;
      
      public var vehicleChassisChkBx:CheckBox = null;
      
      public var vehicleRadioChkBx:CheckBox = null;
      
      public var lockedChkBx:CheckBox = null;
      
      public var inHangarChkBx:CheckBox = null;
      
      private var _kindsArr:Array = null;
      
      override protected function configUI() : void {
         super.configUI();
         this.inHangarChkBx.enableDynamicFrameUpdating();
         this.lockedChkBx.enableDynamicFrameUpdating();
      }
      
      override protected function onDispose() : void {
         var _loc1_:ViewUIElementVO = null;
         super.onDispose();
         if(this._kindsArr != null)
         {
            for each(_loc1_ in this._kindsArr)
            {
               _loc1_.dispose();
            }
            this._kindsArr.splice(0,this._kindsArr.length);
            this._kindsArr = null;
         }
      }
      
      override public function resetTemporaryHandlers() : void {
         resetHandlers(this.getKindsArray(),null);
         resetHandlers(getTagsArray(),null);
      }
      
      override public function setViewData(param1:Array) : void {
         var _loc2_:* = NaN;
         var _loc3_:Array = null;
         var _loc4_:String = null;
         super.setViewData(param1);
         if(App.instance)
         {
            _loc2_ = Number(param1.shift());
            _loc3_ = param1.splice(0,_loc2_);
            selectFilter(this.getKindsArray(),_loc3_,true,false);
            _loc4_ = String(param1.shift());
            selectFilterSimple(getFitsArray(),_loc4_,true);
            setCurrentVehicle(param1.shift());
            updateSubFilter(getNation());
            selectFilter(getTagsArray(),param1,true,false);
            this.dispatchViewChange();
         }
      }
      
      override public function getFilter() : Array {
         var _loc2_:IAssertable = null;
         var _loc1_:Array = getSelectedFilters(this.getKindsArray(),true,null);
         _loc1_.push(myVehicleRadioBtn.group.data);
         if(App.instance)
         {
            _loc2_ = App.utils.asserter;
            _loc2_.assertNotNull(getFilterData(),"filter data in \'" + fittingType + "\' view must be initialized before getting!");
            _loc2_.assert(!(getFilterData().current == "0"),"invalid value in filter data!");
         }
         _loc1_.push(getFilterData().current);
         _loc1_ = _loc1_.concat(getSelectedFilters(getTagsArray(),true,null));
         return _loc1_;
      }
      
      override protected function onKindChanged() : void {
         initializeControlsByHash(fittingType,this.getKindsArray(),"kindsMap","types");
         super.onKindChanged();
      }
      
      override protected function onTagsArrayRequest() : Array {
         if(getUIName() == STORE_TYPES.SHOP)
         {
            return [new ViewUIElementVO("locked",this.lockedChkBx),new ViewUIElementVO("onVehicle",onVehicleChkBx),new ViewUIElementVO("inHangar",this.inHangarChkBx)];
         }
         return [new ViewUIElementVO("onVehicle",onVehicleChkBx)];
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
      }
      
      private function getKindsArray() : Array {
         if(this._kindsArr == null)
         {
            this._kindsArr = [new ViewUIElementVO("vehicleGun",this.vehicleGunChkBx),new ViewUIElementVO("vehicleTurret",this.vehicleTurretChkBx),new ViewUIElementVO("vehicleEngine",this.vehicleEngineChkBx),new ViewUIElementVO("vehicleChassis",this.vehicleChassisChkBx),new ViewUIElementVO("vehicleRadio",this.vehicleRadioChkBx)];
         }
         return this._kindsArr;
      }
   }
}
