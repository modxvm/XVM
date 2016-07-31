/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.vehiclemarkers.ui
{
    import net.wg.gui.battle.views.vehicleMarkers.VO.*;

    public class XvmVehicleMarkerConstants extends Object
    {
        public static const DISABLED_MARKER_SETTINGS:Object = {
            "markerAltVehicleName": false,
            "markerBaseLevel": false,
            "markerAltHp": HPDisplayMode.HIDDEN,
            "markerAltHpIndicator": false,
            "markerAltLevel": false,
            "markerBasePlayerName": false,
            "markerAltPlayerName": false,
            "markerBaseHpIndicator": false,
            "markerBaseHp": HPDisplayMode.HIDDEN,
            "markerBaseVehicleName": false,
            "markerAltIcon": false,
            "markerAltDamage": false,
            "markerBaseDamage": false,
            "markerBaseIcon": false
        };

        // turret
        public static const TURRET_HIGH_VULN_DATABASE_VAL:int = 2;
        public static const TURRET_LOW_VULN_DATABASE_VAL:int = 1;
        public static const TURRET_UNKNOWN_VULN_DATABASE_VAL:int = 0;
    }
}
