/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CMarkers4 implements ICloneable
    {
        public var actionMarker:CMarkersActionMarker;
        public var contourIcon:CMarkersContourIcon;
        public var damageIndicator:CMarkersDamageIndicator;
        public var damageText:CMarkersDamageText;
        public var damageTextPlayer:CMarkersDamageText;
        public var damageTextSquadman:CMarkersDamageText;
        public var healthBar:CMarkersHealthBar;
        public var levelIcon:CMarkersLevelIcon;
        public var textFields:Array;
        public var vehicleIcon:CMarkersVehicleIcon;
        public var vehicleStatusMarker:CMarkersVehicleStatusMarker;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }

        internal function applyGlobalBattleMacros():void
        {
            if (actionMarker)
            {
                actionMarker.applyGlobalBattleMacros();
            }
            if (contourIcon)
            {
                contourIcon.applyGlobalBattleMacros();
            }
            if (damageIndicator)
            {
                damageIndicator.applyGlobalBattleMacros();
            }
            if (healthBar)
            {
                healthBar.applyGlobalBattleMacros();
            }
            if (levelIcon)
            {
                levelIcon.applyGlobalBattleMacros();
            }
            if (vehicleIcon)
            {
                vehicleIcon.applyGlobalBattleMacros();
            }
            if (vehicleStatusMarker)
            {
                vehicleStatusMarker.applyGlobalBattleMacros();
            }
        }
    }
}
