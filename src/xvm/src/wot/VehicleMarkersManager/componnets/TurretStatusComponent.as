import wot.VehicleMarkersManager.componnets.TurretStatusProxy;
import wot.utils.Logger;

class wot.VehicleMarkersManager.componnets.TurretStatusComponent
{
    var proxy:TurretStatusProxy
    
    public function TurretStatusComponent(proxy:TurretStatusProxy) 
    {
        this.proxy = proxy;
    }
     
    public function getString():String
    {
        Logger.add("TurretStatusComponent.getString()");
        return "";
    }
}