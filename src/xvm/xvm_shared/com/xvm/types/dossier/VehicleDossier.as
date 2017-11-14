/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.types.dossier
{
    public class VehicleDossier extends DossierBase
    {
        public function VehicleDossier(data:Object)
        {
            super(data);
        }

        public var vehCD:int;
        public var xtdb:int;
        public var xte:int;
        public var wtr:int;
        public var xwtr:int;
        public var earnedXP:Number;
        public var freeXP:Number;
        public var xpToElite:Number;
        public var xpToEliteLeft:Number;
        public var damageRating:Number;
        public var marksOnGun:Number;
        public var rankCount:Number;
        public var rankSteps:Number;
        public var rankStepsTotal:Number;
    }
}
