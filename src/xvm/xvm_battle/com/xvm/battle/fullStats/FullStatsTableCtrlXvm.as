/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.battle.fullStats
{
    import com.xfw.*;
    import com.xvm.*;
    import net.wg.gui.battle.random.views.stats.components.fullStats.*;
    import net.wg.gui.battle.random.views.stats.components.fullStats.tableItem.*;
    import net.wg.infrastructure.base.meta.impl.*;

    public class FullStatsTableCtrlXvm extends FullStatsTableCtrl
    {
        public function FullStatsTableCtrlXvm(table:FullStatsTable, meta:FullStatsMeta)
        {
            super(table, meta);
        }

        override public function createPlayerStatsItem(col:int, row:int):StatsTableItem
        {
            var index:int = col * NUM_ITEM_ROWS + row;
            return new StatsTableItemXvm(
                xfw_table.playerNameCollection[index],
                xfw_table.vehicleNameCollection[index],
                xfw_table.fragsCollection[index],
                xfw_table.deadBgCollection[index],
                xfw_table.vehicleTypeCollection[index],
                xfw_table.icoIGRCollection[index],
                xfw_table.vehicleIconCollection[index],
                xfw_table.vehicleLevelCollection[index],
                xfw_table.muteCollection[index],
                xfw_table.speakAnimationCollection[index],
                xfw_table.vehicleActionMarkerCollection[index],
                xfw_table.playerStatusCollection[index]);
        }
    }
}
