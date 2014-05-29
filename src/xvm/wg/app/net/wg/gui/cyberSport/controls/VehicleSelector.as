package net.wg.gui.cyberSport.controls
{
   import scaleform.clik.core.UIComponent;
   import net.wg.infrastructure.interfaces.IViewStackContent;
   import scaleform.clik.controls.CheckBox;
   import net.wg.gui.components.advanced.SortableHeaderButtonBar;
   import net.wg.gui.components.controls.ScrollingListWithDisRenderers;
   import net.wg.gui.cyberSport.vo.VehicleSelectorItemVO;
   import net.wg.gui.cyberSport.vo.VehicleSelectorFilterVO;
   import net.wg.gui.rally.vo.VehicleVO;
   import scaleform.clik.data.DataProvider;
   import flash.display.InteractiveObject;
   import flash.events.Event;
   import net.wg.gui.cyberSport.controls.events.VehicleSelectorItemEvent;
   import net.wg.gui.events.SortingEvent;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.interfaces.IDataProvider;
   import net.wg.gui.components.advanced.SortingButtonInfo;
   import net.wg.data.constants.SortingInfo;
   import net.wg.gui.cyberSport.controls.events.VehicleSelectorEvent;
   import net.wg.gui.components.advanced.SortingButton;


   public class VehicleSelector extends UIComponent implements IViewStackContent
   {
          
      public function VehicleSelector() {
         this._localSelectionOverrides = [];
         super();
      }

      private static const INVALID_SELECTION_MODE:String = "invalidSelectionMode";

      private static const INVALID_FILTERS_MODE:String = "invalidFiltersMode";

      public var filtersView:VehicleSelectorFilter;

      public var allCheckBox:CheckBox;

      public var header:SortableHeaderButtonBar;

      public var list:ScrollingListWithDisRenderers;

      private var _multiSelection:Boolean = false;

      private var _filtersMode:String = "allVehicles";

      private var _selectedItemVO:VehicleSelectorItemVO;

      private var _localSelectionOverrides:Array;

      private var _ignoreAllCheckBoxChange:Boolean = false;

      private var _isOverridesInitialized:Boolean = false;

      public function setFiltersData(param1:VehicleSelectorFilterVO) : void {
         this.filtersView.setData(param1);
      }

      public function update(param1:Object) : void {
         this.setListItems(param1 as Array);
      }

      public function setupSelectionOverrides(param1:Array) : void {
         var _loc2_:Object = null;
         if(!this._isOverridesInitialized)
         {
            for each (_loc2_ in param1)
            {
               this.updateOverride(new VehicleVO(_loc2_),true);
            }
            this._isOverridesInitialized = true;
         }
      }

      public function setListItems(param1:Array) : void {
         if(this.list.dataProvider)
         {
            if(this._selectedItemVO)
            {
               this._selectedItemVO = null;
            }
            this.list.dataProvider.cleanUp();
            this.list.dataProvider = null;
         }
         this.applyOverrides(param1);
         this.list.dataProvider = new DataProvider(param1);
         this.header.selectedIndex = this.multiSelection?3:2;
         this.list.sortByField("level",false);
         this.dispatchUpdate();
      }

      public function getSelectedDescriptors() : Array {
         var _loc2_:VehicleSelectorItemVO = null;
         var _loc3_:SelectionInfo = null;
         var _loc1_:Array = [];
         for each (_loc2_ in this.list.dataProvider)
         {
            if(_loc2_.selected)
            {
               _loc1_.push(_loc2_.vehicle.intCD);
            }
         }
         for each (_loc3_ in this._localSelectionOverrides)
         {
            if((_loc3_.selected) && _loc1_.indexOf(_loc3_.vehicle.intCD) == -1)
            {
               _loc1_.push(_loc3_.vehicle.intCD);
            }
         }
         return _loc1_;
      }

      public function getSelectedVehicles() : Array {
         var _loc3_:VehicleSelectorItemVO = null;
         var _loc4_:SelectionInfo = null;
         var _loc1_:Array = [];
         var _loc2_:Array = [];
         for each (_loc3_ in this.list.dataProvider)
         {
            if(_loc3_.selected)
            {
               _loc1_.push(_loc3_.vehicle);
               _loc2_.push(_loc3_.vehicle.intCD);
            }
         }
         for each (_loc4_ in this._localSelectionOverrides)
         {
            if((_loc4_.selected) && _loc2_.indexOf(_loc4_.vehicle.intCD) == -1)
            {
               _loc1_.push(_loc4_.vehicle);
            }
         }
         return _loc1_;
      }

      public function getComponentForFocus() : InteractiveObject {
         return null;
      }

      public function get multiSelection() : Boolean {
         return this._multiSelection;
      }

      public function set multiSelection(param1:Boolean) : void {
         this._multiSelection = param1;
         invalidate(INVALID_SELECTION_MODE);
      }

      public function get filtersMode() : String {
         return this._filtersMode;
      }

      public function set filtersMode(param1:String) : void {
         this._filtersMode = param1;
         invalidate(INVALID_FILTERS_MODE);
      }

      public function get isUserVehiclesMode() : Boolean {
         return this._filtersMode == VehicleSelectorFilter.MODE_USER_VEHICLES;
      }

      override protected function configUI() : void {
         super.configUI();
         this.allCheckBox.label = CYBERSPORT.WINDOW_VEHICLESELECTOR_FILTERS_ALL;
         this.allCheckBox.addEventListener(Event.SELECT,this.onAllCheckBoxChanged);
         this.list.addEventListener(VehicleSelectorItemEvent.SELECT_VEHICLE,this.dispatchUpdate);
         this.header.addEventListener(SortingEvent.SORT_DIRECTION_CHANGED,this.sortingChangedHandler,false,0,true);
      }

      override protected function draw() : void {
         super.draw();
         if(isInvalid(INVALID_SELECTION_MODE))
         {
            this.header.dataProvider = this.getHeaderDP();
            this.list.columnsData = this.header.dataProvider;
            this.allCheckBox.visible = this._multiSelection;
         }
         if(isInvalid(INVALID_FILTERS_MODE))
         {
            this.filtersView.mode = this.filtersMode;
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            setActualSize(_width,_height);
            this.list.height = _height - this.list.y - (this._multiSelection?35:0);
            setActualScale(1,1);
         }
      }

      override protected function onDispose() : void {
         super.onDispose();
         this.allCheckBox.removeEventListener(Event.SELECT,this.onAllCheckBoxChanged);
         this.list.removeEventListener(VehicleSelectorItemEvent.SELECT_VEHICLE,this.dispatchUpdate);
         this.allCheckBox.dispose();
         this.filtersView.dispose();
         this.list.dispose();
         if(this._selectedItemVO)
         {
            this._selectedItemVO.dispose();
            this._selectedItemVO = null;
         }
      }

      private function getOverride(param1:VehicleVO) : SelectionInfo {
         var _loc2_:SelectionInfo = null;
         var _loc3_:SelectionInfo = null;
         for each (_loc3_ in this._localSelectionOverrides)
         {
            if(_loc3_.vehicle.intCD == param1.intCD)
            {
               _loc2_ = _loc3_;
               break;
            }
         }
         return _loc2_;
      }

      private function updateOverride(param1:VehicleVO, param2:Boolean) : void {
         var _loc3_:SelectionInfo = this.getOverride(param1);
         if(_loc3_)
         {
            _loc3_.selected = param2;
         }
         else
         {
            _loc3_ = new SelectionInfo(param1,param2);
            this._localSelectionOverrides.push(_loc3_);
         }
      }

      private function applyOverrides(param1:Array) : void {
         var _loc2_:VehicleSelectorItemVO = null;
         var _loc3_:SelectionInfo = null;
         for each (_loc2_ in param1)
         {
            _loc3_ = this.getOverride(_loc2_.vehicle);
            if(_loc3_)
            {
               _loc2_.selected = _loc3_.selected;
            }
         }
      }

      private function checkAllSelected() : void {
         var _loc3_:VehicleSelectorItemVO = null;
         var _loc4_:* = false;
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         for each (_loc3_ in this.list.dataProvider)
         {
            _loc1_ = _loc1_ + int(_loc3_.enabled);
            _loc2_ = _loc2_ + int(_loc3_.selected);
         }
         _loc4_ = _loc1_ > 0 && _loc1_ == _loc2_;
         if(this.allCheckBox.selected != _loc4_)
         {
            this._ignoreAllCheckBoxChange = true;
            this.allCheckBox.selected = _loc4_;
            this._ignoreAllCheckBoxChange = false;
         }
      }

      private function getHeaderDP() : IDataProvider {
         var _loc5_:SortingButtonInfo = null;
         var _loc1_:* = "../maps/icons/buttons/tab_sort_button/ascProfileSortArrow.png";
         var _loc2_:* = "../maps/icons/buttons/tab_sort_button/descProfileSortArrow.png";
         var _loc3_:Number = 30;
         var _loc4_:Array = [];
         if(this.multiSelection)
         {
            _loc5_ = new SortingButtonInfo();
            _loc5_.iconId = "selected";
            _loc5_.iconSource = "../maps/icons/buttons/tab_sort_button/ok.png";
            _loc5_.buttonWidth = 39;
            _loc5_.defaultSortDirection = SortingInfo.ASCENDING_SORT;
            _loc5_.sortOrder = 4;
            _loc4_.push(_loc5_);
         }
         _loc5_ = new SortingButtonInfo();
         _loc5_.iconId = "nationID";
         _loc5_.iconSource = "../maps/icons/filters/nations/all.png";
         _loc5_.buttonWidth = this.multiSelection?29:39;
         _loc5_.defaultSortDirection = SortingInfo.ASCENDING_SORT;
         _loc5_.sortOrder = 0;
         _loc5_.toolTip = TOOLTIPS.VEHICLESELECTOR_SORTING_NATION;
         _loc4_.push(_loc5_);
         _loc5_ = new SortingButtonInfo();
         _loc5_.iconId = "typeIndex";
         _loc5_.iconSource = "../maps/icons/filters/tanks/all.png";
         _loc5_.buttonWidth = 40;
         _loc5_.defaultSortDirection = SortingInfo.ASCENDING_SORT;
         _loc5_.sortOrder = 1;
         _loc5_.toolTip = TOOLTIPS.VEHICLESELECTOR_SORTING_VEHTYPE;
         _loc4_.push(_loc5_);
         _loc5_ = new SortingButtonInfo();
         _loc5_.iconId = "level";
         _loc5_.iconSource = "../maps/icons/buttons/tab_sort_button/level.png";
         _loc5_.buttonWidth = 28;
         _loc5_.defaultSortDirection = SortingInfo.DESCENDING_SORT;
         _loc5_.sortOrder = 2;
         _loc5_.toolTip = TOOLTIPS.VEHICLESELECTOR_SORTING_VEHLVL;
         _loc4_.push(_loc5_);
         _loc5_ = new SortingButtonInfo();
         _loc5_.iconId = "shortUserName";
         _loc5_.label = PROFILE.SECTION_TECHNIQUE_BUTTONBAR_VEHICLENAME;
         _loc5_.buttonWidth = this.multiSelection?197:226;
         _loc5_.defaultSortDirection = SortingInfo.ASCENDING_SORT;
         _loc5_.sortOrder = 3;
         _loc5_.toolTip = TOOLTIPS.VEHICLESELECTOR_SORTING_VEHNAME;
         _loc5_.dataSortType = Array.CASEINSENSITIVE;
         _loc4_.push(_loc5_);
         var _loc6_:* = 0;
         while(_loc6_ < _loc4_.length)
         {
            _loc5_ = _loc4_[_loc6_];
            _loc5_.ascendingIconSource = _loc1_;
            _loc5_.descendingIconSource = _loc2_;
            _loc5_.buttonHeight = _loc3_;
            _loc5_.enabled = true;
            _loc6_++;
         }
         return new DataProvider(_loc4_);
      }

      private function dispatchUpdate(param1:VehicleSelectorItemEvent=null) : void {
         var _loc2_:VehicleSelectorItemVO = param1?param1.data:null;
         if(!this._multiSelection)
         {
            if(_loc2_)
            {
               if((this._selectedItemVO) && !(this._selectedItemVO.compactDescriptor == _loc2_.compactDescriptor))
               {
                  this._selectedItemVO.selected = false;
               }
               this._selectedItemVO = _loc2_;
            }
         }
         else
         {
            if(_loc2_)
            {
               this.updateOverride(_loc2_.vehicle,_loc2_.selected);
            }
            this.checkAllSelected();
         }
         dispatchEvent(new VehicleSelectorEvent(VehicleSelectorEvent.SELECTION_CHANGED,this.getSelectedDescriptors(),this.getSelectedVehicles(),false,false,param1?param1.forceSelect:false));
      }

      private function onAllCheckBoxChanged(param1:Event) : void {
         var _loc3_:VehicleSelectorItemVO = null;
         if(this._ignoreAllCheckBoxChange)
         {
            this._ignoreAllCheckBoxChange = false;
            return;
         }
         var _loc2_:Boolean = this.allCheckBox.selected;
         for each (_loc3_ in this.list.dataProvider)
         {
            _loc3_.selected = (_loc2_) && (_loc3_.enabled);
            this.updateOverride(_loc3_.vehicle,_loc3_.selected);
         }
         this.list.dataProvider.invalidate();
         this.dispatchUpdate();
      }

      private function sortingChangedHandler(param1:Event) : void {
         param1.stopImmediatePropagation();
         var _loc2_:SortingButton = SortingButton(param1.target);
         if(_loc2_.sortDirection != SortingInfo.WITHOUT_SORT)
         {
            this.list.sortByField(_loc2_.id,_loc2_.sortDirection == SortingInfo.ASCENDING_SORT);
         }
      }
   }

}   import net.wg.gui.rally.vo.VehicleVO;


   class SelectionInfo extends Object
   {
          
      function SelectionInfo(param1:VehicleVO, param2:Boolean) {
         super();
         this.vehicle = param1;
         this.selected = param2;
      }

      public var vehicle:VehicleVO;

      public var selected:Boolean;
   }
