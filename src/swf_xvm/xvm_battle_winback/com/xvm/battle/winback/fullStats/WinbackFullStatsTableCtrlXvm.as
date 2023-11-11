/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.battle.winback.fullStats
{
    import com.xfw.XfwUtils;

    import net.wg.gui.battle.random.views.stats.components.fullStats.FullStatsTable;
    import net.wg.gui.battle.random.views.stats.components.fullStats.FullStatsTableCtrl;
    import net.wg.gui.battle.random.views.stats.components.fullStats.tableItem.DynamicSquadCtrl;
    import net.wg.gui.battle.random.views.stats.components.fullStats.tableItem.StatsTableItem;
    import net.wg.gui.battle.views.stats.fullStats.StatsTableItemBase;
    import net.wg.infrastructure.base.meta.impl.StatsBaseMeta;

    public class WinbackFullStatsTableCtrlXvm extends FullStatsTableCtrl
    {
        public function WinbackFullStatsTableCtrlXvm(table:FullStatsTable, meta:StatsBaseMeta)
        {
            super(table, meta);
        }

        public function createPlayerStatsItem(col:int, row:int):StatsTableItem
        {
            return new WinbackStatsTableItemXvm(this.table, col, row);
        }

        public function createSquadItem(col:int, row:int):DynamicSquadCtrl
        {
            var table:FullStatsTable = FullStatsTable(this.table)
            var index:int = col * numRows + row;
            return new WinbackDynamicSquadCtrlXvm(
                col == 0,
                table.squadStatusCollection[index],
                table.squadCollection[index],
                table.squadAcceptBt,
                table.squadAddBt,
                table.hitCollection[index],
                table.noSoundCollection[index]);
        }
    }
}
