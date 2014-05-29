package net.wg.gui.lobby.fortifications.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;


   public class ClanStatsVO extends DAAPIDataClass
   {
          
      public function ClanStatsVO(param1:Object) {
         this.sortieBattlesStats = [];
         this.sortieDefresStats = [];
         super(param1);
      }

      private static const FIELD_SORTIE_BATTLES_COUNT:String = "sortieBattlesCount";

      private static const FIELD_SORTIE_WINS:String = "sortieWins";

      private static const FIELD_SORTIE_AVG_DEFRES:String = "sortieAvgDefres";

      private static const FIELD_SORTIE_BATTLES_STATS:String = "sortieBattlesStats";

      private static const FIELD_SORTIE_DEFRES_STATS:String = "sortieDefresStats";

      public var clanName:String = "";

      public var sortieBattlesCount:ClanStatItemVO;

      public var sortieWins:ClanStatItemVO;

      public var sortieAvgDefres:ClanStatItemVO;

      public var sortieBattlesStats:Array;

      public var sortieDefresStats:Array;

      override protected function onDataWrite(param1:String, param2:Object) : Boolean {
         var _loc3_:ClanStatItemVO = null;
         var _loc4_:Array = null;
         var _loc5_:Object = null;
         switch(param1)
         {
            case FIELD_SORTIE_BATTLES_COUNT:
            case FIELD_SORTIE_WINS:
            case FIELD_SORTIE_AVG_DEFRES:
               _loc3_ = new ClanStatItemVO(param2);
               this[param1] = _loc3_;
               return false;
            case FIELD_SORTIE_BATTLES_STATS:
            case FIELD_SORTIE_DEFRES_STATS:
               _loc4_ = param2 as Array;
               for each (_loc5_ in _loc4_)
               {
                  (this[param1] as Array).push(new ClanStatItemVO(_loc5_));
               }
               return false;
            default:
               return true;
         }
      }

      override protected function onDispose() : void {
         var _loc2_:ClanStatItemVO = null;
         var _loc3_:Array = null;
         if(this.sortieBattlesCount)
         {
            this.sortieBattlesCount.dispose();
            this.sortieBattlesCount = null;
         }
         if(this.sortieWins)
         {
            this.sortieWins.dispose();
            this.sortieWins = null;
         }
         if(this.sortieAvgDefres)
         {
            this.sortieAvgDefres.dispose();
            this.sortieAvgDefres = null;
         }
         var _loc1_:Array = [this.sortieBattlesStats,this.sortieDefresStats];
         for each (_loc3_ in _loc1_)
         {
            if(_loc3_)
            {
               for each (_loc2_ in _loc3_)
               {
                  if(_loc2_)
                  {
                     _loc2_.dispose();
                  }
               }
               _loc3_.splice(0);
            }
         }
         this.sortieBattlesStats = null;
         this.sortieDefresStats = null;
         super.onDispose();
      }
   }

}