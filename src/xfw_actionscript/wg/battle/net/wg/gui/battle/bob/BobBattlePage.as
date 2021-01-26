package net.wg.gui.battle.bob
{
    import net.wg.gui.battle.random.views.BattlePage;
    import net.wg.infrastructure.helpers.statisticsDataController.BattleStatisticDataController;
    import net.wg.gui.battle.bob.data.BobBattleStatisticDataController;

    public class BobBattlePage extends BattlePage
    {

        public function BobBattlePage()
        {
            super();
        }

        override protected function createStatisticsController() : BattleStatisticDataController
        {
            return new BobBattleStatisticDataController(this);
        }
    }
}
