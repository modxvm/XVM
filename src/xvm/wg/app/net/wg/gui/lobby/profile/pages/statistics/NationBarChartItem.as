package net.wg.gui.lobby.profile.pages.statistics
{
   import net.wg.data.managers.IToolTipParams;
   
   public class NationBarChartItem extends StatisticBarChartItem
   {
      
      public function NationBarChartItem() {
         super();
      }
      
      override protected function configUI() : void {
         super.configUI();
         tooltip = PROFILE.SECTION_STATISTICS_CHART_NATION_TOOLTIP;
      }
      
      override protected function showToolTip(param1:IToolTipParams) : void {
         if(tooltip)
         {
            StatisticsChartsUtils.showNationTooltip(_data,tooltip);
         }
      }
   }
}
