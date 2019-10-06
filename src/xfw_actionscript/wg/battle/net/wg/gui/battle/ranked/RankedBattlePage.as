package net.wg.gui.battle.ranked
{
    import net.wg.gui.battle.random.views.BattlePage;
    import net.wg.infrastructure.helpers.statisticsDataController.BattleStatisticDataController;
    import net.wg.gui.battle.ranked.infrastructure.RankedStatisticsDataController;

    public class RankedBattlePage extends BattlePage
    {

        public function RankedBattlePage()
        {
            super();
        }

        override protected function createStatisticsController() : BattleStatisticDataController
        {
            return new RankedStatisticsDataController(this);
        }

        override protected function get isQuestProgress() : Boolean
        {
            return false;
        }
    }
}
