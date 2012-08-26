import wot.VehicleMarkersManager.AbstractAccessProxy;
import wot.VehicleMarkersManager.XVM;

class wot.VehicleMarkersManager.components.TurretStatusProxy extends AbstractAccessProxy
{
   /**
    * This proxy class is only for LevelIconComponent
    * access restriction to wot.VehicleMarkersManager.XVM
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
}