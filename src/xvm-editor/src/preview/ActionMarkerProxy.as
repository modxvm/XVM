package preview
{

import flash.display.MovieClip;
import preview.*;

public class ActionMarkerProxy extends AbstractAccessProxy
{
   /**
    * This proxy class is only for access restriction to wot.VehicleMarkersManager.Xvm
    */

    public function ActionMarkerProxy(xvm:Xvm)
    {
        super(xvm);
    }

    public function get actionMarker():MovieClip
    {
        return xvm.proxy.actionMarker;
    }
}

}
