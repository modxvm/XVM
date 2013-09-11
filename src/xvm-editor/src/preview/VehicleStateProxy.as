package preview
{

import utils.*;
import preview.*;

public class VehicleStateProxy extends AbstractAccessProxy
{
   /* This proxy class is only for VehicleState
    * access restriction to wot.VehicleMarkersManager.Xvm
    */

    public function VehicleStateProxy(xvm:preview.Xvm)
    {
        super(xvm);
    }

    public function get showExInfo():Boolean
    {
        return xvm.m_showExInfo;
    }
}

}
