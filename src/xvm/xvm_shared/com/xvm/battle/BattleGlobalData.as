/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
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
            return _playerVehicleID;
        }

        public static function get playerName():String
        {
            return _playerName;
        }

        public static function get playerClan():String
        {
            return _playerClan;
        }

        public static function get playerVehCD():Number
        {
            return _playerVehCD;
        }

        public static function get playerSquad():Number
        {
            return _playerSquad;
        }

        public static function set playerSquad(value:Number):void
        {
            _playerSquad = value;
        }

        public static function get battleLevel():Number
        {
            return _battleLevel;
        }

        public static function get battleType():Number
        {
            return _battleType;
        }

        public static function get arenaGuiType():Number
        {
            return _arenaGuiType;
        }

        public static function get mapSize():Number
        {
            return _mapSize;
        }

        public static function get minimapCirclesData():VOMinimapCirclesData
        {
            return _minimapCirclesData;
        }

        public static function get battleLoadingVisible():Boolean
        {
            return _battleLoadingVisible;
        }

        public static function set battleLoadingVisible(value:Boolean):void
        {
            _battleLoadingVisible = value;
        }

        public static function init():void
        {
            Xfw.addCommandListener(BattleCommands.AS_RESPONSE_BATTLE_GLOBAL_DATA, onRespondBattleGlobalData);
            Xfw.cmd(BattleCommands.REQUEST_BATTLE_GLOBAL_DATA);

            _curent_xtdb = 0;
            _initialized = true;

            BattleMacros.RegisterGlobalMacrosData();
            Config.applyGlobalMacros();
        }

        private static var _initialized:Boolean = false;
        public static function get initialized():Boolean
        {
            return _initialized;
        }

        private static var _playerVehicleID:Number;
        private static var _playerName:String;
        private static var _playerFakeName:String;
        private static var _playerClan:String;
        private static var _playerVehCD:Number;
        private static var _playerSquad:Number;
        private static var _battleLevel:Number;
        private static var _battleType:Number;
        private static var _arenaGuiType:Number;
        private static var _mapSize:Number;
        private static var _minimapCirclesData:VOMinimapCirclesData;
        private static var _xtdb_data:Array;
        private static var _battleLoadingVisible:Boolean;

        private static var _curent_xtdb:Number = 0;

        private static function onRespondBattleGlobalData(playerVehicleID:Number, playerName:String, playerFakeName:String, playerClan:String, playerVehCD:Number,
            battleLevel:Number, battleType:Number, arenaGuiType:Number, mapSize:Number,
            minimapCirclesData:Object, xtdb_data:Array):void
        {
            if (playerVehCD != 0)
            {
                Xfw.removeCommandListener(BattleCommands.AS_RESPONSE_BATTLE_GLOBAL_DATA, onRespondBattleGlobalData);
            }
            //Logger.addObject(arguments);
            _playerVehicleID = playerVehicleID;
            _playerName = playerName;
            _playerFakeName = playerFakeName;
            _playerClan = playerClan;
            _playerVehCD = playerVehCD;
            _battleLevel = battleLevel;
            _battleType = battleType;
            switch (_battleType)
            {
                case Defines.BATTLE_TYPE_CYBERSPORT:
                    _battleLevel = 8;
                    break;
                case Defines.BATTLE_TYPE_REGULAR:
                    break;
                default:
                    //_battleLevel = 10;
                    break;
            }
            _arenaGuiType = arenaGuiType;
            _mapSize = mapSize;
            _minimapCirclesData = new VOMinimapCirclesData(minimapCirclesData);
            _xtdb_data = xtdb_data;
        }
    }
}
