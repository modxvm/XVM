import wot.VehicleMarkersManager.components.TurretStatusProxy;
import wot.utils.Logger;

class wot.VehicleMarkersManager.components.TurretStatusComponent
{
    var proxy:TurretStatusProxy
    
    public function TurretStatusComponent(proxy:TurretStatusProxy) 
    {
        this.proxy = proxy;
    }
     
    public function getString():String
    {
        Logger.add("TurretStatusComponent.getString()");
        return "#";
        // circle & half-circle? box & half-box
    }
}