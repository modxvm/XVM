import wot.VehicleMarkersManager.AbstractAccessProxy;
import wot.VehicleMarkersManager.Xvm;

class wot.VehicleMarkersManager.components.ActionMarkerProxy extends AbstractAccessProxy
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
        return xvm.wrapper.actionMarker;
    }
}
