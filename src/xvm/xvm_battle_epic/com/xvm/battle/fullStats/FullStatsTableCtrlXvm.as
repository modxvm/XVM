/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * http://www.modxvm.com/
 */
package com.xvm.battle.fullStats
{
    import com.xfw.*;
    import net.wg.gui.battle.epicRandom.views.stats.components.fullStats.*;
    import net.wg.gui.battle.epicRandom.views.stats.components.fullStats.tableItem.*;

    public class FullStatsTableCtrlXvm extends EpicRandomFullStatsTableCtrl
    {
        public function FullStatsTableCtrlXvm(table:EpicRandomFullStatsTable)
        {
            super(table);
        }

        // TODO:EPIC
        /*
        override public function createPlayerStatsItem(col:int, row:int):statsta StatsTableItem
        {
            return new StatsTableItemXvm(xfw_table, col, row);
        }
        */
    }
}
