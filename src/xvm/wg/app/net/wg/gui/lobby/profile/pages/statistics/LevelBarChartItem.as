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
            tweenManager.registerAndLaunch(tweeSpeed,this,{"alpha":0},getQuickSet());
         }
         else
         {
            tweenManager.registerAndLaunch(tweeSpeed,this,{"alpha":1},getQuickSet());
         }
         super.applyValueChange();
      }
      
      override protected function showToolTip(param1:IToolTipParams) : void {
         if(tooltip)
         {
            StatisticsChartsUtils.showLevelTooltip(_data,tooltip);
         }
      }
   }
}
