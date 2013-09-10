import com.xvm.Wrapper;

class wot.wrapper.VehicleMarkersManager.VehicleMarkersCanvas extends net.wargaming.ingame.VehicleMarkersCanvas
{
    function VehicleMarkersCanvas()
    {
        super();

        var OVERRIDE_FUNCTIONS:Array = [
           // requires .ctor() only
        ];
        Wrapper.override(this, new wot.VehicleMarkersManager.VehicleMarkersCanvas(this, super), OVERRIDE_FUNCTIONS);
    }
}
