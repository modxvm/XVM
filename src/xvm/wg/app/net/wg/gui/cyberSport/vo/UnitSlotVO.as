package net.wg.gui.cyberSport.vo
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.cyberSport.controls.SettingRosterVO;


   public class UnitSlotVO extends DAAPIDataClass
   {
          
      public function UnitSlotVO(param1:Object) {
         super(param1);
      }

      private static const RESTRICTIONS_FIELD:String = "restrictions";

      private static const PLAYER_FIELD:String = "player";

      public var unitIdx:Number;

      public var isCommanderState:Boolean = false;

      public var isCurrentUserInSlot:Boolean = false;

      public var playerStatus:int;

      public var isClosed:Boolean = false;

      public var isFreezed:Boolean = false;

      public var slotLabel:String = "";

      public var player:UnitCandidateVO;

      public var canBeTaken:Boolean = false;

      public var compatibleVehiclesCount:int = 0;

      public var selectedVehicleCD:int = -1;

      public var selectedVehicleLevel:int = 0;

      public var restrictions:Array = null;

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
            this.player = param2?new UnitCandidateVO(param2):null;
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
         return true;
      }
   }

}