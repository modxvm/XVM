package com.xvm.battle.vo
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.vo.*;
    import flash.utils.Dictionary;
    import net.wg.data.VO.daapi.*;
    import net.wg.infrastructure.interfaces.*;

    public class VOPlayersData extends VOBase
    {
        public var playerStates:Dictionary;

        // DAAPIVehiclesDataVO
        public var leftCorrelationIDs:Vector.<Number>;
        public var rightCorrelationIDs:Vector.<Number>;

        private var _leftVehiclesIDs:Vector.<Number>;
        public function get leftVehiclesIDs():Vector.<Number>
        {
            return _leftVehiclesIDs;
        }
        public function set leftVehiclesIDs(value:Vector.<Number>):void
        {
            _leftVehiclesIDs = value;
            updateVehiclesPositions(value);
        }

        private var _rightVehiclesIDs:Vector.<Number>;
        public function get rightVehiclesIDs():Vector.<Number>
        {
            return _rightVehiclesIDs;
        }
        public function set rightVehiclesIDs(value:Vector.<Number>):void
        {
            _rightVehiclesIDs = value;
            updateVehiclesPositions(value);
        }

        // DAAPITotalStatsVO
        public var leftScope:int = 0;
        public var rightScope:int = 0;

        // private
        private var playerNameToVehicleIDMap:Dictionary;

        public function VOPlayersData(data:IDAAPIDataClass)
        {
            var d:DAAPIVehiclesDataVO = DAAPIVehiclesDataVO(data);

            playerStates = new Dictionary();
            playerNameToVehicleIDMap = new Dictionary();
            var value:DAAPIVehicleInfoVO;
            for each (value in d.leftVehicleInfos)
            {
                playerStates[value.vehicleID] = new VOPlayerState(value, false);
                playerNameToVehicleIDMap[value.playerName] = value.vehicleID;
            }
            for each (value in d.rightVehicleInfos)
            {
                playerStates[value.vehicleID] = new VOPlayerState(value, true);
                playerNameToVehicleIDMap[value.playerName] = value.vehicleID;
            }

            leftCorrelationIDs = d.leftCorrelationIDs;
            rightCorrelationIDs = d.rightCorrelationIDs;

            leftVehiclesIDs = d.leftVehiclesIDs;
            rightVehiclesIDs = d.rightVehiclesIDs;
        }

        public function get(vehicleID:Number):VOPlayerState
        {
            return isNaN(vehicleID) ? null : playerStates[vehicleID];
        }

        public function getByPlayerName(playerName:String):VOPlayerState
        {
            return playerName ? get(playerNameToVehicleIDMap[playerName]) : null;
        }

        public function updatePlayerState(vehicleID:Number, data:Object):void
        {
            var playerState:VOPlayerState = get(vehicleID);
            if (playerState)
            {
                playerState.update(data);
            }
        }

        public function updateVehicleFrags(data:Vector.<DAAPIVehicleStatsVO>):void
        {
            for each (var vehicleStats:DAAPIVehicleStatsVO in data)
            {
                var playerState:VOPlayerState = get(vehicleStats.vehicleID);
                if (playerState)
                {
                    playerState.frags = vehicleStats.frags;
                }
            }
        }

        public function updateTotalStats(data:DAAPITotalStatsVO):void
        {
            leftScope = data.leftScope;
            rightScope = data.rightScope;
        }

        // PRIVATE

        private function updateVehiclesPositions(ids:Vector.<Number>):void
        {
            var playerState:VOPlayerState;
            var len:int = ids.length;
            for (var i:int = 0; i < len; ++i)
            {
                playerState = get(ids[i]);
                if (playerState)
                {
                    playerState.position = i + 1;
                }
            }
        }
    }
}
