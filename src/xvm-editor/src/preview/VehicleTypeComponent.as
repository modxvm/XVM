package preview
{

import flash.display.MovieClip;

import preview.*;

import utils.*;

public class VehicleTypeComponent
{
    private var proxy:VehicleTypeProxy;

    private var m_hunt:Boolean;
    private var m_markerLabel:String;  // [proxy] "green", "gold", "blue", "yellow", "red", "purple"
    private var m_markerState:String;  // [proxy.marker] "dead", "immediate_dead", ...
    private var m_vehicleClass:String; // [proxy.marker.marker.icon] "lightTank", "mediumTank", ..., "dynamic" (speaker)

    public function VehicleTypeComponent(proxy:VehicleTypeProxy, vehicleClass:String, hunt:Boolean)
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

    public function updateState(state_cfg:Object):void
    {
        var cfg:Object = state_cfg.vehicleIcon;

        var visible:Boolean = cfg.visible || cfg.showSpeaker;

        if (visible)
            draw(cfg);

		proxy.marker.visible = visible;
    }

    // PRIVATE FUNCTIONS

    private function draw(cfg:Object):void
    {
		proxy.marker.marker.icon.gotoAndStop(cfg.visible ? m_vehicleClass : "dynamic");
		if (cfg.visible)
			proxy.setMarkerLabel(proxy.isDead == false ? "normal" : "immediate_dead");
		proxy.marker.marker.scaleX = proxy.marker.marker.scaleY = proxy.xvm.proxy._zoom;
		proxy.marker.x = cfg.x;
		proxy.marker.y = cfg.y;
		proxy.marker.marker.alpha = proxy.formatDynamicAlpha(cfg.alpha) / 100.0;
		proxy.marker.marker.icon.x = cfg.scaleX * cfg.maxScale / 100;
		proxy.marker.marker.icon.y = cfg.scaleY * cfg.maxScale / 100;
		proxy.marker.marker.icon.scaleX = proxy.marker.marker.icon.scaleY = cfg.maxScale / 100;
		GraphicsUtil.colorize(proxy.marker, proxy.formatDynamicColor(proxy.formatStaticColorText(cfg.color)), 0.8); // 20% darker to improve appearance
    }
}

}
