package com.xvm.battle.vo
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.vo.*;
    import flash.utils.Dictionary;
    import net.wg.data.VO.daapi.*;
    import net.wg.infrastructure.interfaces.*;

    public dynamic class VOPlayersData extends VOBase
    {
        public var vehicleInfos : Dictionary;

        // DAAPIVehiclesDataVO
        public var leftCorrelationIDs : Vector.<Number>;
        public var leftVehiclesIDs : Vector.<Number>;
        public var rightCorrelationIDs : Vector.<Number>;
        public var rightVehicleInfos : Vector.<VOPlayerState>;
        public var rightVehiclesIDs : Vector.<Number>;

        // DAAPITotalStatsVO
        public var leftScope : int = 0;
        public var rightScope : int = 0;

        // XVM
        public var hitlogTotalHits : int = 0;       // TODO: set & update
        public var hitlogTotalDamage : int = 0;     // TODO: set & update
        public var captureBarData : VOCaptureBarData = new VOCaptureBarData();

        // private
        private var playerNameToVehicleIDMap:Dictionary;

        public function VOPlayersData(data:IDAAPIDataClass)
        {
            var d:DAAPIVehiclesDataVO = DAAPIVehiclesDataVO(data);

            vehicleInfos = new Dictionary();
            playerNameToVehicleIDMap = new Dictionary();
            var value:DAAPIVehicleInfoVO;
            for each (value in d.leftVehicleInfos)
            {
                vehicleInfos[value.vehicleID] = new VOPlayerState(value, false);
                playerNameToVehicleIDMap[value.playerName] = value.vehicleID;
            }
            for each (value in d.rightVehicleInfos)
            {
                vehicleInfos[value.vehicleID] = new VOPlayerState(value, true);
                playerNameToVehicleIDMap[value.playerName] = value.vehicleID;
            }

            leftCorrelationIDs = d.leftCorrelationIDs;
            leftVehiclesIDs = d.leftVehiclesIDs;
            rightCorrelationIDs = d.rightCorrelationIDs;
            rightVehiclesIDs = d.rightVehiclesIDs;
        }

        public function get(vehicleID:Number):VOPlayerState
        {
            return isNaN(vehicleID) ? null : vehicleInfos[vehicleID];
        }

        public function getByPlayerName(playerName:String):VOPlayerState
        {
            return playerName ? get(playerNameToVehicleIDMap[playerName]) : null;
        }

        public function updateVehicleInfo(vehicleID:Number, data:Object):void
        {
            var vehicleInfo:VOPlayerState = get(vehicleID);
            if (vehicleInfo)
            {
                vehicleInfo.update(data);
            }
        }

        public function updateVehicleFrags(data:Vector.<DAAPIVehicleStatsVO>, isLeft:Boolean):void
        {
            for each (var vo:DAAPIVehicleStatsVO in data)
            {
                var vehicleInfo:VOPlayerState = get(vo.vehicleID);
                if (vehicleInfo)
                {
                    vehicleInfo.update({ frags: vo.frags });
                }
            }
        }

        public function updateTotalStats(data:DAAPITotalStatsVO):void
        {
            leftScope = data.leftScope;
            rightScope = data.rightScope;
        }
    }
}
