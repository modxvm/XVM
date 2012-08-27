import wot.VehicleMarkersManager.components.TurretStatusProxy;
import wot.utils.VehicleInfo;
//import wot.utils.Logger;

class wot.VehicleMarkersManager.components.TurretStatusComponent
{
    private var proxy:TurretStatusProxy
    
    private var status:String
    
    public function TurretStatusComponent(proxy:TurretStatusProxy) 
    {
        this.proxy = proxy;
        defineStatus();
        VehicleInfo.getInfo(proxy.defaultIconSource);
    }
    
    private function defineStatus()
    {
        status = "*";
    }
     
    public function getString():String
    {
        return status;
    }
}