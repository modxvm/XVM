package com.xvm.lobby.vo
{
    import com.xvm.vo.*;
    import flash.errors.*;
    import net.wg.gui.lobby.battleloading.constants.*;

    public class VOLobbyMacrosOptions extends VOMacrosOptions
    {
        public var _vehicleID:Number;
        public var _playerName:String;
        public var vehicleStatus:uint;
        public var playerStatus:uint;
        public var _isSelected:Boolean;
        public var _isCurrentPlayer:Boolean;
        public var _isSquadPersonal:Boolean;
        public var _squadIndex:Number;
        public var _position:Number;

        private var _vehCD:int;
        private var _vehicleData:VOVehicleData;

        // IMacrosOptionsVO implementation

        override public function get vehicleID():Number
        {
            return _vehicleID;
        }

        override public function get playerName():String
        {
            return _playerName;
        }

        override public function get isAlive():Boolean
        {
            return (vehicleStatus & VehicleStatus.IS_ALIVE) != 0;
        }

        override public function get isReady():Boolean
        {
            return (vehicleStatus & VehicleStatus.IS_READY) != 0;
        }

        override public function get isNotAvailable():Boolean
        {
            return (vehicleStatus & VehicleStatus.NOT_AVAILABLE) != 0;
        }

        override public function get isSelected():Boolean
        {
            return _isSelected;
        }

        override public function get isSquadPersonal():Boolean
        {
            return _isSquadPersonal;
        }

        override public function get isTeamKiller():Boolean
        {
            return (playerStatus & PlayerStatus.IS_TEAM_KILLER) != 0;
        }

        override public function get isCurrentPlayer():Boolean
        {
            return _isCurrentPlayer;
        }

        override public function get squadIndex():Number
        {
            return _squadIndex;
        }

        override public function get position():Number
        {
            return _position;
        }

        override public function get vehCD():int
        {
            return _vehCD;
        }

        override public function get vehicleData():VOVehicleData
        {
            return _vehicleData;
        }
    }
}
