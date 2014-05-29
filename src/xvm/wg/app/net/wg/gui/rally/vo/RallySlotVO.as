package net.wg.gui.rally.vo
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.rally.interfaces.IRallySlotVO;
   import net.wg.gui.cyberSport.controls.SettingRosterVO;


   public class RallySlotVO extends DAAPIDataClass implements IRallySlotVO
   {
          
      public function RallySlotVO(param1:Object) {
         super(param1);
      }

      private static const RESTRICTIONS_FIELD:String = "restrictions";

      private static const PLAYER_FIELD:String = "player";

      private static const VEHICLE_FIELD:String = "selectedVehicle";

      private var _rallyIdx:Number;

      private var _isCommanderState:Boolean = false;

      private var _isCurrentUserInSlot:Boolean = false;

      private var _playerStatus:int;

      public var isClosed:Boolean = false;

      public var isFreezed:Boolean = false;

      private var _slotLabel:String = "";

      public var player:RallyCandidateVO;

      private var _canBeTaken:Boolean = false;

      public var compatibleVehiclesCount:int = 0;

      private var _selectedVehicle:VehicleVO = null;

      private var _selectedVehicleLevel:int = 0;

      public var restrictions:Array = null;

      public function get playerObj() : Object {
         return this.player;
      }

      public function get isClosedVal() : Boolean {
         return this.isClosed;
      }

      override protected function onDataWrite(param1:String, param2:Object) : Boolean {
         var _loc3_:Array = null;
         var _loc4_:* = undefined;
         var _loc5_:SettingRosterVO = null;
         if(param1 == RESTRICTIONS_FIELD)
         {
            this.restrictions = [];
            _loc3_ = param2 as Array;
            for each (_loc4_ in _loc3_)
            {
               if((_loc4_) && (_loc4_.hasOwnProperty("vehicle")))
               {
                  this.restrictions.push(_loc4_.vehicle);
               }
               else
               {
                  if(_loc4_)
                  {
                     _loc5_ = new SettingRosterVO(_loc4_);
                     this.restrictions.push(_loc5_);
                  }
                  else
                  {
                     this.restrictions.push(null);
                  }
               }
            }
            return false;
         }
         if(param1 == PLAYER_FIELD)
         {
            this.player = param2?new RallyCandidateVO(param2):null;
            return false;
         }
         if(param1 == VEHICLE_FIELD)
         {
            this._selectedVehicle = param2?new VehicleVO(param2):null;
            return false;
         }
         return true;
      }

      override protected function onDataRead(param1:String, param2:Object) : Boolean {
         var _loc3_:Array = null;
         var _loc4_:* = undefined;
         if(param1 == RESTRICTIONS_FIELD)
         {
            _loc3_ = [];
            for each (_loc4_ in this.restrictions)
            {
               if(_loc4_  is  Number)
               {
                  _loc3_.push(_loc4_);
               }
               else
               {
                  _loc3_.push(_loc4_.toHash());
               }
            }
            param2[param1] = _loc3_;
            return false;
         }
         if(param1 == PLAYER_FIELD)
         {
            param2[param1] = this.player?this.player.toHash():null;
            return false;
         }
         if(param1 == VEHICLE_FIELD)
         {
            param2[param1] = this._selectedVehicle?this._selectedVehicle.toHash():null;
            return false;
         }
         return true;
      }

      public function get playerStatus() : int {
         return this._playerStatus;
      }

      public function set playerStatus(param1:int) : void {
         this._playerStatus = param1;
      }

      public function get selectedVehicle() : VehicleVO {
         return this._selectedVehicle;
      }

      public function set selectedVehicle(param1:VehicleVO) : void {
         this._selectedVehicle = param1;
      }

      public function get selectedVehicleLevel() : int {
         return this._selectedVehicleLevel;
      }

      public function set selectedVehicleLevel(param1:int) : void {
         this._selectedVehicleLevel = param1;
      }

      public function get isCurrentUserInSlot() : Boolean {
         return this._isCurrentUserInSlot;
      }

      public function set isCurrentUserInSlot(param1:Boolean) : void {
         this._isCurrentUserInSlot = param1;
      }

      public function get hasRestrictions() : Boolean {
         return !(this.restrictions[0] == null) || !(this.restrictions[1] == null);
      }

      public function get slotLabel() : String {
         return this._slotLabel;
      }

      public function set slotLabel(param1:String) : void {
         this._slotLabel = param1;
      }

      public function get isCommanderState() : Boolean {
         return this._isCommanderState;
      }

      public function set isCommanderState(param1:Boolean) : void {
         this._isCommanderState = param1;
      }

      public function get canBeTaken() : Boolean {
         return this._canBeTaken;
      }

      public function set canBeTaken(param1:Boolean) : void {
         this._canBeTaken = param1;
      }

      public function get rallyIdx() : Number {
         return this._rallyIdx;
      }

      public function set rallyIdx(param1:Number) : void {
         this._rallyIdx = param1;
      }
   }

}