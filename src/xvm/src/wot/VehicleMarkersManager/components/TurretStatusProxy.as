import wot.VehicleMarkersManager.AbstractAccessProxy;
import wot.VehicleMarkersManager.XVM;
import wot.VehicleMarkersManager.components.TurretStatusDatabase;
import wot.utils.VehicleInfo;

class wot.VehicleMarkersManager.components.TurretStatusProxy extends AbstractAccessProxy
{
   /**
    * Restricts access to XVM.
    * Queries TurretStatusDatabase.
    */
   
    public function TurretStatusProxy(xvm:XVM) 
    {
        super(xvm);
    }
    
    public function get defaultIconSource():String
    {
        return xvm.m_defaultIconSource;
    }
    
    public function get maxHealth():Number
    {
        return xvm.m_maxHealth;
    }
    
    public function get vehicleName():String
    {
        return VehicleInfo.getVehicleId(xvm.m_defaultIconSource).toLowerCase();
    }
    
    public static function getInfo(name:String):Array
    {
        var db = TurretStatusDatabase.getDb();
        return db[name];
    }
}

