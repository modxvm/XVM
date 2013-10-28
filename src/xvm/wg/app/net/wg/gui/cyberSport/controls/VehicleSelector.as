package net.wg.gui.cyberSport.controls
{
   import scaleform.clik.core.UIComponent;
   import net.wg.infrastructure.interfaces.IViewStackContent;
   import scaleform.clik.controls.CheckBox;
   import net.wg.gui.components.controls.ScrollingListWithDisRenderers;
   import net.wg.gui.cyberSport.vo.VehicleSelectorItemVO;
   import net.wg.gui.cyberSport.vo.VehicleSelectorFilterVO;
   import scaleform.clik.data.DataProvider;
   import flash.events.Event;
   import net.wg.gui.cyberSport.controls.events.VehicleSelectorItemEvent;
   import net.wg.gui.cyberSport.controls.events.VehicleSelectorEvent;
   import scaleform.clik.constants.InvalidationType;


   public class VehicleSelector extends UIComponent implements IViewStackContent
   {
          
      public function VehicleSelector() {
         this._filtersMode = VehicleSelectorFilter.MODE_ALL_VEHICLES;
         this._localSelectionOverrides = [];
         super();
      }

      private static const INVALID_SELECTION_MODE:String = "invalidSelectionMode";

      private static const INVALID_FILTERS_MODE:String = "invalidFiltersMode";

      public var filtersView:VehicleSelectorFilter;

      public var allCheckBox:CheckBox;

      public var list:ScrollingListWithDisRenderers;

      private var _multiSelection:Boolean = false;

      private var _filtersMode:String;

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
         var _loc2_:* = 0;
         if(!this._isOverridesInitialized)
         {
            for each (_loc2_ in param1)
            {
               this.updateOverride(_loc2_,true);
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
         this.dispatchUpdate();
      }

      override protected function configUI() : void {
         super.configUI();
         this.allCheckBox.label = CYBERSPORT.WINDOW_VEHICLESELECTOR_FILTERS_ALL;
         this.allCheckBox.addEventListener(Event.SELECT,this.onAllCheckBoxChanged);
         this.list.addEventListener(VehicleSelectorItemEvent.SELECT_VEHICLE,this.dispatchUpdate);
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
               this.updateOverride(_loc2_.compactDescriptor,_loc2_.selected);
            }
            this.checkAllSelected();
         }
         dispatchEvent(new VehicleSelectorEvent(VehicleSelectorEvent.SELECTION_CHANGED,this.getSelectedDescriptors(),false,false,param1?param1.forceSelect:false));
      }

      private function getOverride(param1:int) : SelectionInfo {
         var _loc2_:SelectionInfo = null;
         var _loc3_:SelectionInfo = null;
         for each (_loc3_ in this._localSelectionOverrides)
         {
            if(_loc3_.compactDescriptor == param1)
            {
               _loc2_ = _loc3_;
               break;
            }
         }
         return _loc2_;
      }

      private function updateOverride(param1:int, param2:Boolean) : void {
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
            _loc3_ = this.getOverride(_loc2_.compactDescriptor);
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
         }
      }

      public function getSelectedDescriptors() : Array {
         var _loc2_:VehicleSelectorItemVO = null;
         var _loc3_:SelectionInfo = null;
         var _loc1_:Array = [];
         for each (_loc2_ in this.list.dataProvider)
         {
            if(_loc2_.selected)
            {
               _loc1_.push(_loc2_.compactDescriptor);
            }
         }
         for each (_loc3_ in this._localSelectionOverrides)
         {
            if((_loc3_.selected) && _loc1_.indexOf(_loc3_.compactDescriptor) == -1)
            {
               _loc1_.push(_loc3_.compactDescriptor);
            }
         }
         return _loc1_;
      }

      override protected function draw() : void {
         super.draw();
         if(isInvalid(INVALID_SELECTION_MODE))
         {
            this.allCheckBox.visible = this._multiSelection;
         }
         if(isInvalid(INVALID_FILTERS_MODE))
         {
            this.filtersView.mode = this.filtersMode;
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            setActualSize(_width,_height);
            this.list.height = _height - this.list.y;
            setActualScale(1,1);
         }
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
            this.updateOverride(_loc3_.compactDescriptor,_loc3_.selected);
         }
         this.list.dataProvider.invalidate();
         this.dispatchUpdate();
      }

      override public function dispose() : void {
         super.dispose();
         if(this._selectedItemVO)
         {
            this._selectedItemVO.dispose();
            this._selectedItemVO = null;
         }
         this.allCheckBox.removeEventListener(Event.SELECT,this.onAllCheckBoxChanged);
         this.list.removeEventListener(VehicleSelectorItemEvent.SELECT_VEHICLE,this.dispatchUpdate);
         this.allCheckBox.dispose();
         this.filtersView.dispose();
         this.list.dispose();
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
   }

}

   class SelectionInfo extends Object
   {
          
      function SelectionInfo(param1:int, param2:Boolean) {
         super();
         this.compactDescriptor = param1;
         this.selected = param2;
      }

      public var compactDescriptor:int;

      public var selected:Boolean;
   }
