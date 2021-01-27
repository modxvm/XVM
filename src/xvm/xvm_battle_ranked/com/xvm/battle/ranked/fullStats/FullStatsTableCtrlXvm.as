/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.battle.ranked.fullStats
{
    import com.xfw.*;
    import net.wg.gui.battle.ranked.stats.components.fullStats.*;
    import net.wg.gui.battle.ranked.stats.components.fullStats.tableItem.*;

    public class FullStatsTableCtrlXvm extends FullStatsTableCtrl
    {
        public function FullStatsTableCtrlXvm(table:FullStatsTable)
        {
            super(table);
        }

        public function createPlayerStatsItem(col:int, row:int):StatsTableItem
        {
            return new StatsTableItemXvm(XfwUtils.getPrivateField(this, 'xfw_table'), col, row);
        }
    }
}
