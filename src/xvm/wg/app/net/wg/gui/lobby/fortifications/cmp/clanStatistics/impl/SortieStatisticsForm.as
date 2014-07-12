package net.wg.gui.lobby.fortifications.cmp.clanStatistics.impl
{
    import scaleform.clik.core.UIComponent;
    import flash.text.TextField;
    import net.wg.gui.components.common.containers.GroupEx;
    import net.wg.gui.lobby.fortifications.data.ClanStatsVO;
    import scaleform.clik.constants.InvalidationType;
    
    public class SortieStatisticsForm extends UIComponent
    {
        
        public function SortieStatisticsForm() {
            super();
        }
        
        private static var STATS_GROUP_WIDTH:Number = 580;
        
        private static var ICON_STATS_WIDTH_CORRECTION:Number = 3;
        
        public var battlesField:FortStatisticsLDIT;
        
        public var winsField:FortStatisticsLDIT;
        
        public var avgDefresField:FortStatisticsLDIT;
        
        public var battlesLabelTF:TextField;
        
        public var battlesStatsGroup:GroupEx;
        
        public var defresStatsGroup:GroupEx;
        
        private var _model:ClanStatsVO;
        
        override protected function configUI() : void {
            super.configUI();
            this.battlesLabelTF.text = FORTIFICATIONS.FORTCLANSTATISTICSWINDOW_SORTIE_BATTLESHEADER;
            this.battlesStatsGroup.width = STATS_GROUP_WIDTH;
            this.defresStatsGroup.width = STATS_GROUP_WIDTH + ICON_STATS_WIDTH_CORRECTION;
        }
        
        override protected function onDispose() : void {
            this.battlesField.dispose();
            this.winsField.dispose();
            this.avgDefresField.dispose();
            this.battlesField = null;
            this.winsField = null;
            this.avgDefresField = null;
            this.battlesStatsGroup.dispose();
            this.defresStatsGroup.dispose();
            this.battlesStatsGroup = null;
            this.defresStatsGroup = null;
            super.onDispose();
        }
        
        override protected function draw() : void {
            super.draw();
            if((isInvalid(InvalidationType.DATA)) && (this._model))
            {
                this.battlesField.model = this._model.sortieBattlesCount;
                this.winsField.model = this._model.sortieWins;
                this.avgDefresField.model = this._model.sortieAvgDefres;
                this.battlesStatsGroup.dataProvider = this._model.sortieBattlesStats;
                this.defresStatsGroup.dataProvider = this._model.sortieDefresStats;
            }
        }
        
        public function get model() : ClanStatsVO {
            return this._model;
        }
        
        public function set model(param1:ClanStatsVO) : void {
            this._model = param1;
            invalidateData();
        }
    }
}
