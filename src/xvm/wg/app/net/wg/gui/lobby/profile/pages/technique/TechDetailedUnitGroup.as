package net.wg.gui.lobby.profile.pages.technique
{
    import net.wg.gui.lobby.profile.pages.statistics.detailedStatistics.DetailedStatisticsGroupEx;
    import net.wg.gui.lobby.profile.pages.statistics.body.DetailedStatisticsUnit;
    
    public class TechDetailedUnitGroup extends DetailedStatisticsGroupEx
    {
        
        public function TechDetailedUnitGroup()
        {
            super();
        }
        
        override protected function adjustUnitAt(param1:int) : DetailedStatisticsUnit
        {
            var _loc2_:DetailedStatisticsUnit = super.adjustUnitAt(param1);
            _loc2_.width = 350;
            return _loc2_;
        }
    }
}
