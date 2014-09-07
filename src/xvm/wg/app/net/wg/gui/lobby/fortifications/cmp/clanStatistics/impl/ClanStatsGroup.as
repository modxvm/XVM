package net.wg.gui.lobby.fortifications.cmp.clanStatistics.impl
{
    import net.wg.gui.components.common.containers.GroupEx;
    import net.wg.data.constants.Linkages;
    import net.wg.gui.components.common.containers.Vertical100PercWidthLayout;
    
    public class ClanStatsGroup extends GroupEx
    {
        
        public function ClanStatsGroup()
        {
            super();
        }
        
        private static var BATTLE_STATS_PADDING:Number = 8;
        
        public static var DEFRES_STATS_PADDING:Number = 7;
        
        private var _verticalPadding:Number = 8;
        
        override protected function configUI() : void
        {
            super.configUI();
            var _loc1_:Class = App.utils.classFactory.getClass(Linkages.CLAN_STAT_DASH_LINE_TEXT_ITEM);
            var _loc2_:Vertical100PercWidthLayout = new Vertical100PercWidthLayout();
            _loc2_.gap = this._verticalPadding;
            layout = _loc2_;
            itemRendererClass = _loc1_;
        }
        
        public function get verticalPadding() : Number
        {
            return this._verticalPadding;
        }
        
        public function set verticalPadding(param1:Number) : void
        {
            this._verticalPadding = param1;
            invalidateLayout();
        }
    }
}
