/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.battle.classic.fullStats
{
    import com.xfw.XfwUtils;
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
            var table:FullStatsTable = XfwUtils.getPrivateField(this, "xfw_table");
            return new StatsTableItemXvm(table, col, row);
        }

        public function createSquadItem(col:int, row:int):DynamicSquadCtrl
        {
            var table:FullStatsTable = XfwUtils.getPrivateField(this, "xfw_table");
            var index:int = col * StatsTableItemBase.NUM_ITEM_ROWS + row;

            return new DynamicSquadCtrlXvm(
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
