package net.wg.gui.historicalBattles.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;


   public class BattleListItemVO extends DAAPIDataClass
   {
          
      public function BattleListItemVO(param1:Object) {
         super(param1);
      }

      public var id:Number = -1;

      public var name:String = "";

      public var image:String = "";

      public var isFuture:Boolean = false;

      public var tooltipHeader:String = "";

      public var tooltipDescription:String = "";
   }

}