/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.battle.wg
{
    public class VehicleStatus extends Object
    {

        public static const DEFAULT:uint = 0;

        public static const IS_ALIVE:uint = 1;

        public static const IS_READY:uint = 2;

        public static const NOT_AVAILABLE:uint = 4;

        public static const STOP_RESPAWN:uint = 8;

        public function VehicleStatus()
        {
            super();
        }

        public static function isAlive(param1:uint) : Boolean
        {
            return (param1 & VehicleStatus.IS_ALIVE) > 0;
        }

        public static function isNotAvailable(param1:uint) : Boolean
        {
            return (param1 & VehicleStatus.NOT_AVAILABLE) > 0;
        }

        public static function isReady(param1:uint) : Boolean
        {
            return (param1 & VehicleStatus.IS_READY) > 0;
        }

        public static function isStopRespawn(param1:uint) : Boolean
        {
            return (param1 & VehicleStatus.STOP_RESPAWN) > 0;
        }
    }
}
