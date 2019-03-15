/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.battle.epicbattle.fullStats
{
    import com.xfw.*;
    import net.wg.gui.battle.epicBattle.views.stats.components.fullStats.*;
    import net.wg.gui.battle.epicBattle.views.stats.components.fullStats.tableItem.*;

    public class FullStatsTableCtrlXvm extends EpicFullStatsTableCtrl
    {
        public function FullStatsTableCtrlXvm(table:EpicFullStatsTable)
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
