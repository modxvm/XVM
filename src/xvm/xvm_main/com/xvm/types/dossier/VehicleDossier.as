/**
 * XFW
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.types.dossier
{
    import com.xfw.*;

    public class VehicleDossier extends DossierBase
    {
        public function VehicleDossier(data:Object)
        {
            super(data);
        }

        public var vehId:int;
        public var xte:Number;
        public var earnedXP:Number;
        public var freeXP:Number;
        public var xpToElite:Number;
        public var xpToEliteLeft:Number;
        public var damageRating:Number;
        public var marksOnGun:Number;
    }
}
