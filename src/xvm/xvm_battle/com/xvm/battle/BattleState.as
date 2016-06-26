/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.battle
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xfw.events.*;
    import com.xvm.types.cfg.*;
    import com.xvm.battle.vo.*;
    import flash.events.*;
    import flash.utils.*;
    import net.wg.data.VO.daapi.*;
    import net.wg.infrastructure.interfaces.*;
    import net.wg.infrastructure.helpers.statisticsDataController.intarfaces.*;

    public class BattleState implements IBattleComponentDataController
    {
        public static function get(vehicleID:Number):VOPlayerState
        {
            return instance._playersDataVO.get(vehicleID);
        }

        public static function getByPlayerName(playerName:String):VOPlayerState
        {
            return instance._playersDataVO.getByPlayerName(playerName);
        }

        public static function get arenaInfoVO():VOArenaInfo
        {
            return instance._arenaInfoVO;
        }

        public static function get playersDataVO():VOPlayersData
        {
            return instance._playersDataVO;
        }

        private var _captureBarData:VOCaptureBarData = new VOCaptureBarData();

        public static function get captureBarDataVO():VOCaptureBarData
        {
            return instance._captureBarDataVO;
        }

        public static function set captureBarDataVO(value:VOCaptureBarData):void
        {
            instance._captureBarDataVO = value;
        }

        public static function get playerFrags():int
        {
            return instance._playerFrags;
        }

        public static function set playerFrags(value:int):void
        {
            instance._playerFrags = value;
        }

        public static function get hitlogTotalHits():int
        {
            return instance._hitlogTotalHits;
        }

        public static function set hitlogTotalHits(value:int):void
        {
            instance._hitlogTotalHits = value;
        }

        public static function get hitlogTotalDamage():int
        {
            return instance._hitlogTotalDamage;
        }

        public static function set hitlogTotalDamage(value:int):void
        {
            instance._hitlogTotalDamage = value;
        }

        // instance
        instance; // static .ctor
        private static var _instance:BattleState = null;
        public static function get instance():BattleState
        {
            if (_instance == null)
            {
                _instance = new BattleState();
            }
            return _instance;
        }

        private var _arenaInfoVO:VOArenaInfo = null;
        private var _playersDataVO:VOPlayersData = null;
        private var _captureBarDataVO:VOCaptureBarData = new VOCaptureBarData();
        private var _playerFrags:int = 0;
        private var _hitlogTotalHits:int = 0;       // TODO: set & update
        private var _hitlogTotalDamage:int = 0;     // TODO: set & update

        // .ctor should be private for Singleton
        function BattleState()
        {
            Xfw.addCommandListener(BattleCommands.AS_UPDATE_PLAYER_STATE, onUpdatePlayerState);
            Xfw.addCommandListener(BattleCommands.AS_UPDATE_HITLOG_DATA, onUpdateHitlogData);
        }

        // IBattleComponentDataController implementation

        public function addVehiclesInfo(data:IDAAPIDataClass):void
        {
            Logger.addObject(data, 1, "addVehiclesInfo");
            try
            {
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
            /*
            var _loc2_:DAAPIVehiclesDataVO = DAAPIVehiclesDataVO(param1);
            if(_loc2_.rightVehicleInfos)
            {
                this._enemyVehicleMarkersList.addVehiclesInfo(_loc2_.rightVehicleInfos,_loc2_.rightCorrelationIDs);
            }
            if(_loc2_.leftVehicleInfos)
            {
                this._allyVehicleMarkersList.addVehiclesInfo(_loc2_.leftVehicleInfos,_loc2_.leftCorrelationIDs);
            }
            */
        }

        public function setArenaInfo(data:IDAAPIDataClass):void
        {
            try
            {
                _arenaInfoVO = new VOArenaInfo(data);
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        public function setPersonalStatus(param1:uint):void
        {
            Logger.add("setPersonalStatus: " + param1);
            try
            {
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
            /*
            var _loc2_:Boolean = PersonalStatus.isVehicleCounterShown(param1);
            this._allyVehicleMarkersList.isVehicleCounterShown = this._enemyVehicleMarkersList.isVehicleCounterShown = _loc2_;
            */
        }

        public function setUserTags(data:IDAAPIDataClass):void
        {
            Logger.addObject(data, 1, "setUserTags");
            try
            {
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        public function setVehiclesData(data:IDAAPIDataClass):void
        {
            try
            {
                _playersDataVO = new VOPlayersData(data);
                Macros.RegisterPlayersData(BattleMacros.RegisterPlayersData);
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        public function setVehicleStats(data:IDAAPIDataClass):void
        {
            try
            {
                var vehicleStatsVO:DAAPIVehiclesStatsVO = DAAPIVehiclesStatsVO(data);
                if (vehicleStatsVO.leftFrags)
                {
                    _playersDataVO.updateVehicleFrags(vehicleStatsVO.leftFrags);
                }
                if (vehicleStatsVO.rightFrags)
                {
                    _playersDataVO.updateVehicleFrags(vehicleStatsVO.rightFrags);
                }
                if (vehicleStatsVO.totalStats)
                {
                    _playersDataVO.updateTotalStats(vehicleStatsVO.totalStats);
                }
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        public function updateInvitationsStatuses(data:IDAAPIDataClass) : void
        {
            Logger.addObject(data, 1, "updateInvitationsStatuses");
            try
            {
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        public function updatePersonalStatus(param1:uint, param2:uint):void
        {
            Logger.add("updatePersonalStatus: " + param1 + ", " + param2);
            try
            {
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
            /*
            {
                this._allyVehicleMarkersList.isVehicleCounterShown = this._enemyVehicleMarkersList.isVehicleCounterShown = true;
            }
            else if(PersonalStatus.IS_VEHICLE_COUNTER_SHOWN == param2)
            {
                this._allyVehicleMarkersList.isVehicleCounterShown = this._enemyVehicleMarkersList.isVehicleCounterShown = false;
            }
            */
        }

        public function updatePlayerStatus(data:IDAAPIDataClass):void
        {
            try
            {
                var d:DAAPIPlayerStatusVO = DAAPIPlayerStatusVO(data);
                _playersDataVO.updatePlayerState(d.vehicleID, { playerStatus: d.status });
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        public function updateUserTags(data:IDAAPIDataClass):void
        {
            Logger.addObject(data, 1, "updateUserTags");
            try
            {
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        public function updateVehiclesInfo(data:IDAAPIDataClass):void
        {
            try
            {
                var vehiclesDataVO:DAAPIVehiclesDataVO = DAAPIVehiclesDataVO(data);
                if (vehiclesDataVO.leftCorrelationIDs)
                    _playersDataVO.leftCorrelationIDs = vehiclesDataVO.leftCorrelationIDs;
                if (vehiclesDataVO.rightCorrelationIDs)
                    _playersDataVO.rightCorrelationIDs = vehiclesDataVO.rightCorrelationIDs;
                if (vehiclesDataVO.leftVehiclesIDs)
                    _playersDataVO.leftVehiclesIDs = vehiclesDataVO.leftVehiclesIDs;
                if (vehiclesDataVO.rightVehiclesIDs)
                    _playersDataVO.rightVehiclesIDs = vehiclesDataVO.rightVehiclesIDs;
                if (vehiclesDataVO.leftVehicleInfos)
                    _playersDataVO.updateVehicleInfos(vehiclesDataVO.leftVehicleInfos);
                if (vehiclesDataVO.rightVehicleInfos)
                    _playersDataVO.updateVehicleInfos(vehiclesDataVO.rightVehicleInfos);
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        public function updateVehiclesStats(data:IDAAPIDataClass):void
        {
            setVehicleStats(data);
        }

        public function updateVehicleStatus(data:IDAAPIDataClass):void
        {
            try
            {
                var vehicleStatusVO:DAAPIVehicleStatusVO = DAAPIVehicleStatusVO(data);
                _playersDataVO.updatePlayerState(vehicleStatusVO.vehicleID, { vehicleStatus: vehicleStatusVO.status });
                if (vehicleStatusVO.rightCorrelationIDs)
                    _playersDataVO.rightCorrelationIDs = vehicleStatusVO.rightCorrelationIDs;
                if (vehicleStatusVO.rightVehiclesIDs)
                    _playersDataVO.rightVehiclesIDs = vehicleStatusVO.rightVehiclesIDs;
                if (vehicleStatusVO.leftCorrelationIDs)
                    _playersDataVO.leftCorrelationIDs = vehicleStatusVO.leftCorrelationIDs;
                if (vehicleStatusVO.leftVehiclesIDs)
                    _playersDataVO.leftVehiclesIDs = vehicleStatusVO.leftVehiclesIDs;
                if (vehicleStatusVO.totalStats)
                    _playersDataVO.updateTotalStats(vehicleStatusVO.totalStats);
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        // XVM calls

        private function onUpdatePlayerState(vehicleID:Number, data:Object):Object
        {
            try
            {
                var playerState:VOPlayerState = get(vehicleID);
                if (playerState)
                {
                    playerState.update(data);
                }
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
            return null;
        }

        private function onUpdateHitlogData(vehicleID:Number, attackReasonID:Number, newHealth:Number):Object
        {
            Logger.add("onUpdateHitlogData: " + [vehicleID, attackReasonID, newHealth]);

            hitlogTotalHits++;
            //hitlogTotalDamage += TODO

            return null;
        }
    }
}
