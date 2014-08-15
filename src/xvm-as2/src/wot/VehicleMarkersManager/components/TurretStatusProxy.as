import wot.VehicleMarkersManager.AbstractAccessProxy;
import wot.VehicleMarkersManager.Xvm;
import com.xvm.VehicleInfo;
import com.xvm.Config;
import com.xvm.DataTypes.VehicleData;

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
        var vdata:VehicleData = VehicleInfo.getByIcon(xvm.m_defaultIconSource);

        // If database stock max hp == current vehicle max hp
        if (vdata.hpStock == xvm.m_maxHealth)
            /**
             * Current vehicle has stock turret.
             * Return vulnerability status.
             */
            return vdata.turret;

        return 0; // Turret status unknown
    }

    public function getHighVulnDisplayMarker():String
    {
        return Config.config.markers.turretMarkers.highVulnerability;
    }

    public function getLowVulnDisplayMarker():String
    {
        return Config.config.markers.turretMarkers.lowVulnerability;
    }
}
