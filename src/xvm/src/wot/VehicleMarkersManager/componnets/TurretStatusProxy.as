import wot.VehicleMarkersManager.AbstractAccessProxy;
import wot.VehicleMarkersManager.XVM;

class wot.VehicleMarkersManager.componnets.TurretStatusProxy extends AbstractAccessProxy
{
   /* This proxy class is only for LevelIconComponent
    * access restriction to wot.VehicleMarkersManager.XVM
    */
   
    public function TurretStatusProxy(xvm:XVM) 
    {
        super(xvm);
    }
    
    public function get levelIcon():MovieClip
    {
        return xvm.levelIcon;
    }
    
    public function get maxHealth():Number
    {
        return xvm["m_maxHealth"];
    }
}