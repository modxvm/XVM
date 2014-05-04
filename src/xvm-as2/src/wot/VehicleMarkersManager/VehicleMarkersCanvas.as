/**
 * Proxy class for vehicle marker canvas
 * Used only for config preloading in the begin of the battle
 */
import com.xvm.*;
import flash.external.*;

class wot.VehicleMarkersManager.VehicleMarkersCanvas
{
    /////////////////////////////////////////////////////////////////
    private var wrapper:net.wargaming.ingame.VehicleMarkersCanvas;
    private var base:net.wargaming.ingame.VehicleMarkersCanvas;

    public function VehicleMarkersCanvas(wrapper:net.wargaming.ingame.VehicleMarkersCanvas, base:net.wargaming.ingame.VehicleMarkersCanvas)
    {
        this.wrapper = wrapper;
        this.base = base;
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
        GlobalEventDispatcher.addEventListener(Config.E_CONFIG_LOADED, onConfigLoaded);
        ExternalInterface.addCallback(Cmd.RESPOND_CONFIG, Config.instance, Config.instance.GetConfigCallback);
    }

    private function onConfigLoaded()
    {
        for (var i in _root.vehicleMarkersCanvas)
        {
            var marker:net.wargaming.ingame.VehicleMarker = _root.vehicleMarkersCanvas[i];
            if (marker != null)
            {
                if (Config.config.markers.useStandardMarkers == true)
                    marker.marker.marker.icon["_xvm_colorized"] = false;
                marker.m_markerLabel = "";
                marker.updateMarkerLabel();
                //var e = marker.m_entityName;
                //marker.setEntityName("");
                //marker.setEntityName(e);
                marker.update();
/*                if (Config.config.markers.useStandardMarkers == true)
                {
                    marker.marker.marker.icon["_xvm_colorized"] = false;
                    marker.initMarkerLabel();
                    marker.update();
                }
                else
                {
                    var x:wot.VehicleMarkersManager.Xvm = wot.VehicleMarkersManager.Xvm(marker);
                    if (x != null)
                    {
                        x.vehicleTypeComponent.
                        x.update();
                    }
                }*/
            }
        }
    }
}
