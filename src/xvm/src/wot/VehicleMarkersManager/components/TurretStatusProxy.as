import wot.VehicleMarkersManager.AbstractAccessProxy;
import wot.VehicleMarkersManager.Xvm;
import wot.utils.VehicleInfo;
import wot.utils.Config

class wot.VehicleMarkersManager.components.TurretStatusProxy extends AbstractAccessProxy
{
   /**
    * Model for TurretStatus.
    * Queries TurretStatusDatabase.
    */

    public function TurretStatusProxy(xvm:Xvm)
    {
        super(xvm);
    }

    public function defineVehicleStatus():Number
    {
        var vehInfo:Object = VehicleInfo.getInfo2(vehicleName);

        // If database stock max hp == current vehicle max hp
        if (vehInfo.hpstock == xvm.m_maxHealth)
            /**
             * Current vehicle has stock turret.
             * Return vulnerability status.
             */
            return vehInfo.turretstatus;

        return 0; // Turret status unknown
    }

    public function getHighVulnDisplayMarker():String
    {
        return Config.s_config.turretMarkers.highVulnerability;
    }

    public function getLowVulnDisplayMarker():String
    {
        return Config.s_config.turretMarkers.lowVulnerability;
    }

    private function get vehicleName():String
    {
        return VehicleInfo.getVehicleId(xvm.m_defaultIconSource).toLowerCase();
    }
}
