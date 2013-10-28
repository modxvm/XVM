package net.wg.gui.lobby.profile.pages.statistics
{
   import net.wg.data.managers.IToolTipParams;


   public class LevelBarChartItem extends StatisticBarChartItem
   {
          
      public function LevelBarChartItem() {
         super();
      }

      override protected function configUI() : void {
         super.configUI();
         tooltip = PROFILE.SECTION_STATISTICS_CHART_LEVEL_TOOLTIP;
      }

      override protected function applyValueChange() : void {
         var _loc1_:StatisticChartInfo = StatisticChartInfo(_data);
         if(_loc1_.yField == -1)
         {
            this.visible = false;
         }
         else
         {
            super.applyValueChange();
            this.visible = true;
         }
      }

      override protected function showToolTip(param1:IToolTipParams) : void {
         if(tooltip)
         {
            StatisticsChartsUtils.showLevelTooltip(_data,tooltip);
         }
      }
   }

}