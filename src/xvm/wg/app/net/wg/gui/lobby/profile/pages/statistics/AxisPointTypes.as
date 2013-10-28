package net.wg.gui.lobby.profile.pages.statistics
{


   public class AxisPointTypes extends StatisticBarChartAxisPoint
   {
          
      public function AxisPointTypes() {
         super();
         tooltip = PROFILE.SECTION_STATISTICS_CHART_TYPE_TOOLTIP;
      }

      override protected function showToolTip() : void {
         if(tooltip)
         {
            StatisticsChartsUtils.showTypeTooltip(_data,tooltip);
         }
      }
   }

}