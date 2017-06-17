/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * http://www.modxvm.com/
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CMarkers4 implements ICloneable
    {
        public var vehicleIcon:CMarkersVehicleIcon;
        public var healthBar:CMarkersHealthBar;
        public var damageText:CMarkersDamageText;
        public var damageTextPlayer:CMarkersDamageText;
        public var damageTextSquadman:CMarkersDamageText;
        public var contourIcon:CMarkersContourIcon;
        public var levelIcon:CMarkersLevelIcon;
        public var actionMarker:CMarkersActionMarker;
        public var stunMarker:CMarkersStunMarker;
        public var textFields:Array;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }

        internal function applyGlobalBattleMacros():void
        {
            if (vehicleIcon)
            {
                vehicleIcon.applyGlobalBattleMacros();
            }
            if (healthBar)
            {
                healthBar.applyGlobalBattleMacros();
            }
            if (contourIcon)
            {
                contourIcon.applyGlobalBattleMacros();
            }
            if (levelIcon)
            {
                levelIcon.applyGlobalBattleMacros();
            }
            if (actionMarker)
            {
                actionMarker.applyGlobalBattleMacros();
            }
            if (stunMarker)
            {
                stunMarker.applyGlobalBattleMacros();
            }
        }
    }
}
