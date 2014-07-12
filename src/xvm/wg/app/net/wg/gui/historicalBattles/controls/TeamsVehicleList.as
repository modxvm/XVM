package net.wg.gui.historicalBattles.controls
{
   import scaleform.clik.core.UIComponent;
   import net.wg.gui.components.controls.ScrollBar;
   import scaleform.clik.events.ListEvent;
   import net.wg.gui.components.controls.CoreListEx;
   import net.wg.gui.historicalBattles.data.VehicleListItemVO;
   import scaleform.clik.data.DataProvider;
   import net.wg.gui.historicalBattles.events.TeamsVehicleListEvent;
   import net.wg.gui.components.controls.ScrollingListEx;
   
   public class TeamsVehicleList extends UIComponent
   {
      
      public function TeamsVehicleList() {
         super();
      }
      
      public var teamListA:SimpleVehicleList;
      
      public var teamListB:SimpleVehicleList;
      
      public var scrollBar:ScrollBar;
      
      private var _selectable:Boolean = true;
      
      override protected function configUI() : void {
         super.configUI();
         this.teamListA.smartScrollBar = true;
         this.teamListB.smartScrollBar = true;
         this.teamListA.addEventListener(ListEvent.INDEX_CHANGE,this.onListItemSelected);
         this.teamListB.addEventListener(ListEvent.INDEX_CHANGE,this.onListItemSelected);
         this.teamListB.enabled = false;
      }
      
      override protected function onDispose() : void {
         this.teamListA.removeEventListener(ListEvent.INDEX_CHANGE,this.onListItemSelected);
         this.teamListB.removeEventListener(ListEvent.INDEX_CHANGE,this.onListItemSelected);
         this.teamListA.dispose();
         this.teamListB.dispose();
         this.teamListA = null;
         this.teamListB = null;
         this.scrollBar.dispose();
         this.scrollBar = null;
         super.onDispose();
      }
      
      override protected function draw() : void {
         super.draw();
      }
      
      public function setTeamsData(param1:Array, param2:Array) : void {
         var _loc3_:int = Math.max(param1.length,param2.length);
         this.teamListA.dataProvider = this.generateListDP(param1,_loc3_);
         this.teamListB.dataProvider = this.generateListDP(param2,_loc3_);
      }
      
      public function selectVehicleByCD(param1:int) : Boolean {
         var _loc3_:CoreListEx = null;
         var _loc4_:VehicleListItemVO = null;
         var _loc2_:Array = [this.teamListA,this.teamListB];
         for each(_loc3_ in _loc2_)
         {
            for each(_loc4_ in _loc3_.dataProvider)
            {
               if((_loc4_) && _loc4_.intCD == param1)
               {
                  if(_loc4_.enabled)
                  {
                     _loc3_.selectedIndex = _loc3_.dataProvider.indexOf(_loc4_);
                     return true;
                  }
                  break;
               }
            }
         }
         this.teamListA.selectedIndex = -1;
         this.teamListB.selectedIndex = -1;
         return false;
      }
      
      private function generateListDP(param1:Array, param2:int) : DataProvider {
         var _loc4_:VehicleListItemVO = null;
         var _loc3_:Array = [];
         var _loc5_:* = 0;
         while(_loc5_ < param1.length)
         {
            _loc4_ = new VehicleListItemVO(param1[_loc5_]);
            _loc4_.selectable = this._selectable;
            _loc3_.push(_loc4_);
            _loc5_++;
         }
         while(_loc5_ < param2)
         {
            _loc3_.push(null);
            _loc5_++;
         }
         return new DataProvider(_loc3_);
      }
      
      private function updateListSelectable() : void {
         var _loc2_:CoreListEx = null;
         var _loc3_:VehicleListItemVO = null;
         var _loc1_:Array = [this.teamListA,this.teamListB];
         for each(_loc2_ in _loc1_)
         {
            for each(_loc3_ in _loc2_.dataProvider)
            {
               if(_loc3_)
               {
                  _loc3_.selectable = this._selectable;
               }
            }
         }
         this.teamListA.invalidateData();
         this.teamListB.invalidateData();
      }
      
      private function onListItemSelected(param1:ListEvent) : void {
         if(param1.index == -1)
         {
            if(this.teamListA.selectedIndex == -1 && this.teamListB.selectedIndex == -1)
            {
               dispatchEvent(new TeamsVehicleListEvent(TeamsVehicleListEvent.VEHICLE_SELECTED,-1));
            }
            return;
         }
         var _loc2_:ScrollingListEx = param1.currentTarget as ScrollingListEx;
         var _loc3_:ScrollingListEx = _loc2_ == this.teamListA?this.teamListB:this.teamListA;
         _loc3_.selectedIndex = -1;
         var _loc4_:VehicleListItemVO = _loc2_.dataProvider.requestItemAt(_loc2_.selectedIndex) as VehicleListItemVO;
         dispatchEvent(new TeamsVehicleListEvent(TeamsVehicleListEvent.VEHICLE_SELECTED,_loc4_.intCD));
      }
      
      public function get selectable() : Boolean {
         return this._selectable;
      }
      
      public function set selectable(param1:Boolean) : void {
         this._selectable = param1;
         this.updateListSelectable();
      }
   }
}
