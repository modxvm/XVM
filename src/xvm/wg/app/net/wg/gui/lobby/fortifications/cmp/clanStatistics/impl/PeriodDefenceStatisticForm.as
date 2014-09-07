package net.wg.gui.lobby.fortifications.cmp.clanStatistics.impl
{
    public class PeriodDefenceStatisticForm extends FortClanStatisticBaseForm
    {
        
        public function PeriodDefenceStatisticForm()
        {
            super();
        }
        
        override protected function applyData() : void
        {
            battlesField.data = model.periodBattles;
            winsField.data = model.periodWins;
            avgDefresField.data = model.periodAvgDefres;
            battlesStatsGroup.dataProvider = model.periodBattlesStats;
            defresStatsGroup.dataProvider = model.periodDefresStats;
            super.applyData();
        }
    }
}
