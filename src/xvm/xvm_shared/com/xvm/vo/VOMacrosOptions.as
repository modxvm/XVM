package com.xvm.vo
{
    import flash.errors.*;

    public class VOMacrosOptions extends VOBase implements IVOMacrosOptions
    {
        public function get vehicleID():Number
        {
            throw new IllegalOperationError("abstract method called");
        }

        public function get playerName():String
        {
            throw new IllegalOperationError("abstract method called");
        }

        public function get clanAbbrev():String
        {
            throw new IllegalOperationError("abstract method called");
        }

        public function get isAlly():Boolean
        {
            throw new IllegalOperationError("abstract method called");
        }

        public function get isEnemy():Boolean
        {
            return !isAlly;
        }

        public function get isAlive():Boolean
        {
            throw new IllegalOperationError("abstract method called");
        }

        public function get isDead():Boolean
        {
            return !isAlive;
        }

        public function get isReady():Boolean
        {
            throw new IllegalOperationError("abstract method called");
        }

        public function get isOffline():Boolean
        {
            return !isReady;
        }

        public function get isNotAvailable():Boolean
        {
            throw new IllegalOperationError("abstract method called");
        }

        public function get isStopRespawn():Boolean
        {
            throw new IllegalOperationError("abstract method called");
        }

        public function get isSelected():Boolean
        {
            throw new IllegalOperationError("abstract method called");
        }

        public function get isSquadPersonal():Boolean
        {
            throw new IllegalOperationError("abstract method called");
        }

        public function get isTeamKiller():Boolean
        {
            throw new IllegalOperationError("abstract method called");
        }

        public function get isCurrentPlayer():Boolean
        {
            throw new IllegalOperationError("abstract method called");
        }

        public function get squadIndex():Number
        {
            throw new IllegalOperationError("abstract method called");
        }

        public function get position():Number
        {
            throw new IllegalOperationError("abstract method called");
        }

        public function get vehCD():int
        {
            throw new IllegalOperationError("abstract method called");
        }

        public function get vehicleData():VOVehicleData
        {
            throw new IllegalOperationError("abstract method called");
        }

        public function get marksOnGun():Number
        {
            throw new IllegalOperationError("abstract method called");
        }

        // internal

        public function getSubname():String
        {
            return _subname;
        }

        public function setSubname(subname:String):void
        {
            _subname = subname;
        }

        private var _subname:String = null;
    }
}
