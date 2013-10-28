package net.wg.gui.lobby.profile.pages.statistics
{


   public class AxisPointLevels extends StatisticBarChartAxisPoint
   {
          
      public function AxisPointLevels() {
         super();
      }

      override protected function showToolTip() : void {
         if(tooltip)
         {
            StatisticsChartsUtils.showLevelTooltip(_data,tooltip);
         }
      }

      override public function setData(param1:Object) : void {
         super.setData(param1);
         var _loc2_:StatisticChartInfo = StatisticChartInfo(_data);
         if(_loc2_.yField == -1)
         {
            alpha = 0.27;
            tooltip = PROFILE.SECTION_STATISTICS_CHART_LEVELDISABLED_TOOLTIP;
         }
         else
         {
            tooltip = PROFILE.SECTION_STATISTICS_CHART_LEVEL_TOOLTIP;
            alpha = 1;
         }
      }
   }

}