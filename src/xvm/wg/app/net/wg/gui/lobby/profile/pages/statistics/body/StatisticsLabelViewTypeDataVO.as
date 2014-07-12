package net.wg.gui.lobby.profile.pages.statistics.body
{
   public class StatisticsLabelViewTypeDataVO extends StatisticsLabelDataVO
   {
      
      public function StatisticsLabelViewTypeDataVO(param1:Object) {
         super(param1);
      }
      
      public static const VIEW_TYPE_TABLES:int = 0;
      
      public static const VIEW_TYPE_CHARTS:int = 1;
      
      public var viewType:int;
   }
}
