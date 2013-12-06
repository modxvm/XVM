package net.wg.gui.cyberSport.vo
{
   import net.wg.data.daapi.base.DAAPIDataClass;


   public class CSCommandVO extends DAAPIDataClass
   {
          
      public function CSCommandVO(param1:Object) {
         super(param1);
      }

      private static const CREATOR_FIELD:String = "creator";

      public var creator:UnitCandidateVO = null;

      public var cfdUnitID:Number = 0;

      public var unitMgrID:Number = 0;

      public var inBattle:Boolean = false;

      public var commandSize:Number = 7;

      public var playersCount:Number = 0;

      public var rating:String = "";

      public var isFreezed:Boolean = false;

      public var isRestricted:Boolean = false;

      public var peripheryID:Number = 0;

      public var server:String = "";

      public var unit:UnitVO = null;

      override protected function onDataWrite(param1:String, param2:Object) : Boolean {
         var _loc3_:* = true;
         if(param1 == CREATOR_FIELD)
         {
            this.creator = new UnitCandidateVO(param2);
            _loc3_ = false;
         }
         return _loc3_;
      }
   }

}