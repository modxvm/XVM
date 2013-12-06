package net.wg.gui.lobby.hangar.tcarousel
{
   import net.wg.infrastructure.base.meta.impl.TankCarouselMeta;
   import net.wg.infrastructure.base.meta.ITankCarouselMeta;
   import net.wg.infrastructure.interfaces.IDAAPIModule;
   import net.wg.infrastructure.interfaces.IHelpLayoutComponent;
   import flash.display.MovieClip;
   import net.wg.gui.components.controls.SoundButton;
   import net.wg.gui.components.controls.DropDownImageText;
   import net.wg.gui.components.controls.CheckBox;
   import flash.display.DisplayObject;
   import net.wg.utils.IHelpLayout;
   import net.wg.data.constants.Directions;
   import scaleform.clik.events.ListEvent;
   import flash.events.Event;
   import scaleform.clik.data.ListData;
   import scaleform.clik.interfaces.IListItemRenderer;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import flash.events.MouseEvent;
   import net.wg.gui.events.ListEventEx;
   import net.wg.data.constants.Tooltips;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.data.DataProvider;
   import net.wg.utils.INations;
   import net.wg.infrastructure.interfaces.IContextItem;
   import net.wg.data.components.UserContextItem;
   import net.wg.gui.events.ContextMenuEvent;


   public class TankCarousel extends TankCarouselMeta implements ITankCarouselMeta, IDAAPIModule, IHelpLayoutComponent
   {
          
      public function TankCarousel() {
         this.filterData = {};
         super();
         dragHitArea = this.dragHitArea1;
         if(leftArrow)
         {
            leftArrow.dispose();
         }
         leftArrow = this.leftArrow1;
         if(rightArrow)
         {
            rightArrow.dispose();
         }
         rightArrow = this.rightArrow1;
         if(renderersMask)
         {
            renderersMask.dispose();
         }
         renderersMask = this.renderersMask1;
         this.nationFilter = this.vehicleFilters.nationFilter;
         this.tankFilter = this.vehicleFilters.tankFilter;
         this.checkBoxToMain = this.vehicleFilters.checkBoxToMain;
         bg = this.bg1;
      }

      public static const FILTERS_CAROUSEL_OFFSET:Number = 15;

      public var vehicleFilters:TankCarouselFilters;

      public var dragHitArea1:MovieClip;

      public var leftArrow1:SoundButton;

      public var rightArrow1:SoundButton;

      public var renderersMask1:MovieClip;

      public var bg1:MovieClip;

      private var filterData:Object;

      private var filterDataInvalid:Boolean = false;

      private var nationFilter:net.wg.gui.components.controls.DropDownImageText;

      private var tankFilter:net.wg.gui.components.controls.DropDownImageText;

      private var checkBoxToMain:CheckBox;

      private var slotPricePrc:Number = 0;

      private var slotPrice:Number = 0;

      private var defSlotPrice:Number = 0;

      private var selectedTankID:String = "";

      private var __availableTanksCount:Number = 0;

      private var __allTanksCount:Number = 0;

      private var __emptySlotsCountForByTank:Number = 0;

      private var firstRun:Boolean = true;

      private var _rendererHelpLayout:DisplayObject;

      private var _isShowHelpLayout:Boolean = false;

      public function onFilterChanged() : void {
         setVehiclesFilterS(this.filterData.nation,this.filterData.tankType,this.filterData.ready);
      }

      public function showHelpLayout() : void {
         var _loc1_:IHelpLayout = null;
         var _loc2_:Object = null;
         if(container)
         {
            this._isShowHelpLayout = true;
            _loc1_ = App.utils.helpLayout;
            _loc2_ = _loc1_.getProps(162,102,Directions.RIGHT,LOBBY_HELP.HANGAR_VEHICLE_CAROUSEL,_defContainerPos + padding.left + padding.right,container.y);
            this._rendererHelpLayout = _loc1_.create(root,_loc2_,this);
         }
      }

      public function closeHelpLayout() : void {
         this._isShowHelpLayout = false;
         var _loc1_:IHelpLayout = App.utils.helpLayout;
         _loc1_.destroy(this._rendererHelpLayout);
      }

      public function normalizeData(param1:Object) : Object {
         var _loc2_:uint = 0;
         var _loc3_:Object = null;
         if(param1)
         {
            if(param1.slots)
            {
               _loc2_ = 0;
               while(_loc2_ < param1.slots.length)
               {
                  _loc3_ = param1.slots[_loc2_];
                  _loc3_.data = _loc3_.data != undefined?_loc3_.data:0;
                  _loc3_.id = _loc3_.id != undefined?_loc3_.id:"id_" + _loc2_;
                  _loc3_.inventoryId = _loc3_.inventoryId != undefined?_loc3_.inventoryId:_loc2_;
                  _loc3_.label = _loc3_.label != undefined?_loc3_.label:"";
                  _loc3_.image = _loc3_.image != undefined?_loc3_.image:"";
                  _loc3_.nation = _loc3_.nation != undefined?_loc3_.nation:1;
                  _loc3_.level = _loc3_.level != undefined?_loc3_.level:1;
                  _loc3_.stat = _loc3_.stat != undefined?_loc3_.stat:"";
                  _loc3_.stateLevel = _loc3_.stateLevel != undefined?_loc3_.stateLevel:"";
                  _loc3_.doubleXPReceived = _loc3_.doubleXPReceived != undefined?_loc3_.doubleXPReceived:0;
                  _loc3_.compactDescr = _loc3_.compactDescr != undefined?_loc3_.compactDescr:0;
                  _loc3_.favorite = _loc3_.favorite != undefined?_loc3_.favorite:false;
                  _loc3_.canSell = _loc3_.canSell != undefined?_loc3_.canSell:false;
                  _loc3_.clanLock = _loc3_.clanLock != undefined?_loc3_.clanLock:-1;
                  _loc3_.elite = _loc3_.elite != undefined?_loc3_.elite:false;
                  _loc3_.premium = _loc3_.premium != undefined?_loc3_.premium:false;
                  _loc3_.tankType = _loc3_.tankType != undefined?_loc3_.tankType:"";
                  _loc3_.exp = _loc3_.exp != undefined?_loc3_.exp:0;
                  _loc3_.current = _loc3_.current != undefined?_loc3_.current:_loc2_;
                  _loc3_.enabled = _loc3_.enabled != undefined?_loc3_.enabled:false;
                  _loc3_.empty = _loc3_.empty != undefined?_loc3_.empty:null;
                  _loc3_.buyTank = _loc3_.buyTank != undefined?_loc3_.buyTank:false;
                  _loc3_.buySlot = _loc3_.buySlot != undefined?_loc3_.buySlot:false;
                  _loc3_.availableSlots = _loc3_.avalibleSlots != undefined?_loc3_.avalibleSlots:0;
                  _loc2_++;
               }
            }
         }
         return param1;
      }

      public function as_vehiclesResponse(param1:Object) : void {
         var _loc2_:Object = this.normalizeData(param1);
         this.setData(_loc2_);
      }

      public function as_setCarouselFilter(param1:Object) : void {
         this.filterData = param1;
         this.filterDataInvalid = true;
         this.updateFiltersData();
      }

      public function as_changeVehicleByCompDescr(param1:Number) : void {
          
      }

      public function as_populate() : void {
          
      }

      public function as_dispose() : void {
         var _loc1_:String = null;
         this.tankFilter.removeEventListener(ListEvent.INDEX_CHANGE,this.onTankDropDownFilterChanged);
         this.checkBoxToMain.removeEventListener(Event.SELECT,this.onFilterCheckBoxChanged);
         this.nationFilter.removeEventListener(ListEvent.INDEX_CHANGE,this.onNatiDropDownFilterChanged);
         App.contextMenuMgr.hide();
         this.vehicleFilters.dispose();
         this.vehicleFilters = null;
         this.dragHitArea1 = null;
         this.leftArrow1 = null;
         this.rightArrow1 = null;
         this.renderersMask1 = null;
         this.bg1 = null;
         for (_loc1_ in this.filterData)
         {
            delete this.filterData[[_loc1_]];
         }
         this.filterData = null;
         this.nationFilter = null;
         this.tankFilter = null;
         this.checkBoxToMain = null;
         this._rendererHelpLayout = null;
         super.dispose();
      }

      public function get availableTanksCount() : Number {
         return this.__availableTanksCount;
      }

      public function set availableTanksCount(param1:Number) : void {
         this.__availableTanksCount = param1;
      }

      public function get allTanksCount() : Number {
         return this.__allTanksCount;
      }

      public function set allTanksCount(param1:Number) : void {
         this.__allTanksCount = param1;
      }

      public function get emptySlotsCountForByTank() : Number {
         return this.__emptySlotsCountForByTank;
      }

      public function set emptySlotsCountForByTank(param1:Number) : void {
         this.__emptySlotsCountForByTank = param1;
      }

      public function get disposed() : Boolean {
         return false;
      }

      override protected function configUI() : void {
         this.initFilters();
         super.configUI();
      }

      override protected function initUIStartPosition() : void {
         this.vehicleFilters.x = contentMargin;
         this.vehicleFilters.y = contentMargin;
         super.initUIStartPosition();
      }

      override protected function updateVisibleSlots() : Number {
         var _loc1_:Number = 0;
         if(this.availableTanksCount != this.allTanksCount)
         {
            _loc1_ = this.vehicleFilters.x + this.vehicleFilters.width + FILTERS_CAROUSEL_OFFSET ^ 0;
         }
         else
         {
            _loc1_ = this.vehicleFilters.x;
            _visibleSlots = (_allowW - (_loc1_ + leftArrow.width + rightArrow.width + CAROUSEL_BUTTON_ARROW_OFFSET * 2 + contentMargin + padding.horizontal)) / slotWidth ^ 0;
            if(_visibleSlots < _totalRenderers)
            {
               _loc1_ = this.vehicleFilters.x + this.vehicleFilters.width + FILTERS_CAROUSEL_OFFSET ^ 0;
            }
         }
         _visibleSlots = (_allowW - (_loc1_ + leftArrow.width + rightArrow.width + CAROUSEL_BUTTON_ARROW_OFFSET * 2 + contentMargin + padding.horizontal)) / slotWidth ^ 0;
         return _visibleSlots;
      }

      override protected function calculateRendererTotal(param1:Number, param2:Number) : uint {
         var _loc3_:Number = 0;
         _loc3_ = this.emptySlotsCountForByTank > 0?this.availableTanksCount + 2:this.availableTanksCount + 1;
         return _loc3_;
      }

      override protected function updateLayout() : void {
         if((initialized) && (_renderers))
         {
            this.showHideFilters(_visibleSlots < _totalRenderers || !(this.availableTanksCount == this.allTanksCount));
            super.updateLayout();
            if(this._isShowHelpLayout)
            {
               this.closeHelpLayout();
               this.showHelpLayout();
            }
         }
      }

      override protected function draw() : void {
         super.draw();
      }

      override protected function refreshData() : void {
         super.refreshData();
         if(this.firstRun)
         {
            scrollToIndex(Math.max(selectedIndex,0));
            this.firstRun = false;
         }
      }

      override protected function populateData(param1:Array) : void {
         var _loc5_:TankCarouselItemRenderer = null;
         var _loc6_:uint = 0;
         var _loc7_:ListData = null;
         var _loc2_:uint = param1.length;
         var _loc3_:uint = _renderers.length;
         var _loc4_:uint = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = getRendererAt(_loc4_) as TankCarouselItemRenderer;
            _loc6_ = _loc4_;
            _loc7_ = new ListData(_loc6_,itemToLabel(param1[_loc4_]),_selectedIndex == _loc6_);
            _loc5_.enabled = _loc4_ < _loc2_ && (enabled);
            _loc5_.dragEnabled = dragEnabled;
            _loc5_.setListData(_loc7_);
            _loc5_.setData(_loc4_ >= _loc2_?this.getEmptyRendererData():param1[_loc4_]);
            _loc5_.validateNow();
            _loc4_++;
         }
         this.updateArrowsState();
      }

      override protected function createdEmptyRenderers() : void {
         var _loc1_:uint = 0;
         var _loc2_:TankCarouselItemRenderer = null;
         var _loc3_:uint = 0;
         var _loc4_:* = NaN;
         var _loc5_:* = 0;
         if(_renderers)
         {
            _loc3_ = getEmptySlotsNumForShow();
            _loc4_ = padding.left + padding.right;
            _loc1_ = _renderers.length;
            _loc5_ = _loc1_;
            while(_loc5_ < _loc1_ + _loc3_)
            {
               _loc2_ = createRenderer(_loc5_) as TankCarouselItemRenderer;
               if(_loc2_ == null)
               {
                  break;
               }
               _loc2_.x = _loc4_ + _loc5_ * (slotImageWidth + _loc4_);
               _loc2_.dragEnabled = dragEnabled;
               _loc2_.setListData(new ListData(_loc5_));
               _loc2_.setData(this.getEmptyRendererData());
               _renderers.push(_loc2_);
               container.addChild(_loc2_ as DisplayObject);
               _loc2_.validateNow();
               _loc5_++;
            }
         }
      }

      override protected function clearEmptyRenderers() : void {
         var _loc1_:IListItemRenderer = null;
         var _loc2_:uint = 0;
         var _loc3_:DisplayObject = null;
         var _loc4_:IDisposable = null;
         var _loc5_:* = 0;
         if(_renderers)
         {
            _loc2_ = _renderers.length;
            _loc5_ = _loc2_-1;
            while(_loc5_ >= 0)
            {
               _loc1_ = getRendererAt(_loc5_);
               if(!(_loc1_ == null) && (TankCarouselItemRenderer(_loc1_).empty))
               {
                  cleanUpRenderer(_loc1_);
                  _loc4_ = _loc1_ as IDisposable;
                  _loc4_.dispose();
                  _loc3_ = _loc1_ as DisplayObject;
                  if(container.contains(_loc3_))
                  {
                     container.removeChild(_loc3_);
                  }
                  _loc1_ = null;
                  _loc3_ = null;
                  _loc4_ = null;
                  _renderers.splice(_loc5_,1);
               }
               _loc5_--;
            }
         }
      }

      override protected function getEmptyRendererData() : Object {
         var _loc1_:Object =
            {
               "data":-1,
               "id":"",
               "inventoryId":-1,
               "label":"",
               "image":"",
               "nation":0,
               "level":0,
               "stat":"",
               "stateLevel":"",
               "doubleXPReceived":0,
               "compactDescr":0,
               "favorite":false,
               "canSell":false,
               "clanLock":-1,
               "elite":false,
               "premium":false,
               "tankType":"",
               "exp":0,
               "current":0,
               "enabled":true,
               "empty":true,
               "buyTank":false,
               "buySlot":false,
               "avalibleSlots":0
            }
         ;
         return _loc1_;
      }

      override protected function handleMouseWheel(param1:MouseEvent) : void {
         if((enabled) && (dragHitArea.hitTestPoint(stage.mouseX,stage.mouseY)) && !isPreDragging)
         {
            super.handleMouseWheel(param1);
         }
      }

      override protected function onItemRollOver(param1:ListEventEx) : void {
         super.onItemRollOver(param1);
         if(isSliding)
         {
            return;
         }
         var _loc2_:Object = param1.itemData;
         if(TankCarouselItemRenderer(param1.itemRenderer).empty)
         {
            return;
         }
         if(_loc2_.buyTank)
         {
            App.toolTipMgr.showComplex(TOOLTIPS.TANKS_CAROUSEL_BUY_VEHICLE);
            return;
         }
         if(_loc2_.buySlot)
         {
            App.toolTipMgr.showComplex(TOOLTIPS.TANKS_CAROUSEL_BUY_SLOT);
            return;
         }
         App.toolTipMgr.showSpecial(Tooltips.CAROUSEL_VEHICLE,null,_loc2_.inventoryId);
      }

      override protected function onItemRollOut(param1:ListEventEx) : void {
         super.onItemRollOut(param1);
         App.toolTipMgr.hide();
      }

      override protected function onItemStartDrag(param1:ListEventEx) : void {
         App.toolTipMgr.hide();
         super.onItemStartDrag(param1);
      }

      override protected function handleItemClick(param1:ButtonEvent) : void {
         App.toolTipMgr.hide();
         if(isMoving)
         {
            isMoving = false;
            return;
         }
         var _loc2_:IListItemRenderer = param1.currentTarget as IListItemRenderer;
         var _loc3_:Number = _loc2_.index;
         if(_loc3_ > dataProvider.length-1)
         {
            return;
         }
         var _loc4_:Object = dataProvider[_loc2_.index];
         var _loc5_:uint = (param1 as ButtonEvent).buttonIdx;
         if(isNaN(_loc3_))
         {
            return;
         }
         if(dispatchItemEvent(param1))
         {
            if(((useRightButton) && (useRightButtonForSelect) || _loc5_ == 0) && !_loc4_.buyTank && !_loc4_.buySlot)
            {
               selectedIndex = _loc3_;
            }
         }
      }

      override protected function onItemClick(param1:ListEventEx) : void {
         var _loc2_:Object = param1.itemData;
         if(_loc2_.empty)
         {
            return;
         }
         if((_loc2_.buyTank) && param1.buttonIdx == 0)
         {
            (param1.itemRenderer as MovieClip).mouseEnabled = false;
            (param1.itemRenderer as MovieClip).mouseChildren = false;
            this.tryBuyTank(_loc2_);
            return;
         }
         if((_loc2_.buySlot) && param1.buttonIdx == 0)
         {
            this.tryBuySlot(_loc2_);
            return;
         }
         if(param1.buttonIdx == 0)
         {
            this.selectItem(_loc2_.id);
         }
         else
         {
            if(param1.buttonIdx == 1 && !_loc2_.buyTank && !_loc2_.buySlot)
            {
               this.showContextMenu(_loc2_);
            }
         }
      }

      override protected function updateArrowsState() : void {
         super.updateArrowsState();
         if(_totalRenderers <= _visibleSlots || !enabled)
         {
            allowDrag = true;
            leftArrow.enabled = false;
            rightArrow.enabled = false;
         }
      }

      private function initFilters() : void {
         this.tankFilter.dataProvider = new DataProvider(getVehicleTypeProviderS());
         this.tankFilter.menuRowCount = this.tankFilter.dataProvider.length;
         var _loc1_:INations = App.utils.nations;
         var _loc2_:Array = _loc1_.getNationsData();
         var _loc3_:Array = [
            {
               "label":MENU.NATIONS_ALL,
               "data":TankCarouselFilters.FILTER_ALL_NATION,
               "icon":"../maps/icons/filters/nations/all.png"
            }
         ];
         var _loc4_:uint = 0;
         while(_loc4_ < _loc2_.length)
         {
            _loc2_[_loc4_]["icon"] = "../maps/icons/filters/nations/" + _loc1_.getNationName(_loc2_[_loc4_]["data"]) + ".png";
            _loc3_.push(_loc2_[_loc4_]);
            _loc4_++;
         }
         this.nationFilter.dataProvider = new DataProvider(_loc3_);
         if(!this.filterData.hasOwnProperty("nation"))
         {
            this.filterData.nation = TankCarouselFilters.FILTER_ALL_NATION;
            this.filterData.tankType = TankCarouselFilters.FILTER_ALL_TYPES;
            this.filterData.ready = false;
            this.tankFilter.selectedIndex = 0;
            this.nationFilter.selectedIndex = 0;
         }
         this.updateFiltersData();
         this.tankFilter.addEventListener(ListEvent.INDEX_CHANGE,this.onTankDropDownFilterChanged);
         this.nationFilter.addEventListener(ListEvent.INDEX_CHANGE,this.onNatiDropDownFilterChanged);
         this.checkBoxToMain.addEventListener(Event.SELECT,this.onFilterCheckBoxChanged);
      }

      private function showHideFilters(param1:Boolean) : void {
         if(!param1)
         {
            leftArrow.x = this.vehicleFilters.x;
            this.vehicleFilters.visible = false;
            this.vehicleFilters.close();
         }
         else
         {
            if(param1)
            {
               leftArrow.x = this.vehicleFilters.x + this.vehicleFilters.width + FILTERS_CAROUSEL_OFFSET ^ 0;
               this.vehicleFilters.visible = true;
            }
         }
         updateDefContainerPos();
         if((container) && (slidingIntervalId == 0) && !isTween)
         {
            container.x = _defContainerPos - currentFirstRenderer * slotWidth;
            renderersMask.x = leftArrow.x + leftArrow.width;
            dragHitArea.x = renderersMask.x;
         }
      }

      private function updateFiltersData() : void {
         var _loc1_:* = NaN;
         var _loc2_:* = NaN;
         if(!initialized)
         {
            invalidate();
            return;
         }
         if(this.filterDataInvalid)
         {
            this.filterDataInvalid = false;
            _loc1_ = 0;
            while(_loc1_ < this.nationFilter.dataProvider.length)
            {
               if(this.nationFilter.dataProvider[_loc1_].data == this.filterData.nation)
               {
                  this.nationFilter.selectedIndex = _loc1_;
                  break;
               }
               _loc1_++;
            }
            _loc2_ = 0;
            while(_loc2_ < this.tankFilter.dataProvider.length)
            {
               if(this.tankFilter.dataProvider[_loc2_].data == this.filterData.tankType)
               {
                  this.tankFilter.selectedIndex = _loc2_;
                  break;
               }
               _loc2_++;
            }
            this.checkBoxToMain.selected = this.filterData.ready;
         }
      }

      private function tryBuyTank(param1:Object) : void {
         buyTankClickS();
      }

      private function tryBuySlot(param1:Object) : void {
         buySlotS();
      }

      private function showContextMenu(param1:Object) : void {
         var _loc2_:String = !param1.favorite?"vehicleCheck":"vehicleUncheck";
         App.contextMenuMgr.show(Vector.<IContextItem>([new UserContextItem("vehicleInfo"),new UserContextItem("vehicleSell",{"enabled":param1.canSell}),new UserContextItem("vehicleResearch"),new UserContextItem(_loc2_)]),this,this.onContectMenuItemSelect,param1);
      }

      private function selectItem(param1:String) : void {
         vehicleChangeS(param1);
      }

      private function setData(param1:Object) : void {
         if(this.availableTanksCount != param1.slots.length)
         {
            tryClearTween();
         }
         this.slotPrice = param1.slotPrice;
         this.defSlotPrice = param1.hasOwnProperty("defSlotPrice")?param1.defSlotPrice:0;
         this.slotPricePrc = param1.hasOwnProperty("actionPrc")?param1.actionPrc:0;
         this.selectedTankID = param1.selectedTankID;
         this.availableTanksCount = param1.slots.length;
         this.emptySlotsCountForByTank = param1.availableSlotsForBuy;
         this.allTanksCount = param1.allTanksCount;
         if(this.allTanksCount == 0)
         {
            visible = false;
            return;
         }
         visible = true;
         var _loc2_:Number = -1;
         var _loc3_:uint = 0;
         while(_loc3_ < param1.slots.length)
         {
            if(param1.slots[_loc3_].id == this.selectedTankID)
            {
               _loc2_ = _loc3_;
               break;
            }
            _loc3_++;
         }
         this.firstRun = selectedIndex != _loc2_?true:false;
         selectedIndex = _loc2_;
         if(this.emptySlotsCountForByTank > 0)
         {
            param1.slots.push(this.getSlotDataForBuyTank());
         }
         param1.slots.push(this.getSlotDataForBuySlot());
         dataProvider = new DataProvider(param1.slots);
         _totalRenderers = this.calculateRendererTotal(0,0);
      }

      private function getSlotDataForBuyTank() : Object {
         var _loc1_:Object =
            {
               "stat":"buyTank",
               "favorite":false,
               "canSell":false,
               "clanLock":-1,
               "elite":false,
               "premium":false,
               "enabled":true,
               "empty":false,
               "buyTank":true,
               "buySlot":false,
               "availableSlots":this.emptySlotsCountForByTank,
               "slotPrice":this.slotPrice
            }
         ;
         return _loc1_;
      }

      private function getSlotDataForBuySlot() : Object {
         var _loc1_:Object =
            {
               "stat":"buySlot",
               "favorite":false,
               "canSell":false,
               "clanLock":-1,
               "elite":false,
               "premium":false,
               "enabled":true,
               "empty":false,
               "buyTank":false,
               "buySlot":true,
               "availableSlots":this.emptySlotsCountForByTank,
               "slotPrice":this.slotPrice,
               "defSlotPrice":this.defSlotPrice,
               "slotPricePrc":this.slotPricePrc
            }
         ;
         return _loc1_;
      }

      private function onFilterCheckBoxChanged(param1:Event) : void {
         this.filterData.ready = this.checkBoxToMain.selected;
         this.onFilterChanged();
      }

      private function onTankDropDownFilterChanged(param1:ListEvent) : void {
         this.filterData.tankType = param1.itemData.data;
         this.onFilterChanged();
      }

      private function onNatiDropDownFilterChanged(param1:ListEvent) : void {
         this.filterData.nation = param1.itemData.data;
         this.onFilterChanged();
      }

      private function onContectMenuItemSelect(param1:ContextMenuEvent) : void {
         var _loc2_:Object = param1.memberItemData;
         switch(param1.id)
         {
            case "vehicleInfo":
               showVehicleInfoS(_loc2_.id);
               break;
            case "vehicleSell":
               vehicleSellS(_loc2_.inventoryId);
               break;
            case "vehicleResearch":
               toResearchS(_loc2_.compactDescr);
               break;
            case "vehicleCheck":
               favoriteVehicleS(_loc2_.id,true);
               break;
            case "vehicleUncheck":
               favoriteVehicleS(_loc2_.id,false);
               break;
         }
      }
   }

}