package net.wg.gui.cyberSport.controls
{
   import scaleform.clik.core.UIComponent;
   import net.wg.gui.components.controls.DropDownImageText;
   import net.wg.gui.components.controls.CheckBox;
   import net.wg.gui.cyberSport.vo.VehicleSelectorFilterVO;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ListEvent;
   import flash.events.Event;
   import scaleform.clik.data.DataProvider;
   import net.wg.gui.cyberSport.controls.events.VehicleSelectorFilterEvent;
   import net.wg.utils.INations;


   public class VehicleSelectorFilter extends UIComponent
   {
          
      public function VehicleSelectorFilter() {
         super();
      }

      public static const MODE_USER_VEHICLES:String = "userVehicles";

      public static const MODE_ALL_VEHICLES:String = "allVehicles";

      private static const NATION_FILTER_ALL:int = -1;

      private static const INVALID_MODE:String = "invalidMode";

      public var levelDD:DropDownImageText;

      public var nationDD:DropDownImageText;

      public var vehicleTypeDD:DropDownImageText;

      public var mainCheckBox:CheckBox;

      private var _model:VehicleSelectorFilterVO;

      private var _mode:String = "allVehicles";

      public function setData(param1:VehicleSelectorFilterVO) : void {
         this._model = param1;
         invalidate(InvalidationType.DATA);
      }

      override protected function configUI() : void {
         super.configUI();
         this.nationDD.addEventListener(ListEvent.INDEX_CHANGE,this.onFiltersChanged);
         this.vehicleTypeDD.addEventListener(ListEvent.INDEX_CHANGE,this.onFiltersChanged);
         this.levelDD.addEventListener(ListEvent.INDEX_CHANGE,this.onFiltersChanged);
         this.mainCheckBox.addEventListener(Event.SELECT,this.onFiltersChanged);
         this.initFilters();
      }

      override protected function draw() : void {
         super.draw();
         if((isInvalid(INVALID_MODE)) && (this._mode))
         {
            gotoAndStop(this._mode);
         }
         if((isInvalid(InvalidationType.DATA)) && (this._model))
         {
            this.vehicleTypeDD.dataProvider = new DataProvider(this._model.vehicleTypesDP);
            this.vehicleTypeDD.selectedIndex = 0;
            this.levelDD.dataProvider = new DataProvider(this._model.levelsDP);
            this.levelDD.selectedIndex = 0;
            this.selectNation(this._model.nation);
            this.selectVehicleType(this._model.vehicleType);
            this.selectLevel(this._model.level);
            if(this._mode == MODE_USER_VEHICLES)
            {
               this.mainCheckBox.selected = this._model.isMain;
            }
         }
      }

      private function selectNation(param1:int) : void {
         var _loc2_:Object = null;
         for each (_loc2_ in this.nationDD.dataProvider)
         {
            if(_loc2_.data == param1)
            {
               this.nationDD.selectedIndex = this.nationDD.dataProvider.indexOf(_loc2_);
               return;
            }
         }
      }

      private function selectVehicleType(param1:String) : void {
         var _loc2_:Object = null;
         for each (_loc2_ in this.vehicleTypeDD.dataProvider)
         {
            if(_loc2_.data == param1)
            {
               this.vehicleTypeDD.selectedIndex = this.vehicleTypeDD.dataProvider.indexOf(_loc2_);
               return;
            }
         }
      }

      private function selectLevel(param1:int) : void {
         var _loc2_:Object = null;
         for each (_loc2_ in this.levelDD.dataProvider)
         {
            if(_loc2_.data == param1)
            {
               this.levelDD.selectedIndex = this.levelDD.dataProvider.indexOf(_loc2_);
               return;
            }
         }
      }

      private function onFiltersChanged(param1:Event) : void {
         var _loc2_:Object = this.nationDD.dataProvider.requestItemAt(this.nationDD.selectedIndex);
         var _loc3_:Object = this.vehicleTypeDD.dataProvider.requestItemAt(this.vehicleTypeDD.selectedIndex);
         var _loc4_:Object = this.levelDD.dataProvider.requestItemAt(this.levelDD.selectedIndex);
         var _loc5_:VehicleSelectorFilterEvent = new VehicleSelectorFilterEvent(VehicleSelectorFilterEvent.CHANGE,true);
         _loc5_.nation = _loc2_?_loc2_.data:-1;
         _loc5_.vehicleType = _loc3_?_loc3_.data:null;
         _loc5_.level = _loc4_?_loc4_.data:-1;
         _loc5_.isMain = this.mainCheckBox.selected;
         dispatchEvent(_loc5_);
      }

      private function initFilters() : void {
         var _loc1_:INations = App.utils.nations;
         var _loc2_:Array = _loc1_.getNationsData();
         var _loc3_:Array = [
            {
               "label":MENU.NATIONS_ALL,
               "data":NATION_FILTER_ALL,
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
         this.nationDD.dataProvider = new DataProvider(_loc3_);
         this.nationDD.selectedIndex = 0;
      }

      override protected function onDispose() : void {
         super.onDispose();
         this.nationDD.removeEventListener(ListEvent.INDEX_CHANGE,this.onFiltersChanged);
         this.vehicleTypeDD.removeEventListener(ListEvent.INDEX_CHANGE,this.onFiltersChanged);
         this.levelDD.removeEventListener(ListEvent.INDEX_CHANGE,this.onFiltersChanged);
         this.mainCheckBox.removeEventListener(Event.SELECT,this.onFiltersChanged);
         this.nationDD.dispose();
         this.vehicleTypeDD.dispose();
         this.levelDD.dispose();
         this.mainCheckBox.dispose();
      }

      public function get mode() : String {
         return this._mode;
      }

      public function set mode(param1:String) : void {
         this._mode = param1;
         invalidate(INVALID_MODE);
      }
   }

}