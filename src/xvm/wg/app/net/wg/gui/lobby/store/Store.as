package net.wg.gui.lobby.store
{
   import net.wg.infrastructure.base.meta.impl.StoreMeta;
   import net.wg.infrastructure.base.meta.IStoreMeta;
   import flash.utils.Dictionary;
   import net.wg.infrastructure.interfaces.IStoreMenuView;
   import net.wg.gui.components.controls.CloseButton;
   import net.wg.data.VO.ShopSubFilterData;
   import scaleform.clik.events.InputEvent;
   import scaleform.clik.utils.Constraints;
   import scaleform.clik.constants.ConstrainMode;
   import flash.display.DisplayObject;
   import flash.ui.Keyboard;
   import flash.events.KeyboardEvent;
   import scaleform.clik.events.ButtonEvent;
   import net.wg.data.Aliases;
   import scaleform.clik.events.IndexEvent;
   import net.wg.gui.events.ViewStackEvent;
   import scaleform.clik.constants.InvalidationType;
   import net.wg.data.VO.generated.ShopNationFilterData;
   import net.wg.data.constants.FittingTypes;
   import net.wg.data.constants.Errors;
   import net.wg.infrastructure.exceptions.NullPointerException;
   import scaleform.clik.events.ListEvent;
   import net.wg.infrastructure.exceptions.AbstractException;
   import net.wg.data.components.StoreMenuViewData;
   import scaleform.clik.data.DataProvider;
   import flash.events.Event;


   public class Store extends StoreMeta implements IStoreMeta
   {
          
      public function Store() {
         super();
         this._viewsHash = new Dictionary(false);
      }

      private var _viewsHash:Dictionary = null;

      private var _currentView:IStoreMenuView = null;

      private var _myWidth:Number = 0;

      private var _myHeight:Number = 0;

      private var _programUpdating:Boolean = false;

      private var closeButton:CloseButton = null;

      public var form:StoreForm = null;

      private var _subFilterData:ShopSubFilterData = null;

      public function get subFilterData() : ShopSubFilterData {
         return this._subFilterData;
      }

      private var _nation:Number = -1;

      private function handleEscape(param1:InputEvent) : void {
         onCloseButtonClickS();
      }

      public function get nation() : Number {
         return this._nation;
      }

      public function set nation(param1:Number) : void {
         this._nation = param1;
      }

      private var _initializing:Boolean = true;

      protected function get initializing() : Boolean {
         return this._initializing;
      }

      override public final function setViewSize(param1:Number, param2:Number) : void {
         this._myWidth = param1;
         this._myHeight = param2;
         invalidateSize();
      }

      override public final function updateStage(param1:Number, param2:Number) : void {
         this.setViewSize(param1,param2);
      }

      override protected final function preInitialize() : void {
         super.preInitialize();
         constraints = new Constraints(this,ConstrainMode.REFLOW);
      }

      override protected function configUI() : void {
         assert(this.form.storeTable  is  DisplayObject,"storeTable must extends a DisplayObject class");
         constraints.addElement(this.form.nationFilter.name,this.form.nationFilter,Constraints.LEFT);
         constraints.addElement(this.form.storeTable.name,DisplayObject(this.form.storeTable),Constraints.ALL);
         this.updateStage(parent.width,parent.height);
         App.gameInputMgr.setKeyHandler(Keyboard.ESCAPE,KeyboardEvent.KEY_DOWN,this.handleEscape,true);
         this.closeButton = this.form.closeButton;
         this.closeButton.addEventListener(ButtonEvent.CLICK,this.onCloseButtonClickHandler);
         super.configUI();
      }

      override protected function onPopulate() : void {
         super.onPopulate();
         registerComponent(this.form.storeTable,Aliases.SHOP_TABLE);
         this.form.storeTable.addEventListener(StoreEvent.INFO,this.onInfoItemHandler);
      }

      override protected function onDispose() : void {
         var _loc1_:Object = null;
         this.setCurrentView(null);
         this._subFilterData.dispose();
         this._subFilterData = null;
         this.form.nationFilter.nation.removeEventListener(IndexEvent.INDEX_CHANGE,this.onNationMenuChangeHandler);
         this.form.menu.removeEventListener(IndexEvent.INDEX_CHANGE,this.onMenuChangeTypeHandler);
         this.form.menu.view.removeEventListener(ViewStackEvent.NEED_UPDATE,this.onViewNeedUpdateHandler);
         this.form.menu.dispose();
         this.closeButton.removeEventListener(ButtonEvent.CLICK,this.onCloseButtonClickHandler);
         this.closeButton.dispose();
         this.closeButton = null;
         for each (_loc1_ in this._viewsHash)
         {
            delete this._viewsHash[[_loc1_]];
         }
         this._viewsHash = null;
         App.gameInputMgr.clearKeyHandler(Keyboard.ESCAPE,KeyboardEvent.KEY_DOWN);
         super.onDispose();
      }

      override protected function draw() : void {
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            x = this._myWidth - _originalWidth >> 1;
            y = this._myHeight - _originalHeight >> 1;
         }
      }

      override protected function setFilterType(param1:ShopNationFilterData) : void {
         var _loc3_:IStoreMenuView = null;
         this.form.nationFilter.nation.selectedIndex = param1.language + 1;
         var _loc2_:Number = FittingTypes.STORE_SLOTS.indexOf(param1.type);
         if(_loc2_ != -1)
         {
            this.form.menu.selectedIndex = _loc2_;
            if(this.initializing)
            {
               this.form.menu.validateNow();
               _loc3_ = IStoreMenuView(this.form.menu.view.currentView);
               this.onViewNeedUpdate(_loc3_,this.getLinkageFromFittingType(param1.type));
            }
         }
      }

      public function as_setNations(param1:Array) : void {
         assert(param1.length > 0,Errors.CANT_EMPTY);
         this.form.nationFilter.nation.menuRowCount = param1.length;
         this.form.nationFilter.nation.createNationFilter(param1);
         if(this.initializing)
         {
            this.initMenu(this.getLocalizator());
         }
      }

      public function as_setSubFilter(param1:Object) : void {
         this._subFilterData = new ShopSubFilterData(param1);
         assertNotNull(this.getCurrentView(),"currentView",NullPointerException);
         this.getCurrentView().setSubFilterData(this.form.nationFilter.nation.selectedIndex-1,this._subFilterData);
      }

      public function as_setFilterOptions(param1:Array) : void {
         assertNotNull(this.getCurrentView(),"current view must be selected!",NullPointerException);
         this.getCurrentView().setViewData(param1);
      }

      public function as_completeInit() : void {
         this.form.menu.view.addEventListener(ViewStackEvent.NEED_UPDATE,this.onViewNeedUpdateHandler);
         this.form.menu.addEventListener(IndexEvent.INDEX_CHANGE,this.onMenuChangeTypeHandler);
         this.form.nationFilter.nation.addEventListener(ListEvent.INDEX_CHANGE,this.onNationMenuChangeHandler);
         this._initializing = false;
      }

      public function as_update() : void {
         this.updateTable();
      }

      protected function getLocalizator() : Function {
         throw new AbstractException("\'getLocalizator\'" + Errors.ABSTRACT_INVOKE);
      }

      protected final function updateTable() : void {
         var _loc1_:Array = null;
         var _loc2_:String = null;
         if(this.nation != this.form.nationFilter.nation.selectedIndex-1)
         {
            if(this._currentView)
            {
               this.nation = this.form.nationFilter.nation.selectedIndex-1;
               this._currentView.updateSubFilter(this.nation);
            }
         }
         if((this.form.menu.enabled) && (this._currentView) && !this._programUpdating)
         {
            _loc1_ = this._currentView.getFilter();
            _loc2_ = this._currentView.fittingType;
            assertNotNull(_loc2_,"fittingType");
            requestTableDataS(this.nation,_loc2_,_loc1_);
         }
      }

      protected function getLinkageFromFittingType(param1:String) : String {
         assertNotNull(param1,"fittingType",NullPointerException);
         return param1 + "ViewUI";
      }

      protected function getViewData(param1:String) : StoreMenuViewData {
         assert(this._viewsHash.hasOwnProperty(param1),"unknown view linkage:" + param1);
         return this._viewsHash[param1];
      }

      protected function onMenuChangeType() : void {
         this.onMenuChange();
      }

      protected function onMenuChange() : void {
          
      }

      protected function onViewNeedUpdate(param1:IStoreMenuView, param2:String) : void {
         this.setCurrentView(param1);
      }

      protected function getCurrentView() : IStoreMenuView {
         return this._currentView;
      }

      protected function setCurrentView(param1:IStoreMenuView) : void {
         if(this._currentView != param1)
         {
            if(this._currentView)
            {
               this._currentView.removeEventListener(StoreViewsEvent.POPULATE_MENU_FILTER,this.onPopulateMenuFilterNeedHandler);
               this._currentView.removeEventListener(StoreViewsEvent.VIEW_CHANGE,this.onMenuChangeHandler);
               this._currentView.resetTemporaryHandlers();
            }
            this._currentView = param1;
            if(this._currentView)
            {
               this._currentView.setUIName(getNameS(),this.getLocalizator());
               this._currentView.addEventListener(StoreViewsEvent.POPULATE_MENU_FILTER,this.onPopulateMenuFilterNeedHandler);
               this._currentView.addEventListener(StoreViewsEvent.VIEW_CHANGE,this.onMenuChangeHandler);
            }
         }
      }

      protected function onPopulateMenuFilterNeed(param1:String) : void {
         if(!this.initializing)
         {
            requestFilterDataS(param1);
         }
      }

      protected function initMenu(param1:Function) : void {
         var _loc3_:StoreMenuViewData = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         assertNotNull(param1,"localeEnumProcessor",NullPointerException);
         var _loc2_:DataProvider = new DataProvider();
         for each (_loc5_ in FittingTypes.STORE_SLOTS)
         {
            _loc4_ = this.getLinkageFromFittingType(_loc5_);
            _loc3_ = new StoreMenuViewData(
               {
                  "label":param1(_loc5_ + "/name"),
                  "linkage":_loc4_,
                  "fittingType":_loc5_,
                  "enabled":true
               }
            );
            this._viewsHash[_loc4_] = _loc3_;
            _loc2_.push(_loc3_);
         }
         this.form.menu.dataProvider = _loc2_;
      }

      private function onViewNeedUpdateHandler(param1:ViewStackEvent) : void {
         this._programUpdating = true;
         this.onViewNeedUpdate(IStoreMenuView(param1.view),param1.linkage);
         this._programUpdating = false;
      }

      private function onNationMenuChangeHandler(param1:ListEvent) : void {
         this.onMenuChange();
      }

      private function onMenuChangeHandler(param1:Event) : void {
         this.onMenuChange();
      }

      private function onMenuChangeTypeHandler(param1:IndexEvent) : void {
         this.onMenuChangeType();
      }

      private function onPopulateMenuFilterNeedHandler(param1:StoreViewsEvent) : void {
         this.onPopulateMenuFilterNeed(param1.viewType);
      }

      private function onInfoItemHandler(param1:StoreEvent) : void {
         onShowInfoS(param1.data);
      }

      private function onCloseButtonClickHandler(param1:ButtonEvent) : void {
         onCloseButtonClickS();
      }
   }

}