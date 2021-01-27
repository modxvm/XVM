/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.battle.classic.fullStats
{
    import com.xfw.*;
    import net.wg.gui.battle.random.views.stats.components.fullStats.*;
    import net.wg.gui.battle.random.views.stats.components.fullStats.tableItem.*;
    import net.wg.gui.battle.views.stats.fullStats.*;
    import net.wg.infrastructure.base.meta.impl.*;

    public class FullStatsTableCtrlXvm extends FullStatsTableCtrl
    {
        public function FullStatsTableCtrlXvm(table:FullStatsTable, meta:StatsBaseMeta)
        {
            super(table, meta);
        }

        public function createPlayerStatsItem(col:int, row:int):StatsTableItem
        {
            return new StatsTableItemXvm(xfw_table, col, row);
        }

        public function createSquadItem(col:int, row:int):DynamicSquadCtrl
        {
            var index:int = col * StatsTableItemBase.NUM_ITEM_ROWS + row;
            return new DynamicSquadCtrlXvm(
                col == 0,
                xfw_table.squadStatusCollection[index],
                xfw_table.squadCollection[index],
                xfw_table.squadAcceptBt,
                xfw_table.squadAddBt,
                xfw_table.hitCollection[index],
                xfw_table.noSoundCollection[index]);
        }
    }
}
