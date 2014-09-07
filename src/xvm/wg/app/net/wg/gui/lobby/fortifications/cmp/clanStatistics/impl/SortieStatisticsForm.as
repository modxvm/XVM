package net.wg.gui.lobby.fortifications.cmp.clanStatistics.impl
{
    import flash.text.TextField;
    
    public class SortieStatisticsForm extends FortClanStatisticBaseForm
    {
        
        public function SortieStatisticsForm()
        {
            super();
        }
        
        public var battlesLabelTF:TextField;
        
        override protected function configUI() : void
        {
            super.configUI();
            this.battlesLabelTF.text = FORTIFICATIONS.FORTCLANSTATISTICSWINDOW_SORTIE_BATTLESHEADER;
        }
        
        override protected function onDispose() : void
        {
            this.battlesLabelTF = null;
            super.onDispose();
        }
        
        override protected function applyData() : void
        {
            battlesField.data = model.sortieBattlesCount;
            winsField.data = model.sortieWins;
            avgDefresField.data = model.sortieAvgDefres;
            battlesStatsGroup.dataProvider = model.sortieBattlesStats;
            defresStatsGroup.dataProvider = model.sortieDefresStats;
            super.applyData();
        }
    }
}
