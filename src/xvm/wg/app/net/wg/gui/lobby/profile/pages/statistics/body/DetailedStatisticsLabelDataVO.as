package net.wg.gui.lobby.profile.pages.statistics.body
{
   import net.wg.gui.lobby.profile.pages.statistics.StatisticsTooltipDataVO;
   
   public class DetailedStatisticsLabelDataVO extends StatisticsLabelDataVO
   {
      
      public function DetailedStatisticsLabelDataVO(param1:Object) {
         super(param1);
      }
      
      public var tooltip:String = "";
      
      public var tooltipData:Object;
      
      private var _tooltipDataVO:StatisticsTooltipDataVO;
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean {
         if(param1 == "data")
         {
            parceData(param2);
            return false;
         }
         if(param1 == "tooltipData" && !(param2 == null))
         {
            this._tooltipDataVO = new StatisticsTooltipDataVO(param2);
            return false;
         }
         return this.hasOwnProperty(param1);
      }
      
      public function get tooltipDataVO() : StatisticsTooltipDataVO {
         return this._tooltipDataVO;
      }
   }
}
