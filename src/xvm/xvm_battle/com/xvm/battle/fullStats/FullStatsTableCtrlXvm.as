/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.battle.fullStats
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xfw.events.*;
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

        override public function updateOrder(param1:Vector.<Number>, param2:Boolean):void
        {
            var old_order:Vector.<Number> = param2 ? rightOrder.concat() : leftOrder.concat();
            super.updateOrder(param1, param2);
            var new_order:Vector.<Number> = param2 ? rightOrder : leftOrder;
            var len:int = new_order.length;
            for (var i:int = 0; i < len; ++i)
            {
                var vehicleID:Number = new_order[i];
                if (old_order[i] != vehicleID)
                {
                    Xvm.dispatchEvent(new IntEvent(StatsTableItemXvm.ORDER_CHANGED, vehicleID));
                }
            }
        }
    }
}
