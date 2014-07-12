package net.wg.gui.lobby.profile.pages.statistics.body
{
   import net.wg.gui.lobby.profile.components.ProfileDashLineTextItem;
   import net.wg.gui.lobby.profile.pages.statistics.StatisticsTooltipDataVO;
   import net.wg.data.managers.impl.ToolTipParams;
   
   public class StatisticsDashLineTextItemIRenderer extends ProfileDashLineTextItem
   {
      
      public function StatisticsDashLineTextItemIRenderer() {
         super();
      }
      
      override protected function configUI() : void {
         super.configUI();
         width = 280;
      }
      
      public function set data(param1:DetailedStatisticsLabelDataVO) : void {
         var _loc2_:StatisticsTooltipDataVO = null;
         if(param1)
         {
            receiveAndSetValue(param1.data,15131353);
            label = param1.label;
            tooltip = param1.tooltip;
            _loc2_ = param1.tooltipDataVO;
            if(_loc2_)
            {
               toolTipParams = new ToolTipParams(_loc2_.header,_loc2_.body,_loc2_.note);
            }
            else
            {
               toolTipParams = null;
            }
            visible = true;
         }
         else
         {
            visible = false;
         }
      }
      
      override protected function applySizeChanges() : void {
         super.applySizeChanges();
         dashLine.validateNow();
      }
   }
}
