/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.battle.stronghold.fullStats
{
    import com.xfw.XfwUtils;

    import net.wg.gui.battle.random.views.stats.components.fullStats.FullStatsTable;
    import net.wg.gui.battle.random.views.stats.components.fullStats.FullStatsTableCtrl;
    import net.wg.gui.battle.random.views.stats.components.fullStats.tableItem.DynamicSquadCtrl;
    import net.wg.gui.battle.random.views.stats.components.fullStats.tableItem.StatsTableItem;
    import net.wg.gui.battle.views.stats.fullStats.StatsTableItemBase;
    import net.wg.infrastructure.base.meta.impl.StatsBaseMeta;

    public class StrongholdFullStatsTableCtrlXvm extends FullStatsTableCtrl
    {

        public function StrongholdFullStatsTableCtrlXvm(table:FullStatsTable, meta:StatsBaseMeta)
        {
            super(table, meta);
        }

        public function createPlayerStatsItem(col:int, row:int):StatsTableItem
        {
            return new StrongholdStatsTableItemXvm(this.table, col, row);
        }

    }

}