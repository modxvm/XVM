package net.wg.gui.cyberSport.vo
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import __AS3__.vec.Vector;


   public class UnitShortVO extends DAAPIDataClass
   {
          
      public function UnitShortVO(param1:Object) {
         super(param1);
      }

      private static const SLOTS_FIELD:String = "slots";

      public var isFreezed:Boolean;

      public var hasRestrictions:Boolean;

      public var slots:Vector.<UnitSlotVO>;

      public var description:String = "";

      public function get commander() : UnitCandidateVO {
         var _loc2_:UnitSlotVO = null;
         var _loc1_:UnitCandidateVO = null;
         if(this.slots)
         {
            _loc2_ = this.slots[0];
            if(_loc2_.player)
            {
               _loc1_ = _loc2_.player;
            }
         }
         return _loc1_;
      }

      override protected function onDataWrite(param1:String, param2:Object) : Boolean {
         var _loc3_:Array = null;
         var _loc4_:Object = null;
         var _loc5_:UnitSlotVO = null;
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