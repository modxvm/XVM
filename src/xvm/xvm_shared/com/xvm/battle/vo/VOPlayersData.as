/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.battle.vo
{
    import com.xfw.*;
    import com.xfw.events.*;
    import com.xvm.*;
    import com.xvm.battle.*;
    import flash.utils.*;

    public class VOPlayersData
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

        private var lastPositionAlly:int = 0;
        private var lastPositionEnemy:int = 0;

        private var _addedStates:Array = [];

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
            var old_ids:Vector.<Number> = _leftVehiclesIDs ? _leftVehiclesIDs.concat() : null;
            _leftVehiclesIDs = value.concat(); // clone vector
            updateIndexes(_leftVehiclesIDs);
            checkOrderChanged(old_ids, value);
        }

        public function get rightVehiclesIDs():Vector.<Number>
        {
            return _rightVehiclesIDs;
        }

        public function set rightVehiclesIDs(value:Vector.<Number>):void
        {
            var old_ids:Vector.<Number> = _rightVehiclesIDs ? _rightVehiclesIDs.concat() : null;
            _rightVehiclesIDs = value.concat(); // clone vector
            updateIndexes(_rightVehiclesIDs);
            checkOrderChanged(old_ids, value);
        }

        // private
        private var playerNameToVehicleIDMap:Dictionary;
        private var accountDBIDToVehicleIDMap:Dictionary;

        public function VOPlayersData()
        {
            playerStates = new Dictionary();
            playerNameToVehicleIDMap = new Dictionary();
            accountDBIDToVehicleIDMap = new Dictionary();
        }

        public function get(vehicleID:Number):VOPlayerState
        {
            return isNaN(vehicleID) ? null : playerStates[vehicleID];
        }

        public function getVehicleIDByPlayerName(playerName:String):Number
        {
            return playerName ? playerNameToVehicleIDMap[playerName] : NaN;
        }

        public function getVehicleIDByAccountDBID(accountDBID:Number):Number
        {
            return !isNaN(accountDBID) ? accountDBIDToVehicleIDMap[accountDBID] : NaN;
        }

        public function updateVehiclesData(data:Object):void
        {
            if (data.leftCorrelationIDs)
            {
                leftCorrelationIDs = Vector.<Number>(data.leftCorrelationIDs);
            }
            if (data.rightCorrelationIDs)
            {
                rightCorrelationIDs = Vector.<Number>(data.rightCorrelationIDs);
            }
            if (data.leftVehiclesIDs || data.leftItemsIDs)
            {
                leftVehiclesIDs = Vector.<Number>(data.leftVehiclesIDs || data.leftItemsIDs);
            }
            if (data.rightVehiclesIDs || data.rightItemsIDs)
            {
                rightVehiclesIDs = Vector.<Number>(data.rightVehiclesIDs || data.rightItemsIDs);
            }
            if (data.leftVehicleInfos || data.leftItems)
            {
                updateVehicleInfos(leftVehiclesIDs, data.leftVehicleInfos || data.leftItems, true);
            }
            if (data.rightVehicleInfos || data.rightItems)
            {
                updateVehicleInfos(rightVehiclesIDs, data.rightVehicleInfos || data.rightItems, false);
            }
            if (_addedStates.length)
            {
                for each (var playerState:VOPlayerState in _addedStates)
                {
                    Macros.RegisterPlayerMacrosData(playerState.vehicleID, playerState.accountDBID, playerState.playerName, playerState.clanAbbrev, playerState.isAlly, playerState.badgeId);
                    Macros.RegisterVehicleMacrosData(playerState.playerName, playerState.vehCD);
                }
                _addedStates = [];
            }
        }

        public function updatePlayerState(vehicleID:Number, data:Object):void
        {
            var playerState:VOPlayerState = get(vehicleID);
            if (playerState)
            {
                playerState.update(data);
            }
        }

        public function updateVehicleInfos(vehiclesIds:Vector.<Number>, data:*, isAlly:Boolean):void
        {
            var vehicleID:Number;
            var ids_len:int = vehiclesIds.length;
            var data_len:int = data.length;
            for (var pos:int = 0; pos < ids_len; ++pos)
            {
                vehicleID = vehiclesIds[pos];
                for (var i:int = 0; i < data_len; ++i)
                {
                    var value:Object = data[i];
                    if (value.vehicleID == vehicleID)
                    {
                        addOrUpdatePlayerState(value, isAlly, pos);
                        break;
                    }
                }
            }
        }

        public function setUserTags(data:Object/*DAAPIVehiclesUserTagsVO*/):void
        {
            var value:Object;
            var playerState:VOPlayerState;
            for each (value in data.leftUserTags)
            {
                playerState = get(value.vehicleID);
                if (playerState)
                {
                    playerState.update({
                        userTags:value.userTags
                    });
                }
            }
            for each (value in data.rightUserTags)
            {
                playerState = get(value.vehicleID);
                if (playerState)
                {
                    playerState.update({
                        userTags:value.userTags
                    });
                }
            }
        }

        public function updateUserTags(data:Object/*DAAPIVehicleUserTagsVO*/):void
        {
            var playerState:VOPlayerState = get(data.vehicleID);
            if (playerState)
            {
                playerState.update({
                    userTags:data.userTags
                });
            }
        }

        public function updateVehicleFrags(data:*):void
        {
            for each (var vehicleStats:Object in data)
            {
                var playerState:VOPlayerState = get(vehicleStats.vehicleID);
                if (playerState)
                {
                    playerState.update({
                       frags: vehicleStats.frags
                    });
                }
            }
        }

        public function updateTotalStats(data:Object):void
        {
            leftScope = data.leftScope;
            rightScope = data.rightScope;
        }

        public function dispatchEvents():void
        {
            for each (var playerState:VOPlayerState in playerStates)
            {
                playerState.dispatchEvents();
            }
        }

        // PRIVATE

        private function addOrUpdatePlayerState(value:Object, isAlly:Boolean, index:int):void
        {
            var playerState:VOPlayerState;
            if (!playerStates.hasOwnProperty(value.vehicleID))
            {
                playerState = new VOPlayerState(value);
                playerState.update({
                   isAlly: isAlly,
                   position: isAlly ? ++lastPositionAlly : ++lastPositionEnemy,
                   index:index
                });
                playerStates[value.vehicleID] = playerState;
                playerNameToVehicleIDMap[value.playerName] = value.vehicleID;
                accountDBIDToVehicleIDMap[value.accountDBID] = value.vehicleID;
                _addedStates.push(playerState);
            }
            else
            {
                playerState = playerStates[value.vehicleID] as VOPlayerState;
                var value_obj:Object = ObjectConverter.toRawData(value);
                delete value_obj.frags;
                playerState.update(value_obj);
                playerState.update({
                   index: index
                });
            }
        }

        private function checkOrderChanged(old_order:Vector.<Number>, new_order:Vector.<Number>):void
        {
            if (!old_order || !new_order)
                return;

            var len:int = old_order.length;
            for (var i:int = 0; i < len; ++i)
            {
                var vehicleID:Number = new_order[i];
                if (old_order[i] != vehicleID)
                {
                    Xvm.dispatchEvent(new IntEvent(BattleEvents.PLAYERS_ORDER_CHANGED, vehicleID));
                }
            }
        }

        private function updateIndexes(ids:Vector.<Number>):void
        {
            var len:int = ids.length;
            for (var i:int = 0; i < len; ++i)
            {
                var playerState:VOPlayerState = get(ids[i]);
                if (playerState)
                {
                    playerState.update({index: i});
                }
            }
        }
    }
}
