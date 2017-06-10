/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.battle.fullStats
{
    import com.xfw.*;
    import com.xvm.*;
    import net.wg.gui.battle.ranked.stats.components.fullStats.*;
    import net.wg.gui.battle.ranked.stats.components.fullStats.tableItem.*;
    import net.wg.infrastructure.base.meta.impl.*;

    public class FullStatsTableCtrlXvm extends FullStatsTableCtrl
    {
        public function FullStatsTableCtrlXvm(table:FullStatsTable)
        {
            super(table);
        }

        override public function createPlayerStatsItem(col:int, row:int):StatsTableItem
        {
            return new StatsTableItemXvm(xfw_table, col, row);
        }
    }
}
