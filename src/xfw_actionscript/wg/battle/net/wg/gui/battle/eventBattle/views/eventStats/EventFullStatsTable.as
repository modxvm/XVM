package net.wg.gui.battle.eventBattle.views.eventStats
{
    import net.wg.gui.battle.random.views.stats.components.fullStats.FullStatsTable;
    import net.wg.data.constants.generated.BATTLEATLAS;

    public class EventFullStatsTable extends FullStatsTable
    {

        public function EventFullStatsTable()
        {
            super();
        }

        override protected function setTableImages() : void
        {
            background.imageName = BATTLEATLAS.WT_STATS_TABLE_BG;
            leftFrag.imageName = BATTLEATLAS.STATS_TABLE_FRAGS;
            leftPlatoon.imageName = BATTLEATLAS.STATS_TABLE_PLATOON;
            App.utils.commons.flipHorizontal(leftFrag);
            rightFrag.imageName = BATTLEATLAS.STATS_TABLE_FRAGS;
            rightPlatoon.imageName = BATTLEATLAS.STATS_TABLE_PLATOON;
        }
    }
}
