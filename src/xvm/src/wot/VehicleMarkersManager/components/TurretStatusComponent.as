import wot.VehicleMarkersManager.components.TurretStatusProxy;
//import wot.utils.Logger;

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
    private static var VULN_STATUS_UNKNOWN: Number = 0;
    
    private var proxy:TurretStatusProxy
    
    private var marker:String
        
    public function TurretStatusComponent(proxy:TurretStatusProxy) 
    {
        this.proxy = proxy;

        //VehicleInfo.getInfo(proxy.defaultIconSource);
        defineMarker();
    }
    
    public function getMarker():String
    {
        return marker;
    }
    
    // -- Internals
    
    private function defineMarker()
    {
        var status:Number = defineVehicleStatus();
        if      ( status == HIGH_VULN_DATABASE_VAL )
                  marker =  HIGH_VULN_DISPLAY_MARKER;
        else if ( status == LOW_VULN_DATABASE_VAL )
                  marker =  LOW_VULN_DISPLAY_MARKER;
        else      marker = "";
    }
    
    private function defineVehicleStatus():Number
    {
        var vehInfo:Array = TurretStatusProxy.getInfo(proxy.vehicleName);
        if (vehInfo == null)
        {
            //Logger.add(proxy.vehicleName + " -");
            return VULN_STATUS_UNKNOWN;
        }
        //Logger.add(proxy.vehicleName + " FOUND at database!");
        //Logger.add("vehInfo = " + vehInfo);
        // If database stock max hp == current vehicle max hp
        if ( vehInfo[0] == proxy.maxHealth) 
        {
            //Logger.add("! HP EQUALS; stock turret")
            /**
             * Current vehicle has stock turret.
             * Return vulnerability status.
             */
            return vehInfo[1]; 
        }
    }
}








