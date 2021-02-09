package net.wg.gui.battle.bob
{
    import net.wg.gui.battle.random.views.BattlePage;
    import net.wg.infrastructure.helpers.statisticsDataController.BattleStatisticDataController;
    import net.wg.gui.battle.bob.data.BobBattleStatisticDataController;
    import net.wg.gui.battle.bob.stats.components.playersPanel.list.BobPlayersPanelListLeft;

    public class BobBattlePage extends BattlePage
    {

        private static const MESSANGER_SWAP_AREA_TOP_OFFSET:Number = 86;

        public function BobBattlePage()
        {
            super();
        }

        override protected function createStatisticsController() : BattleStatisticDataController
        {
            return new BobBattleStatisticDataController(this);
        }

        override protected function updateBattleMessengerArea() : void
        {
            var _loc1_:BobPlayersPanelListLeft = BobPlayersPanelListLeft(playersPanel.listLeft);
            var _loc2_:int = _loc1_.getRenderersVisibleHeight();
            battleMessenger.updateSwapAreaHeight(damagePanel.y - (playersPanel.y + _loc2_) + MESSANGER_SWAP_AREA_TOP_OFFSET);
        }
    }
}
