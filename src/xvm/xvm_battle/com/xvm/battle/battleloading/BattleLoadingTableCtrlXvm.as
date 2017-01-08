/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.battle.battleloading
{
    import com.xfw.*;
    import com.xvm.*;
    import net.wg.gui.battle.random.views.stats.components.fullStats.*;
    import net.wg.gui.battle.random.views.stats.components.fullStats.tableItem.*;
    import net.wg.infrastructure.base.meta.impl.*;

    public class BattleLoadingTableCtrlXvm extends BattleLoadingTableCtrl
    {
        public function BattleLoadingTableCtrlXvm(table:BattleLoadingTable, meta:BattleLoadingMeta)
        {
            super(table, meta);
        }

        override public function createPlayerStatsItem(col:int, row:int):StatsTableItem
        {
            var index:int = col * NUM_ITEM_ROWS + row;
            return new StatsTableItemXvm(
                col == 0,
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

        override public function createSquadItem(col:int, row:int):DynamicSquadCtrl
        {
            var index:int = col * NUM_ITEM_ROWS + row;
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
