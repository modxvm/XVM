import wot.VehicleMarkersManager.AbstractAccessProxy;
import wot.VehicleMarkersManager.XVM;
//import wot.utils.Logger;

class wot.VehicleMarkersManager.VehicleStateProxy extends AbstractAccessProxy
{
   /* This proxy class is only for VehicleState
    * access restriction to wot.VehicleMarkersManager.XVM
    */
   
    public function VehicleStateProxy(xvm:XVM) 
    {
        super(xvm);
    }
    
    public function get vehicleDestroyed():Boolean
    {
        return xvm["vehicleDestroyed"]; // FIXIT
    }
    
    public function get isDead():Boolean
    {
        return xvm.m_isDead;
    }
    
    public function get showExInfo():Boolean
    {
        return xvm.m_showExInfo;
    }
    
    public function get team():String
    {
        return xvm.m_team;
    }
}