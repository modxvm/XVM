import com.xvm.*;
import com.xvm.DataTypes.*;
import wot.VehicleMarkersManager.*;

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
        var vdata:VehicleData = VehicleInfo.get(xvm.m_vid);

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
