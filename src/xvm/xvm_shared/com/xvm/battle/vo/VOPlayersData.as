/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.battle.vo
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.vo.*;
    import flash.utils.*;

    public class VOPlayersData extends VOBase
    {
        public var playerStates:Dictionary;

        // DAAPIVehiclesDataVO
        private var _leftCorrelationIDs:Vector.<Number>;
        private var _rightCorrelationIDs:Vector.<Number>;
        private var _leftVehiclesIDs:Vector.<Number>;
        private var _rightVehiclesIDs:Vector.<Number>;

        // DAAPITotalStatsVO
        public var leftScope:int = 0;
        public var rightScope:int = 0;

        public function get leftCorrelationIDs():Vector.<Number>
        {
            return _leftCorrelationIDs;
        }

        public function set leftCorrelationIDs(value:Vector.<Number>):void
        {
            _leftCorrelationIDs = value.concat(); // clone vector
        }

        public function get rightCorrelationIDs():Vector.<Number>
        {
            return _rightCorrelationIDs;
        }

        public function set rightCorrelationIDs(value:Vector.<Number>):void
        {
            _rightCorrelationIDs = value.concat(); // clone vector
        }

        public function get leftVehiclesIDs():Vector.<Number>
        {
            return _leftVehiclesIDs;
        }

        public function set leftVehiclesIDs(value:Vector.<Number>):void
        {
            _leftVehiclesIDs = value.concat(); // clone vector
            updateVehiclesPositionsAndTeam(value, true);
        }

        public function get rightVehiclesIDs():Vector.<Number>
        {
            return _rightVehiclesIDs;
        }

        public function set rightVehiclesIDs(value:Vector.<Number>):void
        {
            _rightVehiclesIDs = value.concat(); // clone vector
            updateVehiclesPositionsAndTeam(value, false);
        }

        // private
        private var playerNameToVehicleIDMap:Dictionary;

        public function VOPlayersData(data:Object)
        {
            playerStates = new Dictionary();
            playerNameToVehicleIDMap = new Dictionary();
            var value:Object;
            for each (value in data.leftVehicleInfos)
            {
                playerStates[value.vehicleID] = new VOPlayerState(value);
                playerNameToVehicleIDMap[value.playerName] = value.vehicleID;
            }
            for each (value in data.rightVehicleInfos)
            {
                playerStates[value.vehicleID] = new VOPlayerState(value);
                playerNameToVehicleIDMap[value.playerName] = value.vehicleID;
            }

            leftCorrelationIDs = data.leftCorrelationIDs;
            rightCorrelationIDs = data.rightCorrelationIDs;
            leftVehiclesIDs = data.leftVehiclesIDs;
            rightVehiclesIDs = data.rightVehiclesIDs;
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

        public function updateVehicleInfos(data:*):void
        {
            for each (var value:Object in data)
            {
                if (!playerStates.hasOwnProperty(value.vehicleID))
                {
                    playerStates[value.vehicleID] = new VOPlayerState(value);
                    playerNameToVehicleIDMap[value.playerName] = value.vehicleID;
                }
                else
                {
                    (playerStates[value.vehicleID] as VOPlayerState).update(value);
                }
            }
        }

        public function updateVehicleFrags(data:*):void
        {
            for each (var vehicleStats:Object in data)
            {
                var playerState:VOPlayerState = get(vehicleStats.vehicleID);
                if (playerState)
                {
                    playerState.frags = vehicleStats.frags;
                }
            }
        }

        public function updateTotalStats(data:Object):void
        {
            leftScope = data.leftScope;
            rightScope = data.rightScope;
        }

        // PRIVATE

        private function updateVehiclesPositionsAndTeam(ids:Vector.<Number>, isAlly:Boolean):void
        {
            var playerState:VOPlayerState;
            var len:int = ids.length;
            for (var i:int = 0; i < len; ++i)
            {
                playerState = get(ids[i]);
                if (playerState)
                {
                    playerState.isAlly = true;
                    playerState.position = i + 1;
                }
            }
        }
    }
}
