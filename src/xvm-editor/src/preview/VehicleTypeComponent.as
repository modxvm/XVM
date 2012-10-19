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

        var visible = cfg.visible || cfg.showSpeaker;

        if (visible)
            draw(cfg);

		proxy.marker.visible = visible;
    }

    // PRIVATE FUNCTIONS

    private function draw(cfg:Object)
    {
		proxy.marker.marker.icon.gotoAndStop(cfg.visible ? m_vehicleClass : "dynamic");
		proxy.marker.x = cfg.x;
		proxy.marker.y = cfg.y;
		proxy.marker.marker.alpha = proxy.formatDynamicAlpha(cfg.alpha) / 100.0;
		proxy.marker.marker.icon.x = cfg.scaleX * cfg.maxScale / 100;
		proxy.marker.marker.icon.y = cfg.scaleY * cfg.maxScale / 100;
		proxy.marker.marker.icon.scaleX = proxy.marker.marker.icon.scaleY = cfg.maxScale / 100;
    }
}

}
