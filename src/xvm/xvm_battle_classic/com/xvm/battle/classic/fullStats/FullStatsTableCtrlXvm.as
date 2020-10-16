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
            return new StatsTableItemXvm(_table, col, row);
        }

        public function createSquadItem(col:int, row:int):DynamicSquadCtrl
        {
            var index:int = col * StatsTableItemBase.NUM_ITEM_ROWS + row;
            return new DynamicSquadCtrlXvm(
                col == 0,
                _table.squadStatusCollection[index],
                _table.squadCollection[index],
                _table.squadAcceptBt,
                _table.squadAddBt,
                _table.hitCollection[index],
                _table.noSoundCollection[index]);
        }
    }
}
