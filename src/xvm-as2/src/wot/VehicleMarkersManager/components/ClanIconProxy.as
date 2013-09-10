import wot.VehicleMarkersManager.AbstractAccessProxy;
import wot.VehicleMarkersManager.Xvm;

class wot.VehicleMarkersManager.components.ClanIconProxy extends AbstractAccessProxy
{
   /**
    * This proxy class is only for access restriction to wot.VehicleMarkersManager.Xvm
    */

    public function ClanIconProxy(xvm:Xvm)
    {
        super(xvm);
    }

    public function get playerName():String
    {
        return xvm.m_playerFullName;
    }
}
