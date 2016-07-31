package com.xvm.lobby.vo
{
    import com.xvm.*;
    import com.xvm.vo.*;
    import flash.errors.*;
    import net.wg.gui.lobby.battleloading.constants.*;

    public class VOLobbyMacrosOptions extends VOMacrosOptions
    {
        private var _vehicleID:Number;
        private var _playerName:String;
        private var _isAlly:Boolean;
        public var vehicleStatus:uint;
        public var playerStatus:uint;
        private var _isSelected:Boolean;
        private var _isCurrentPlayer:Boolean;
        private var _isSquadPersonal:Boolean;
        private var _squadIndex:Number;
        private var _position:Number;

        private var _vehCD:int;
        private var _vehicleData:VOVehicleData;

        // IMacrosOptionsVO implementation

        override public function get vehicleID():Number
        {
            return _vehicleID;
        }

        public function set vehicleID(value:Number):void
        {
            _vehicleID = value;
        }

        override public function get playerName():String
        {
            return _playerName;
        }

        public function set playerName(value:String):void
        {
            _playerName = value;
        }

        override public function get isAlly():Boolean
        {
            return _isAlly;
        }

        public function set isAlly(value:Boolean):void
        {
            _isAlly = value;
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

        override public function get isStopRespawn():Boolean
        {
            return false;
        }

        override public function get isSelected():Boolean
        {
            return _isSelected;
        }

        public function set isSelected(value:Boolean):void
        {
            _isSelected = value;
        }

        override public function get isSquadPersonal():Boolean
        {
            return _isSquadPersonal;
        }

        public function set isSquadPersonal(value:Boolean):void
        {
            _isSquadPersonal = value;
        }

        override public function get isTeamKiller():Boolean
        {
            return (playerStatus & PlayerStatus.IS_TEAM_KILLER) != 0;
        }

        override public function get isCurrentPlayer():Boolean
        {
            return _isCurrentPlayer;
        }

        public function set isCurrentPlayer(value:Boolean):void
        {
            _isCurrentPlayer = value;
        }

        override public function get squadIndex():Number
        {
            return _squadIndex;
        }

        public function set squadIndex(value:Number):void
        {
            _squadIndex = value;
        }

        override public function get position():Number
        {
            return _position;
        }

        public function set position(value:Number):void
        {
            _position = value;
        }

        override public function get vehCD():int
        {
            return _vehCD;
        }

        public function set vehCD(value:int):void
        {
            _vehCD = value;
            if (vehicleData == null || _vehicleData.vehCD != _vehCD)
            {
                vehicleData = VehicleInfo.get(_vehCD);
            }
        }

        override public function get vehicleData():VOVehicleData
        {
            return _vehicleData;
        }

        public function set vehicleData(value:VOVehicleData):void
        {
            _vehicleData = value;
            if (vehCD != _vehicleData.vehCD)
            {
                vehCD = _vehicleData.vehCD;
            }
        }

        override public function get marksOnGun():Number
        {
            return NaN;
        }
    }
}
