package net.wg.gui.battle.eventBattle.views.eventStats
{
    import net.wg.gui.battle.random.views.stats.components.fullStats.FullStatsTableCtrl;
    import net.wg.data.VO.daapi.DAAPIVehicleInfoVO;
    import net.wg.data.constants.generated.EVENT_CONSTS;
    import net.wg.infrastructure.base.meta.impl.StatsBaseMeta;

    public class EventFullStatsTableCtrl extends FullStatsTableCtrl
    {

        private static const VEHICLES_MAX_COUNT:uint = 7;

        public function EventFullStatsTableCtrl(param1:EventFullStatsTable, param2:StatsBaseMeta)
        {
            super(param1,param2);
            numRows = VEHICLES_MAX_COUNT;
        }

        override public function setVehiclesData(param1:Array, param2:Vector.<Number>, param3:Boolean) : void
        {
            super.setVehiclesData(param1,param2,param3);
            this.updatePlatoonVisibility();
        }

        private function updatePlatoonVisibility() : void
        {
            var _loc1_:* = false;
            _loc1_ = _teamDP.length > 0 && (_teamDP.requestItemAt(0) as DAAPIVehicleInfoVO).vehicleType.indexOf(EVENT_CONSTS.VEHICLE_TYPE_BOSS) > -1;
            _table.leftPlatoon.visible = !_loc1_;
            _table.rightPlatoon.visible = _loc1_;
        }
    }
}
