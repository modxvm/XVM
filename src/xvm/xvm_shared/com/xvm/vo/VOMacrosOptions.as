/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.vo
{
    import flash.errors.*;

    public class VOMacrosOptions extends VOBase implements IVOMacrosOptions
    {
        public function get vehicleID():Number
        {
            //throw new IllegalOperationError("abstract method called");
            return NaN;
        }

        public function get playerName():String
        {
            //throw new IllegalOperationError("abstract method called");
            return null;
        }

        public function get clanAbbrev():String
        {
            //throw new IllegalOperationError("abstract method called");
            return null;
        }

        public function get isAlly():Boolean
        {
            //throw new IllegalOperationError("abstract method called");
            return true;
        }

        public function get isEnemy():Boolean
        {
            return !isAlly;
        }

        public function get isAlive():Boolean
        {
            //throw new IllegalOperationError("abstract method called");
            return true;
        }

        public function get isDead():Boolean
        {
            return !isAlive;
        }

        public function get isReady():Boolean
        {
            //throw new IllegalOperationError("abstract method called");
            return true;
        }

        public function get isOffline():Boolean
        {
            return !isReady;
        }

        public function get isNotAvailable():Boolean
        {
            //throw new IllegalOperationError("abstract method called");
            return false;
        }

        public function get isStopRespawn():Boolean
        {
            //throw new IllegalOperationError("abstract method called");
            return false;
        }

        public function get isSelected():Boolean
        {
            //throw new IllegalOperationError("abstract method called");
            return false;
        }

        public function get isFriend():Boolean
        {
            //throw new IllegalOperationError("abstract method called");
            return false;
        }

        public function get isIgnored():Boolean
        {
            //throw new IllegalOperationError("abstract method called");
            return false;
        }

        public function get isMuted():Boolean
        {
            //throw new IllegalOperationError("abstract method called");
            return false;
        }

        public function get isChatBan():Boolean
        {
            //throw new IllegalOperationError("abstract method called");
            return false;
        }

        public function get isSquadPersonal():Boolean
        {
            //throw new IllegalOperationError("abstract method called");
            return false;
        }

        public function get isTeamKiller():Boolean
        {
            //throw new IllegalOperationError("abstract method called");
            return false;
        }

        public function get isCurrentPlayer():Boolean
        {
            //throw new IllegalOperationError("abstract method called");
            return false;
        }

        public function get squadIndex():Number
        {
            //throw new IllegalOperationError("abstract method called");
            return NaN;
        }

        public function get rankLevel():Number
        {
            //throw new IllegalOperationError("abstract method called");
            return NaN;
        }

        public function get index():int
        {
            //throw new IllegalOperationError("abstract method called");
            return -1;
        }

        public function get position():Number
        {
            //throw new IllegalOperationError("abstract method called");
            return NaN;
        }

        public function get vehCD():int
        {
            //throw new IllegalOperationError("abstract method called");
            return 0;
        }

        public function get vehicleData():VOVehicleData
        {
            //throw new IllegalOperationError("abstract method called");
            return null;
        }

        public function get marksOnGun():Number
        {
            //throw new IllegalOperationError("abstract method called");
            return NaN;
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
