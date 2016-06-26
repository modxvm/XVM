/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.battle
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.battle.vo.*;

    public class BattleGlobalData
    {
        public static function get playerVehicleID():Number
        {
            return instance._playerVehicleID;
        }

        public static function get playerName():String
        {
            return instance._playerName;
        }

        public static function get playerVehCD():Number
        {
            return instance._playerVehCD;
        }

        public static function get curentXtdb():Number
        {
            return instance.getCurentXtdb();
        }

        // instance
        instance; // static .ctor
        private static var _instance:BattleGlobalData = null;
        private static function get instance():BattleGlobalData
        {
            if (_instance == null)
            {
                _instance = new BattleGlobalData();
            }
            return _instance;
        }

        private var _playerVehicleID:Number;
        private var _playerName:String;
        private var _playerVehCD:Number;
        private var _battleLevel:Number;
        private var _battleType:Number;
        private var _arenaGuiType:Number;
        private var _mapSize:Number;
        private var _minimapCirclesData:VOMinimapCirclesData;
        private var _xtdb_data:Array;

        // .ctor should be private for Singleton
        function BattleGlobalData()
        {
            Xfw.addCommandListener(BattleCommands.AS_RESPONSE_BATTLE_GLOBAL_DATA, onRespondBattleGlobalData);
            Xfw.cmd(BattleCommands.REQUEST_BATTLE_GLOBAL_DATA);
        }

        private function onRespondBattleGlobalData(playerVehicleID:Number, playerName:String, playerVehCD:Number,
            battleLevel:Number, battleType:Number, arenaGuiType:Number, mapSize:Number,
            minimapCirclesData:Object, xtdb_data:Array):Object
        {
            //Logger.addObject(arguments);
            _playerVehicleID = playerVehicleID;
            _playerName = playerName;
            _playerVehCD = playerVehCD;
            _battleLevel = battleLevel;
            _battleType = battleType;
            _arenaGuiType = arenaGuiType;
            _mapSize = mapSize;
            _minimapCirclesData = new VOMinimapCirclesData(minimapCirclesData);
            _xtdb_data = xtdb_data;
            return null;
        }


        private var _curent_xtdb:Number = 0;
        private function getCurentXtdb():Number
        {
                var xtdb_data_len:Number = _xtdb_data.length;
                while (_curent_xtdb < xtdb_data_len - 1)
                {
                    if (BattleState.hitlogTotalDamage < _xtdb_data[_curent_xtdb])
                        break;
                    ++_curent_xtdb;
                }
                return _curent_xtdb;
        }
    }
}
