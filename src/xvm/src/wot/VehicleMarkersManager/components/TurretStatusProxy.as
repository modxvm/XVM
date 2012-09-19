import wot.VehicleMarkersManager.AbstractAccessProxy;
import wot.VehicleMarkersManager.Xvm;
import wot.VehicleMarkersManager.components.TurretStatusDatabase;
import wot.utils.VehicleInfo;

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
        var vehInfo:Array = TurretStatusProxy.getInfo(vehicleName);

        // If database stock max hp == current vehicle max hp
        if (vehInfo[0] == xvm.m_maxHealth)
            /**
             * Current vehicle has stock turret.
             * Return vulnerability status.
             */
            return vehInfo[1];

        return 0; // Turret status unknown
    }

    private function get vehicleName():String
    {
        return VehicleInfo.getVehicleId(xvm.m_defaultIconSource).toLowerCase();
    }

    private static function getInfo(name:String):Array
    {
        var db = TurretStatusDatabase.getDb();
        return db[name];
    }
}
