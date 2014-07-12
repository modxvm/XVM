package net.wg.gui.components.controls
{
   import scaleform.clik.core.UIComponent;
   import net.wg.gui.components.advanced.SortableHeaderButtonBar;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import scaleform.clik.interfaces.IDataProvider;
   import scaleform.clik.utils.Padding;
   import scaleform.clik.data.DataProvider;
   import net.wg.data.constants.SortingInfo;
   import scaleform.clik.constants.InvalidationType;
   import net.wg.data.constants.Linkages;
   import net.wg.gui.events.SortingEvent;
   import scaleform.clik.events.ListEvent;
   import net.wg.gui.events.SortableTableListEvent;
   import scaleform.clik.interfaces.IListItemRenderer;
   
   public class SortableTable extends UIComponent
   {
      
      public function SortableTable() {
         super();
      }
      
      public static const INV_LIST_DATA:String = "InvListData";
      
      public static const INV_HEADER_DATA:String = "InvHeaderData";
      
      public static const INV_UNIQ_KEY:String = "InvUniqKey";
      
      public static const INV_SORTING:String = "InvSorting";
      
      public static const INV_HANDLERS:String = "InvHandlers";
      
      private static const LEFT_PADDING:int = 2;
      
      protected var header:SortableHeaderButtonBar = null;
      
      protected var list:SortableTableList = null;
      
      protected var upperShadow:MovieClip = null;
      
      protected var lowerShadow:MovieClip = null;
      
      protected var container:Sprite = null;
      
      private var _headerHeight:int = 48;
      
      private var _listLinkage:String = "SortableScrollingList_UI";
      
      private var _rendererLinkage:String = "TableRenderer_UI";
      
      private var _isSortable:Boolean = true;
      
      private var _headerDP:IDataProvider = null;
      
      private var _listDP:IDataProvider = null;
      
      private var _isRendererToggle:Boolean = false;
      
      private var _rowHeight:Number = 34;
      
      private var _useRightBtn:Boolean = false;
      
      private var _useSmartScrollbar:Boolean = true;
      
      private var _isListSelectable:Boolean = true;
      
      private var wasComponentsInited:Boolean = false;
      
      private var _key:String = "";
      
      private var _value:Object = null;
      
      private var _sortingID:String = "";
      
      private var _sortDir:String = "";
      
      private var _uniqKeyForAutoSelect:String = "";
      
      private var invHeaderIndx:Boolean = false;
      
      private var invListIndx:Boolean = false;
      
      private var invScrollKey:Boolean = false;
      
      private var invSelKey:Boolean = false;
      
      private var _headerSelectedIndex:int = 0;
      
      private var _listSelectedIndex:int = 0;
      
      private var _rowHeightFixed:Boolean = true;
      
      private var _scrollbarPadding:Padding = null;
      
      private var _rowWidthAutoResize:Boolean = true;
      
      private var hitMc:Sprite = null;
      
      public function get isListSelectable() : Boolean {
         return this._isListSelectable;
      }
      
      public function set isListSelectable(param1:Boolean) : void {
         this._isListSelectable = param1;
      }
      
      public function set scrollbarPadding(param1:Object) : void {
         this._scrollbarPadding = new Padding(param1.top,param1.right,param1.bottom,param1.left);
      }
      
      public function get rowHeight() : Number {
         return this._rowHeight;
      }
      
      public function set rowHeight(param1:Number) : void {
         this._rowHeight = param1;
      }
      
      public function get rowHeightFixed() : Boolean {
         return this._rowHeightFixed;
      }
      
      public function set rowHeightFixed(param1:Boolean) : void {
         this._rowHeightFixed = param1;
      }
      
      public function get headerHeight() : int {
         return this._headerHeight;
      }
      
      public function set headerHeight(param1:int) : void {
         this._headerHeight = param1;
      }
      
      public function get rowWidthAutoResize() : Boolean {
         return this._rowWidthAutoResize;
      }
      
      public function set rowWidthAutoResize(param1:Boolean) : void {
         this._rowWidthAutoResize = param1;
      }
      
      public function get listLinkage() : String {
         return this._listLinkage;
      }
      
      public function set listLinkage(param1:String) : void {
         this._listLinkage = param1;
      }
      
      public function get rendererLinkage() : String {
         return this._rendererLinkage;
      }
      
      public function set rendererLinkage(param1:String) : void {
         this._rendererLinkage = param1;
      }
      
      public function get isSortable() : Boolean {
         return this._isSortable;
      }
      
      public function set isSortable(param1:Boolean) : void {
         this._isSortable = param1;
      }
      
      public function get useRightBtn() : Boolean {
         return this._useRightBtn;
      }
      
      public function set useRightBtn(param1:Boolean) : void {
         this._useRightBtn = param1;
      }
      
      public function get useSmartScrollbar() : Boolean {
         return this._useSmartScrollbar;
      }
      
      public function set useSmartScrollbar(param1:Boolean) : void {
         this._useSmartScrollbar = param1;
      }
      
      public function get headerDP() : IDataProvider {
         return this._headerDP;
      }
      
      public function set headerDP(param1:IDataProvider) : void {
         this._headerDP = this.setAdditionalOptions(param1);
         invalidate(INV_HEADER_DATA);
      }
      
      public function get isRendererToggle() : Boolean {
         return this._isRendererToggle;
      }
      
      public function set isRendererToggle(param1:Boolean) : void {
         this._isRendererToggle = param1;
      }
      
      private function setAdditionalOptions(param1:IDataProvider) : IDataProvider {
         var _loc4_:NormalSortingBtnInfo = null;
         var _loc2_:int = param1.length;
         var _loc3_:* = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = param1[_loc3_] as NormalSortingBtnInfo;
            if(_loc4_)
            {
               _loc4_.buttonHeight = this._headerHeight;
               if(!this._isSortable)
               {
                  _loc4_.enabled = false;
               }
               _loc4_.showSeparator = this._isSortable;
               if(_loc3_ == _loc2_ - 1)
               {
                  _loc4_.showSeparator = false;
               }
            }
            _loc3_++;
         }
         return param1;
      }
      
      public function get listDP() : IDataProvider {
         return this._listDP;
      }
      
      public function set listDP(param1:IDataProvider) : void {
         this._listDP = param1;
         invalidate(INV_LIST_DATA);
      }
      
      override protected function configUI() : void {
         super.configUI();
         if(this.container == null)
         {
            this.container = new Sprite();
            addChild(this.container);
            this.hitMc = new Sprite();
            addChild(this.hitMc);
            this.container.hitArea = this.hitMc;
         }
      }
      
      override protected function initialize() : void {
         this._headerDP = new DataProvider();
         this._listDP = new DataProvider();
         this._scrollbarPadding = new Padding(0);
         super.initialize();
      }
      
      override protected function onDispose() : void {
         this.cleanUpListHandlers();
         if(this.header)
         {
            this.header.dispose();
            this.header = null;
         }
         if(this._headerDP)
         {
            this._headerDP.cleanUp();
            this._headerDP = null;
         }
         if(this.list)
         {
            this.list.dispose();
         }
         if(this._listDP)
         {
            this._listDP.cleanUp();
            this._listDP = null;
         }
         if(this.container)
         {
            this.container.hitArea = null;
            this.container = null;
         }
         this.hitMc = null;
         if(this.upperShadow)
         {
            this.upperShadow = null;
         }
         if(this.lowerShadow)
         {
            this.lowerShadow = null;
         }
         this._scrollbarPadding = null;
         super.onDispose();
      }
      
      override protected function draw() : void {
         var _loc1_:* = 0;
         var _loc2_:NormalSortingButton = null;
         var _loc3_:* = NaN;
         super.draw();
         if(!this.wasComponentsInited)
         {
            this.initComponents();
         }
         if(this.wasComponentsInited)
         {
            if(isInvalid(INV_UNIQ_KEY))
            {
               this.list.uniqKeyForAutoSelect = this._uniqKeyForAutoSelect;
            }
            if(isInvalid(INV_HEADER_DATA))
            {
               this.header.dataProvider = this._headerDP;
               if(!this._isSortable)
               {
                  this.header.selectedIndex = -1;
               }
               this.header.validateNow();
               if(this.list)
               {
                  this.list.columnsData = this.header.dataProvider;
               }
               this.header.visible = Boolean(this.header.dataProvider.length);
            }
            if(isInvalid(INV_LIST_DATA))
            {
               this.list.dataProvider = this._listDP;
               this.list.validateNow();
            }
            if((isInvalid(INV_SORTING)) && (this._sortingID))
            {
               if(this.header.dataProvider.length > 0 && (this._isSortable))
               {
                  _loc1_ = 0;
                  while(_loc1_ < this.header.renderersCount)
                  {
                     _loc2_ = NormalSortingButton(this.header.getButtonAt(_loc1_));
                     if(_loc2_.id == this._sortingID)
                     {
                        this.header.selectedIndex = _loc1_;
                        this.header.validateNow();
                        _loc2_.sortDirection = this._sortDir;
                        _loc2_.validateNow();
                        break;
                     }
                     _loc1_++;
                  }
               }
               this.list.sortByField(this._sortingID,this._sortDir == SortingInfo.ASCENDING_SORT);
               this.list.validateNow();
            }
            if(this.invListIndx)
            {
               this.list.selectedIndex = this._listSelectedIndex;
               this.list.validateNow();
               this.invListIndx = false;
            }
            if((this.invHeaderIndx) && (this._isSortable))
            {
               this.header.selectedIndex = this._headerSelectedIndex;
               this.header.validateNow();
               this.invHeaderIndx = false;
            }
            if((this.invSelKey) && (this._key))
            {
               this.list.selectedItemByUniqKey(this._key,this._value);
               this.list.validateNow();
               this.invSelKey = false;
            }
            if((this.invScrollKey) && (this._key))
            {
               this.list.scrollToItemByUniqKey(this._key,this._value);
               this.list.validateNow();
               this.invScrollKey = false;
            }
            if(isInvalid(InvalidationType.SIZE))
            {
               _loc3_ = _height - this._headerHeight;
               this.list.setSize(_width,_loc3_);
               this.list.validateNow();
               this.upperShadow.width = _width;
               this.lowerShadow.width = _width;
               this.lowerShadow.y = _height;
               this.hitMc.width = _width;
               this.hitMc.height = _height;
            }
            if(isInvalid(INV_HANDLERS))
            {
               this.setupListHandlers();
            }
         }
      }
      
      public function sortByField(param1:String, param2:String) : void {
         this._sortingID = param1;
         this._sortDir = param2;
         invalidate(INV_SORTING);
      }
      
      private function initComponents() : void {
         removeChild(this.container);
         setActualSize(_width,_height);
         this.container.scaleX = 1 / scaleX;
         this.container.scaleY = 1 / scaleY;
         addChild(this.container);
         this.initLists();
         this.initShadows();
         this.initHeaderButtonBar();
         this.wasComponentsInited = true;
         invalidate(INV_HANDLERS);
      }
      
      private function initShadows() : void {
         this.upperShadow = App.utils.classFactory.getComponent(Linkages.TABLE_SHADDOW_UI,MovieClip);
         this.lowerShadow = App.utils.classFactory.getComponent(Linkages.ROTATED_TABLE_SHADDOW_UI,MovieClip);
         this.lowerShadow.mouseEnabled = this.upperShadow.mouseEnabled = false;
         this.lowerShadow.mouseChildren = this.upperShadow.mouseChildren = false;
         this.container.addChild(this.upperShadow);
         this.container.addChild(this.lowerShadow);
         this.lowerShadow.width = this.upperShadow.width = _width;
         this.upperShadow.y = this._headerHeight;
         this.lowerShadow.y = _height;
      }
      
      private function initHeaderButtonBar() : void {
         this.header = App.utils.classFactory.getComponent(Linkages.SORTABLE_BUTTON_BAR_UI,SortableHeaderButtonBar);
         this.header.itemRendererName = Linkages.NORMAL_SORT_BTN_UI;
         this.header.x = LEFT_PADDING;
         this.header.width = _width;
         this.header.height = this._headerHeight;
         this.header.dataProvider = this._headerDP;
         this.container.addChild(this.header);
         if(this.list)
         {
            this.list.columnsData = this.header.dataProvider;
         }
         this.header.validateNow();
      }
      
      private function initLists() : void {
         var _loc1_:Number = _height - this._headerHeight;
         this.list = App.utils.classFactory.getComponent(Linkages.SORTABLE_SCROLLING_LIST_UI,SortableTableList);
         this.list.itemRendererName = this._rendererLinkage;
         this.list.smartScrollBar = this._useSmartScrollbar;
         this.list.scrollBar = Linkages.SCROLL_BAR;
         this.list.isRowHeightFixed = this._rowHeightFixed;
         this.list.dataProvider = this._listDP;
         this.list.setSize(_width,_loc1_);
         this.list.isSelectable = this._isListSelectable;
         this.list.useRightButton = this._useRightBtn;
         this.list.widthAutoResize = this._rowWidthAutoResize;
         this.list.sbPadding = this._scrollbarPadding;
         this.list.rowHeight = this._rowHeight;
         this.list.y = this._headerHeight;
         this.container.addChild(this.list);
         this.list.validateNow();
      }
      
      private function setupListHandlers() : void {
         if(this.header)
         {
            this.header.addEventListener(SortingEvent.SORT_DIRECTION_CHANGED,this.sortingChangedHandler,false,0,true);
         }
         if(this.list)
         {
            this.list.addEventListener(SortingEvent.SELECTED_DATA_CHANGED,this.dataChangeHandler);
            this.list.addEventListener(ListEvent.INDEX_CHANGE,this.dispatchTableEvent);
            this.list.addEventListener(ListEvent.ITEM_CLICK,this.dispatchTableEvent);
            this.list.addEventListener(ListEvent.ITEM_DOUBLE_CLICK,this.dispatchTableEvent);
            this.list.addEventListener(ListEvent.ITEM_PRESS,this.dispatchTableEvent);
            this.list.addEventListener(ListEvent.ITEM_ROLL_OVER,this.dispatchTableEvent);
            this.list.addEventListener(ListEvent.ITEM_ROLL_OUT,this.dispatchTableEvent);
         }
      }
      
      private function cleanUpListHandlers() : void {
         if(this.header)
         {
            this.header.removeEventListener(SortingEvent.SORT_DIRECTION_CHANGED,this.sortingChangedHandler,false);
         }
         if(this.list)
         {
            this.list.removeEventListener(SortingEvent.SELECTED_DATA_CHANGED,this.dataChangeHandler);
            this.list.removeEventListener(ListEvent.INDEX_CHANGE,this.dispatchTableEvent);
            this.list.removeEventListener(ListEvent.ITEM_CLICK,this.dispatchTableEvent);
            this.list.removeEventListener(ListEvent.ITEM_DOUBLE_CLICK,this.dispatchTableEvent);
            this.list.removeEventListener(ListEvent.ITEM_PRESS,this.dispatchTableEvent);
            this.list.removeEventListener(ListEvent.ITEM_ROLL_OVER,this.dispatchTableEvent);
            this.list.removeEventListener(ListEvent.ITEM_ROLL_OUT,this.dispatchTableEvent);
         }
      }
      
      private function sortingChangedHandler(param1:SortingEvent) : void {
         var _loc2_:NormalSortingButton = NormalSortingButton(param1.target);
         if(_loc2_.sortDirection != SortingInfo.WITHOUT_SORT)
         {
            this.list.sortByField(_loc2_.id,_loc2_.sortDirection == SortingInfo.ASCENDING_SORT);
         }
      }
      
      private function dispatchTableEvent(param1:ListEvent) : void {
         if((this._isRendererToggle) && param1.type == ListEvent.ITEM_CLICK)
         {
            if(this.listSelectedIndex == param1.index)
            {
               this.list.resetSelectedItem();
            }
         }
         dispatchEvent(new SortableTableListEvent(param1));
         param1.stopImmediatePropagation();
      }
      
      public function set headerSelectedIndex(param1:int) : void {
         this._headerSelectedIndex = param1;
         this.invHeaderIndx = true;
         invalidate();
      }
      
      public function set listSelectedIndex(param1:int) : void {
         this._listSelectedIndex = param1;
         this.invListIndx = true;
         invalidate();
      }
      
      public function get headerSelectedIndex() : int {
         if(this.header)
         {
            return this.header.selectedIndex;
         }
         return -1;
      }
      
      public function get listSelectedIndex() : int {
         if(this.list)
         {
            return this.list.selectedIndex;
         }
         return -1;
      }
      
      public function getListSelectedItem() : Object {
         if(this.list)
         {
            return this.list.selectedItem;
         }
         return null;
      }
      
      public function get scrollPosition() : Number {
         if(this.list)
         {
            return this.list.scrollPosition;
         }
         return 0;
      }
      
      public function get totalRenderers() : int {
         if(this.list)
         {
            return this.list.renderersCount;
         }
         return 0;
      }
      
      public function getRendererAt(param1:int, param2:int) : IListItemRenderer {
         if(this.list)
         {
            return this.list.getRendererAt(param1,param2);
         }
         return null;
      }
      
      public function getHeaderBtnByID(param1:String) : NormalSortingButton {
         var _loc2_:* = 0;
         var _loc3_:NormalSortingButton = null;
         if((this.header) && this.header.renderersCount > 0)
         {
            _loc2_ = 0;
            while(_loc2_ < this.header.renderersCount)
            {
               _loc3_ = NormalSortingButton(this.header.getButtonAt(_loc2_));
               if(_loc3_.id == param1)
               {
                  return _loc3_;
               }
               _loc2_++;
            }
         }
         return null;
      }
      
      public function selectListItemByUniqKey(param1:String, param2:Object) : void {
         this._key = param1;
         this._value = param2;
         this.invSelKey = true;
         invalidate();
      }
      
      public function scrollListToItemByUniqKey(param1:String, param2:Object) : void {
         this._key = param1;
         this._value = param2;
         this.invScrollKey = true;
         invalidate();
      }
      
      public function get uniqKeyForAutoSelect() : String {
         return this._uniqKeyForAutoSelect;
      }
      
      public function set uniqKeyForAutoSelect(param1:String) : void {
         this._uniqKeyForAutoSelect = param1;
         invalidate(INV_UNIQ_KEY);
      }
      
      private function dataChangeHandler(param1:SortingEvent) : void {
         param1.stopImmediatePropagation();
         dispatchEvent(new SortingEvent(SortingEvent.SELECTED_DATA_CHANGED));
      }
   }
}
