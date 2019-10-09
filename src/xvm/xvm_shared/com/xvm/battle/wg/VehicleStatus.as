/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.battle.wg
{
    public class VehicleStatus
    {
        public static const DEFAULT:uint = 0x00;
        public static const IS_ALIVE:uint = 0x01;
        public static const IS_READY:uint = 0x02;
        public static const NOT_AVAILABLE:uint = 0x04;
        public static const STOP_RESPAWN:uint = 0x08;

        [Inline]
        public static function isAlive(param1:uint) : Boolean
        {
            return (param1 & VehicleStatus.IS_ALIVE) > 0;
        }

        [Inline]
        public static function isNotAvailable(param1:uint) : Boolean
        {
            return (param1 & VehicleStatus.NOT_AVAILABLE) > 0;
        }

        [Inline]
        public static function isReady(param1:uint) : Boolean
        {
            return (param1 & VehicleStatus.IS_READY) > 0;
        }

        [Inline]
        public static function isStopRespawn(param1:uint) : Boolean
        {
            return (param1 & VehicleStatus.STOP_RESPAWN) > 0;
        }
    }
}
