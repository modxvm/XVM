package net.wg.gui.lobby.profile.pages.statistics
{
   import net.wg.data.managers.IToolTipParams;


   public class TypeBarChartItem extends StatisticBarChartItem
   {
          
      public function TypeBarChartItem() {
         super();
      }

      override protected function configUI() : void {
         super.configUI();
         tooltip = PROFILE.SECTION_STATISTICS_CHART_TYPE_TOOLTIP;
      }

      override protected function showToolTip(param1:IToolTipParams) : void {
         if(tooltip)
         {
            StatisticsChartsUtils.showTypeTooltip(_data,tooltip);
         }
      }
   }

}