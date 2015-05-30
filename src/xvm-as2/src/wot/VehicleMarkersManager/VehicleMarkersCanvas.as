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

        GlobalEventDispatcher.addEventListener(Defines.E_CONFIG_LOADED, StatLoader.LoadData);
        GlobalEventDispatcher.addEventListener(Defines.E_CONFIG_LOADED, onConfigLoaded);
        ExternalInterface.addCallback(Cmd.RESPOND_CONFIG, Config.instance, Config.instance.GetConfigCallback);
        ExternalInterface.addCallback(Cmd.RESPOND_DYNAMIC_SQUAD_CREATED, this, onDynamicSquadCreated);
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
                marker.update();
            }
        }
    }

    private function onDynamicSquadCreated(playerName:String, squadIndex:Number, isSelf:Boolean)
    {
        Macros.UpdateDynamicSquad(playerName, squadIndex, isSelf);
    }
}
