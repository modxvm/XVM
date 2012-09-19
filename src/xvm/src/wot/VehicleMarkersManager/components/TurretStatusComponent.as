import wot.VehicleMarkersManager.components.TurretStatusProxy;

class wot.VehicleMarkersManager.components.TurretStatusComponent
{
    /**
     * Marks stock turret tanks
     * based on corresponding tank maximum hitpoints.
     * Author: ilitvinov87@gmail.com
     */

    /**
     * High vulnerability.
     * Top turret unlocks new gun.
     * Player with stock turret can not mount top gun.
     */
    private static var HIGH_VULN_DISPLAY_MARKER: String = "*";
    private static var HIGH_VULN_DATABASE_VAL: Number = 2;

    /**
     * Low vulnerability
     * Top turret does not unlock new gun.
     * Player with stock turret can mount top gun.
     */
    private static var LOW_VULN_DISPLAY_MARKER: String = "-";
    private static var LOW_VULN_DATABASE_VAL: Number = 1;

    /**
     * Can not define rootNode modules vulnerability status.
     * Vehicle module configuration has only one default turret.
     */
    private static var UNKNOWN_VULN_DISPLAY_MARKER: String = "";
    private static var UNKNOWN_VULN_DATABASE_VAL: Number = 0;

    private var proxy:TurretStatusProxy;

    private var marker:String;

    public function TurretStatusComponent(proxy:TurretStatusProxy)
    {
        this.proxy = proxy;
        defineMarker();
    }

    public function getMarker():String
    {
        return marker;
    }

    // -- Internals

    private function defineMarker()
    {
        var status:Number = proxy.defineVehicleStatus();

        if      ( status == HIGH_VULN_DATABASE_VAL )
                  marker =  HIGH_VULN_DISPLAY_MARKER;
        else if ( status == LOW_VULN_DATABASE_VAL )
                  marker =  LOW_VULN_DISPLAY_MARKER;
        else if ( status == UNKNOWN_VULN_DATABASE_VAL)
                  marker =  UNKNOWN_VULN_DISPLAY_MARKER;
    }
}
