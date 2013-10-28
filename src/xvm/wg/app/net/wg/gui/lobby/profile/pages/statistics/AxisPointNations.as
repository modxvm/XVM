package net.wg.gui.lobby.profile.pages.statistics
{


   public class AxisPointNations extends StatisticBarChartAxisPoint
   {
          
      public function AxisPointNations() {
         super();
         tooltip = PROFILE.SECTION_STATISTICS_CHART_NATION_TOOLTIP;
      }

      override protected function showToolTip() : void {
         if(tooltip)
         {
            StatisticsChartsUtils.showNationTooltip(_data,tooltip);
         }
      }
   }

}