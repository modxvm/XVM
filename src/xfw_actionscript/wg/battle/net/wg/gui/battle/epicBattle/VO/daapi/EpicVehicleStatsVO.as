package net.wg.gui.battle.epicBattle.VO.daapi
{
    import net.wg.data.daapi.base.DAAPIDataClass;

    public class EpicVehicleStatsVO extends DAAPIDataClass
    {

        public var isEnemy:Boolean = false;

        public var vehicleID:Number = -1;

        public var frags:int = -1;

        public var rank:int = -1;

        public var lane:int = -1;

        public var hasRespawns:Boolean = false;

        public function EpicVehicleStatsVO(param1:Object)
        {
            super(param1);
        }
    }
}
