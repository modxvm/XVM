package net.wg.gui.lobby.store.views.base
{
   import scaleform.clik.core.UIComponent;
   import net.wg.infrastructure.interfaces.IStoreMenuView;
   import scaleform.clik.controls.ButtonGroup;
   import net.wg.utils.IAssertable;
   import net.wg.data.constants.Errors;
   import net.wg.infrastructure.exceptions.NullPointerException;
   import scaleform.clik.controls.Button;
   import net.wg.data.VO.ShopSubFilterData;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.data.components.StoreMenuViewData;
   import net.wg.data.constants.generated.STORE_TYPES;
   import flash.events.Event;
   import net.wg.gui.lobby.store.StoreViewsEvent;
   import net.wg.infrastructure.exceptions.AbstractException;


   public class BaseStoreMenuView extends UIComponent implements IStoreMenuView
   {
          
      public function BaseStoreMenuView() {
         super();
      }

      protected static function assertGroupSelection(param1:ButtonGroup, param2:String, param3:Boolean=false) : void {
         var _loc4_:IAssertable = null;
         if(App.instance)
         {
            _loc4_ = App.utils.asserter;
            _loc4_.assertNotNull(param1,param2 + ".group" + Errors.CANT_NULL,NullPointerException);
            if(param3)
            {
               _loc4_.assertNotNull(param1.selectedButton,param2 + ".group.selectedButton" + Errors.CANT_NULL);
            }
         }
      }

      protected static function getSelectedFilters(param1:Array, param2:Boolean, param3:Button) : Array {
         var _loc5_:ViewUIElementVO = null;
         var _loc4_:Array = [];
         for each (_loc5_ in param1)
         {
            if((_loc5_.instance.selected) || (param3) && (param3.selected))
            {
               App.utils.asserter.assertNotNull(_loc5_.instance.data,_loc5_.instance.name + ".data" + Errors.CANT_NULL);
               _loc4_.push(_loc5_.instance.data);
            }
         }
         if(param2)
         {
            _loc4_.unshift(_loc4_.length);
         }
         return _loc4_;
      }

      private static function initializeControlsByHashLocalized(param1:String, param2:Array, param3:String, param4:String, param5:Function) : void {
         var _loc6_:ViewUIElementVO = null;
         if(App.instance)
         {
            for each (_loc6_ in param2)
            {
               if(_loc6_.instance.visible)
               {
                  _loc6_.instance.data = _loc6_.name;
                  _loc6_.instance.label = param5(param1 + "/" + param4 + "/" + _loc6_.name + "/name");
               }
            }
         }
      }

      private var _fittingType:String = null;

      private var _filterData:ShopSubFilterData = null;

      private var _nation:int = -1;

      private var _tagsArr:Array = null;

      private var _fitsArr:Array = null;

      private var _uiName:String = null;

      private var _localizator:Function = null;

      override public function dispose() : void {
         var _loc1_:IDisposable = null;
         var _loc2_:IDisposable = null;
         super.dispose();
         if(this._tagsArr != null)
         {
            for each (_loc1_ in this._tagsArr)
            {
               _loc1_.dispose();
            }
            this._tagsArr.splice(0);
            this._tagsArr = null;
         }
         if(this._fitsArr != null)
         {
            for each (_loc2_ in this._fitsArr)
            {
               _loc2_.dispose();
            }
            this._fitsArr.splice(0);
            this._fitsArr = null;
         }
         this._filterData = null;
      }

      public final function update(param1:Object) : void {
         var _loc2_:String = null;
         var _loc3_:StoreMenuViewData = null;
         if(App.instance)
         {
            _loc2_ = "updateData must be StoreMenuViewData";
            App.utils.asserter.assert(param1  is  StoreMenuViewData,_loc2_);
            _loc3_ = StoreMenuViewData(param1);
            if(this._fittingType != _loc3_.fittingType)
            {
               this._fittingType = _loc3_.fittingType;
               this.onKindChanged();
            }
         }
      }

      public function resetTemporaryHandlers() : void {
          
      }

      public function setUIName(param1:String, param2:Function) : void {
         App.utils.asserter.assert(param1 == STORE_TYPES.SHOP || param1 == STORE_TYPES.INVENTORY,"incorrect uiName: \'" + param1 + "\'");
         this._uiName = param1;
         gotoAndStop(this._uiName);
         this._localizator = param2;
         if(this._fitsArr != null)
         {
            this._fitsArr.splice();
            this._fitsArr = null;
         }
      }

      protected function getUIName() : String {
         return this._uiName;
      }

      public function setSubFilterData(param1:int, param2:ShopSubFilterData) : void {
         throw this.abstractInvoke("setSubFilterData",param1,param2);
      }

      public function updateSubFilter(param1:int) : void {
         throw this.abstractInvoke("updateSubFilter",param1);
      }

      public function getFilter() : Array {
         throw this.abstractInvoke("getFilter");
      }

      public function setViewData(param1:Array) : void {
         throw this.abstractInvoke("setViewData",param1);
      }

      public function get fittingType() : String {
         if(this._fittingType == null)
         {
            DebugUtils.LOG_WARNING("fitting type accessor invoked before field has been initialized.");
         }
         return this._fittingType;
      }

      protected final function selectFilter(param1:Array, param2:Array, param3:Boolean, param4:Boolean) : void {
         var _loc5_:ViewUIElementVO = null;
         var _loc6_:Button = null;
         var _loc7_:String = null;
         for each (_loc5_ in param1)
         {
            _loc6_ = _loc5_.instance;
            App.utils.asserter.assertNotNull(_loc6_.data,"data of filter control" + Errors.CANT_NULL);
            for each (_loc7_ in param2)
            {
               if(_loc7_ == _loc6_.data)
               {
                  _loc6_.selected = true;
                  break;
               }
            }
            if(param3)
            {
               if(!_loc6_.hasEventListener(Event.SELECT))
               {
                  _loc6_.addEventListener(Event.SELECT,this.onFilterChangeHandler);
               }
            }
         }
         if(param4)
         {
            this.addHandlerToGroup(_loc6_);
         }
      }

      protected final function addHandlerToGroup(param1:Button) : void {
         var _loc2_:ButtonGroup = param1.group;
         if(App.instance)
         {
            App.utils.asserter.assertNotNull(param1,"instance" + Errors.CANT_NULL,NullPointerException);
         }
         assertGroupSelection(_loc2_,param1.name);
         _loc2_.addEventListener(Event.CHANGE,this.onFilterChangeHandler);
      }

      protected final function selectFilterSimple(param1:Array, param2:Object, param3:Boolean) : void {
         var _loc4_:ViewUIElementVO = null;
         var _loc5_:Button = null;
         var _loc6_:ButtonGroup = null;
         for each (_loc4_ in param1)
         {
            _loc5_ = _loc4_.instance;
            if(param2 == _loc5_.data)
            {
               _loc5_.selected = true;
               break;
            }
         }
         if(param3)
         {
            _loc6_ = _loc5_.group;
            assertGroupSelection(_loc6_,_loc5_.name);
            _loc6_.addEventListener(Event.CHANGE,this.onFilterChangeHandler);
         }
      }

      protected final function resetHandlers(param1:Array, param2:Button) : void {
         var _loc3_:ViewUIElementVO = null;
         for each (_loc3_ in param1)
         {
            _loc3_.instance.removeEventListener(Event.SELECT,this.onFilterChangeHandler);
         }
         if(param2)
         {
            param2.group.removeEventListener(Event.CHANGE,this.onFilterChangeHandler);
         }
      }

      protected function getNation() : int {
         return this._nation;
      }

      protected function getFilterData() : ShopSubFilterData {
         return this._filterData;
      }

      protected function setFilterData(param1:ShopSubFilterData) : void {
         var _loc2_:IAssertable = null;
         if(App.instance)
         {
            _loc2_ = App.utils.asserter;
            _loc2_.assertNotNull(param1,"shopVehicleFilterData" + Errors.CANT_NULL);
            _loc2_.assert(!(param1.current == "0"),"incorrect current id from python!");
            _loc2_.assertNotNull(param1.dataProvider,"shopVehicleFilterData.dataProvider" + Errors.CANT_NULL);
         }
         this._filterData = param1;
      }

      protected final function dispatchViewChange() : void {
         dispatchEvent(this.getStoreViewEvent(StoreViewsEvent.VIEW_CHANGE));
      }

      protected function onKindChanged() : void {
         var _loc1_:* = " method result";
         this.initializeControlsByHash(this.specialKindForTags(),this.getTagsArray(),"getTagsArray" + _loc1_,this.getTagsName());
         this.initializeControlsByHash(this._fittingType,this.getFitsArray(),"getFitsArray" + _loc1_,this.getFitsName());
         dispatchEvent(this.getStoreViewEvent(StoreViewsEvent.POPULATE_MENU_FILTER));
      }

      protected final function getTagsArray() : Array {
         if(this._tagsArr == null)
         {
            this._tagsArr = this.onTagsArrayRequest();
         }
         return this._tagsArr;
      }

      protected function onTagsArrayRequest() : Array {
         throw this.abstractInvoke("onTagsArrayRequest");
      }

      protected final function getFitsArray() : Array {
         if(this._fitsArr == null)
         {
            this._fitsArr = this.onFitsArrayRequest();
         }
         return this._fitsArr;
      }

      protected function onFitsArrayRequest() : Array {
         throw this.abstractInvoke("onFitsArrayRequest");
      }

      protected function getFitsName() : String {
         return "fits";
      }

      protected function getTagsName() : String {
         return "tags";
      }

      protected function specialKindForTags() : String {
         return this.fittingType;
      }

      protected function initializeControlsByHash(param1:String, param2:Array, param3:String, param4:String) : void {
         App.utils.asserter.assertNotNull(this._localizator,"_localizator" + Errors.CANT_NULL);
         initializeControlsByHashLocalized(param1,param2,param3,param4,this._localizator);
      }

      private function getStoreViewEvent(param1:String) : StoreViewsEvent {
         return new StoreViewsEvent(param1,this.fittingType);
      }

      private function abstractInvoke(param1:String, ... rest) : Error {
         return new AbstractException(this.toString() + "\'::" + param1 + "(" + rest.join(",") + ")\'" + Errors.ABSTRACT_INVOKE);
      }

      private function onFilterChangeHandler(param1:Event) : void {
         this.dispatchViewChange();
      }
   }

}