import wot.VehicleMarkersManager.AbstractAccessProxy;
import wot.VehicleMarkersManager.Xvm;

class wot.VehicleMarkersManager.components.HealthBarProxy extends AbstractAccessProxy
{
   /**
    * This proxy class is only for access restriction to wot.VehicleMarkersManager.Xvm
    */

    public function HealthBarProxy(xvm:Xvm)
    {
        super(xvm);
    }

    public function createHolder():MovieClip
    {
        return xvm.wrapper.createEmptyMovieClip("xvm_healthBar", xvm.wrapper.marker.getDepth() - 1); // Put health Bar to back.
    }

    public function get curHealth():Number
    {
        return xvm.m_curHealth;
    }

    public function get maxHealth():Number
    {
        return xvm.m_maxHealth;
    }
}
