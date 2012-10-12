import wot.VehicleMarkersManager.AbstractAccessProxy;
import wot.VehicleMarkersManager.Xvm;
//import wot.utils.Logger;

class wot.VehicleMarkersManager.VehicleStateProxy extends AbstractAccessProxy
{
   /* This proxy class is only for VehicleState
    * access restriction to wot.VehicleMarkersManager.Xvm
    */

    public function VehicleStateProxy(xvm:Xvm)
    {
        super(xvm);
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
        return xvm.proxy.m_team;
    }
}