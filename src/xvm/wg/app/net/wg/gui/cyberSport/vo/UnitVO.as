package net.wg.gui.cyberSport.vo
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import __AS3__.vec.Vector;


   public class UnitVO extends DAAPIDataClass
   {
          
      public function UnitVO(param1:Object) {
         super(param1);
      }

      private static const SLOTS_FIELD:String = "slots";

      private static const CANDIDATES_FIELD:String = "candidates";

      public var isCommander:Boolean;

      public var candidates:Array;

      public var isFreezed:Boolean;

      public var hasRestrictions:Boolean;

      public var statusValue:Boolean;

      public var readyState:Boolean;

      public var sumLevelsError:Boolean;

      public var sumLevels:String = "";

      public var statusLbl:String = "";

      public var slots:Vector.<UnitSlotVO>;

      public var description:String = "";

      public function get commanderName() : String {
         var _loc2_:UnitSlotVO = null;
         var _loc1_:* = "";
         if(this.slots)
         {
            _loc2_ = this.slots[0];
            if(_loc2_.player)
            {
               _loc1_ = _loc2_.player.userName;
            }
         }
         return _loc1_;
      }

      override protected function onDataWrite(param1:String, param2:Object) : Boolean {
         var _loc3_:Array = null;
         var _loc4_:Object = null;
         var _loc5_:UnitSlotVO = null;
         var _loc6_:Array = null;
         var _loc7_:UnitCandidateVO = null;
         var _loc8_:Object = null;
         if(param1 == SLOTS_FIELD)
         {
            this.slots = new Vector.<UnitSlotVO>();
            _loc3_ = param2 as Array;
            for each (_loc4_ in _loc3_)
            {
               _loc5_ = new UnitSlotVO(_loc4_);
               this.slots.push(_loc5_);
            }
            return false;
         }
         if(param1 == CANDIDATES_FIELD)
         {
            this.candidates = [];
            _loc6_ = param2 as Array;
            for each (_loc8_ in _loc6_)
            {
               _loc7_ = new UnitCandidateVO(_loc8_);
               this.candidates.push(_loc7_);
            }
            return false;
         }
         return true;
      }

      override protected function onDataRead(param1:String, param2:Object) : Boolean {
         var _loc3_:Array = null;
         var _loc4_:UnitSlotVO = null;
         if(param1 == SLOTS_FIELD)
         {
            _loc3_ = [];
            for each (_loc4_ in this.slots)
            {
               _loc3_.push(_loc4_.toHash());
            }
            param2[param1] = _loc3_;
            return false;
         }
         return true;
      }
   }

}