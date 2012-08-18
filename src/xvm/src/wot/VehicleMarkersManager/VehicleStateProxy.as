import wot.VehicleMarkersManager.AbstractAccessProxy;
import wot.VehicleMarkersManager.XVM;

class wot.VehicleMarkersManager.VehicleStateProxy extends AbstractAccessProxy
{
   /* This proxy class is only for VehicleState
    * access restriction to wot.VehicleMarkersManager.XVM
    */
   
    public function VehicleStateProxy(xvm:XVM) 
    {
        super(xvm);
    }
    
    public function get team():String
    {
        return xvm.m_team;
        // TODO: move m_team inside as private
    }
    
    public function get vehicleDestroyed():Boolean
    {
        return xvm.vehicleDestroyed;
    }
    
    public function get isDead():Boolean
    {
        return xvm.m_isDead;
    }
    
    public function get showExInfo():Boolean
    {
        return xvm.m_showExInfo;
    }
}