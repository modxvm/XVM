package preview
{

import flash.display.MovieClip;
import utils.*;
import preview.*;

public class VehicleTypeComponent
{
    private var proxy:VehicleTypeProxy;

    private var m_hunt;
    private var m_markerLabel;  // [proxy] "green", "gold", "blue", "yellow", "red", "purple"
    private var m_markerState;  // [proxy.marker] "dead", "immediate_dead", ...
    private var m_vehicleClass; // [proxy.marker.marker.icon] "lightTank", "mediumTank", ..., "dynamic" (speaker)

    public function VehicleTypeComponent(proxy:VehicleTypeProxy, vehicleClass, hunt)
    {
        this.proxy = proxy;

        m_markerLabel = null;
        m_markerState = null;

        m_vehicleClass = vehicleClass;
        m_hunt = hunt;
    }

    public function getVehicleClass():String
    {
        return m_vehicleClass;
    }

    public function updateState(state_cfg:Object)
    {
        var cfg = state_cfg.vehicleIcon;

        var visible = cfg.visible || (proxy.isSpeaking && cfg.showSpeaker);

        if (visible)
            draw(cfg);

    }

    // PRIVATE FUNCTIONS

    private function draw(cfg:Object)
    {
        var x = cfg.scaleX * cfg.maxScale / 100;
        var y = cfg.scaleY * cfg.maxScale / 100;
        for (var childName in proxy.marker.marker)
        {
            //if (childName == "marker_shadow")
            //  return;

            var icon: MovieClip = proxy.marker.marker[childName];
            icon._x = x;
            icon._y = y;
            icon._xscale = icon._yscale = cfg.maxScale;

            //var ms: MovieClip = icon.duplicateMovieClip("marker_shadow", icon.getNextHighestDepth());
            //ms.gotoAndStop(icon._currentframe);
            //ms.filters = [ new DropShadowFilter(0, 0, 0, 1, 1, 1, 10, 1, false, true) ];
            //GraphicsUtil.setColor(icon, systemColor);
        }

        proxy.marker._x = cfg.x;
        proxy.marker._y = cfg.y;
        proxy.marker._alpha = proxy.formatDynamicAlpha(cfg.alpha);
    }
}

}
