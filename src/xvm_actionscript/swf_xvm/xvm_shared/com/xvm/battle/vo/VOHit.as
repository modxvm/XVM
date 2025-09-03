/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.battle.vo
{
    public class VOHit
    {
        public var vehicleID:Number;
        public var damage:int;
        public var damageType:String;
        public var hist:String;

        public function VOHit(vehicleID:Number = 0, damage:int = 0, damageType:String = null, hist:String = null)
        {
            this.vehicleID = vehicleID;
            this.damage = damage;
            this.damageType = damageType;
            this.hist = hist;
        }
    }
}
