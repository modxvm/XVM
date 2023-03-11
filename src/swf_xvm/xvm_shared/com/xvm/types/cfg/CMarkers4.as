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
        public var hoverMarker:CMarkersHoverMarker;
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

        internal function applyGlobalMacros():void
        {
            if (actionMarker)
            {
                actionMarker.applyGlobalMacros();
            }
            if (hoverMarker)
            {
                hoverMarker.applyGlobalMacros();
            }
            if (contourIcon)
            {
                contourIcon.applyGlobalMacros();
            }
            if (damageIndicator)
            {
                damageIndicator.applyGlobalMacros();
            }
            if (healthBar)
            {
                healthBar.applyGlobalMacros();
            }
            if (levelIcon)
            {
                levelIcon.applyGlobalMacros();
            }
            if (vehicleIcon)
            {
                vehicleIcon.applyGlobalMacros();
            }
            if (vehicleStatusMarker)
            {
                vehicleStatusMarker.applyGlobalMacros();
            }
        }
    }
}
