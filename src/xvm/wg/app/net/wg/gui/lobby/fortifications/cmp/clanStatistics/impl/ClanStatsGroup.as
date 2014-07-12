package net.wg.gui.lobby.fortifications.cmp.clanStatistics.impl
{
   import net.wg.gui.components.common.containers.GroupEx;
   import net.wg.data.constants.Linkages;
   import net.wg.gui.components.common.containers.Vertical100PercWidthLayout;
   
   public class ClanStatsGroup extends GroupEx
   {
      
      public function ClanStatsGroup() {
         super();
      }
      
      private static const VERTICAL_GAP:Number = 6;
      
      override protected function configUI() : void {
         super.configUI();
         var _loc1_:Class = App.utils.classFactory.getClass(Linkages.CLAN_STAT_DASH_LINE_TEXT_ITEM);
         var _loc2_:Vertical100PercWidthLayout = new Vertical100PercWidthLayout();
         _loc2_.gap = VERTICAL_GAP;
         layout = _loc2_;
         itemRendererClass = _loc1_;
      }
   }
}
