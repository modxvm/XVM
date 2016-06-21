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

        // instance
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

        // .ctor should be private for Singleton
        function BattleState()
        {
        }

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
            //Logger.addObject(data, 1, "setArenaInfo");
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
            Logger.add("setVehiclesData");
            //Logger.addObject(data, 1, "setVehiclesData");
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
            Logger.addObject(data, 1, "setVehicleStats");
            try
            {
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
            /*
            if(_loc2_.totalStats)
            {
                this.updateFrags(_loc2_.totalStats.leftScope,_loc2_.totalStats.rightScope);
            this._allyTeamFragsStr = param1.toString();
            this._enemyTeamFragsStr = param2.toString();
            if(param1 == param2)
            {
                this._currentTeamSeparatorState = this.FRAG_EQUAL;
            }
            else if(param1 > param2)
            {
                this._currentTeamSeparatorState = this.FRAG_WIN;
            }
            else
            {
                this._currentTeamSeparatorState = this.FRAG_LOSE;
            }
            invalidate(INVALID_FRAGS);
            }
            */
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
            Logger.addObject(data, 1, "updatePlayerStatus");
            try
            {
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
            //var _loc1_:uint = this._vehicleData.playerStatus;
            //this._listItem.setSquad(PlayerStatus.isSquadPersonal(_loc1_),this._vehicleData.squadIndex);
            //this._listItem.setIsTeamKiller(PlayerStatus.isTeamKiller(_loc1_));
            //this._listItem.setSquadNoSound(PlayerStatus.isVoipDisabled(_loc1_));
            //this._listItem.setIsSelected(PlayerStatus.isSelected(_loc1_));
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
            Logger.addObject(data, 1, "updateVehiclesInfo");
            try
            {
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
            /*
            var _loc2_:DAAPIVehiclesDataVO = DAAPIVehiclesDataVO(param1);
            if(_loc2_.leftVehicleInfos)
            {
                this._allyVehicleMarkersList.updateVehiclesInfo(_loc2_.leftVehicleInfos,_loc2_.leftCorrelationIDs);
            }
            if(_loc2_.rightVehicleInfos)
            {
                this._enemyVehicleMarkersList.updateVehiclesInfo(_loc2_.rightVehicleInfos,_loc2_.rightCorrelationIDs);
            }
            */
        }

        public function updateVehiclesStats(data:IDAAPIDataClass):void
        {
            //Logger.addObject(data, 1, "updateVehiclesStats");
            try
            {
                var vehicleStatsVO:DAAPIVehiclesStatsVO = DAAPIVehiclesStatsVO(data);
                if (vehicleStatsVO.leftFrags)
                {
                    _playersDataVO.updateVehicleFrags(vehicleStatsVO.leftFrags, true);
                }
                if (vehicleStatsVO.rightFrags)
                {
                    _playersDataVO.updateVehicleFrags(vehicleStatsVO.rightFrags, false);
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

        public function updateVehicleStatus(data:IDAAPIDataClass):void
        {
            try
            {
                var vehicleStatusVO:DAAPIVehicleStatusVO = DAAPIVehicleStatusVO(data);

                _playersDataVO.updatePlayerState(vehicleStatusVO.vehicleID, { vehicleStatus: vehicleStatusVO.status });

                if (vehicleStatusVO.isEnemy)
                {
                    if (vehicleStatusVO.rightCorrelationIDs)
                        _playersDataVO.rightCorrelationIDs = vehicleStatusVO.rightCorrelationIDs;
                    if (vehicleStatusVO.rightVehiclesIDs)
                        _playersDataVO.rightVehiclesIDs = vehicleStatusVO.rightVehiclesIDs;
                }
                else
                {
                    if (vehicleStatusVO.leftCorrelationIDs)
                        _playersDataVO.leftCorrelationIDs = vehicleStatusVO.leftCorrelationIDs;
                    if (vehicleStatusVO.leftVehiclesIDs)
                        _playersDataVO.leftVehiclesIDs = vehicleStatusVO.leftVehiclesIDs;
                }

                if (vehicleStatusVO.totalStats)
                {
                    _playersDataVO.updateTotalStats(vehicleStatusVO.totalStats);
                }
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }
    }
}
