/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.vehiclemarkers.ui
{
    import net.wg.gui.battle.views.vehicleMarkers.VO.*;

    public class XvmVehicleMarkerConstants
    {
        public static const DISABLED_MARKER_SETTINGS:VehicleMarkerSettings = new VehicleMarkerSettings();
        DISABLED_MARKER_SETTINGS.markerBaseHp = HPDisplayMode.HIDDEN;
        DISABLED_MARKER_SETTINGS.markerBaseIcon = false;
        DISABLED_MARKER_SETTINGS.markerBaseLevel = false;
        DISABLED_MARKER_SETTINGS.markerBaseHpIndicator = false;
        DISABLED_MARKER_SETTINGS.markerBaseDamage = false;
        DISABLED_MARKER_SETTINGS.markerBaseVehicleName = false;
        DISABLED_MARKER_SETTINGS.markerBasePlayerName = false;
        DISABLED_MARKER_SETTINGS.markerAltHp = HPDisplayMode.HIDDEN;
        DISABLED_MARKER_SETTINGS.markerAltIcon = false;
        DISABLED_MARKER_SETTINGS.markerAltLevel = false;
        DISABLED_MARKER_SETTINGS.markerAltHpIndicator = false;
        DISABLED_MARKER_SETTINGS.markerAltDamage = false;
        DISABLED_MARKER_SETTINGS.markerAltVehicleName = false;
        DISABLED_MARKER_SETTINGS.markerAltPlayerName = false;

        // turret
        public static const TURRET_HIGH_VULN_DATABASE_VAL:int = 2;
        public static const TURRET_LOW_VULN_DATABASE_VAL:int = 1;
        public static const TURRET_UNKNOWN_VULN_DATABASE_VAL:int = 0;
    }
}
