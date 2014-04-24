/**
 * Proxy class for vehicle marker canvas
 * Used only for config preloading in the begin of the battle
 */
import com.xvm.*;

class wot.VehicleMarkersManager.VehicleMarkersCanvas
{
    /////////////////////////////////////////////////////////////////

    public function VehicleMarkersCanvas(wrapper:net.wargaming.ingame.VehicleMarkersCanvas, base:net.wargaming.ingame.VehicleMarkersCanvas)
    {
        VehicleMarkersCanvasCtor();
    }

    /////////////////////////////////////////////////////////////////

    /**
     * ctor()
     */
    private function VehicleMarkersCanvasCtor()
    {
        Utils.TraceXvmModule("VMM");

        // ScaleForm optimization
        _global.gfxExtensions = true;
        _global.noInvisibleAdvance = true;

        GlobalEventDispatcher.addEventListener(Config.E_CONFIG_LOADED, StatLoader.LoadData);
        Config.LoadConfig();
    }
}
