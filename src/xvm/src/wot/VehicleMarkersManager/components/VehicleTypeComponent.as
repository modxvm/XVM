import wot.VehicleMarkersManager.ColorsManager;
import wot.VehicleMarkersManager.ErrorHandler;
import wot.VehicleMarkersManager.components.VehicleTypeProxy;

class wot.VehicleMarkersManager.components.VehicleTypeComponent
{
    private var proxy:VehicleTypeProxy;

    private var m_hunt;
    private var m_markerLabel;  // [proxy] "green", "gold", "blue", "yellow", "red", "purple"
    private var m_markerState;  // [proxy.marker] "dead", "immediate_dead", ...
    private var m_vehicleClass; // [proxy.marker.marker.icon] "lightTank", "mediumTank", ..., "dynamic" (speaker)

    public function VehicleTypeComponent(proxy:VehicleTypeProxy)
    {
        this.proxy = proxy;

        m_markerLabel = null;
        m_markerState = null;
    }

    public function init(vehicleClass, hunt)
    {
        m_vehicleClass = vehicleClass;
        m_hunt = hunt;

        updateMarkerLabel();
    }

    public function setVehicleClass()
    {
        var className = (proxy.isSpeaking && !proxy.isDead) ? "dynamic" : m_vehicleClass;

        if (proxy.marker.marker.iconHunt == null)
        {
            proxy.marker.marker.icon.gotoAndStop(className);
        }
        else
        {
            proxy.marker.marker.icon._visible = !m_hunt;
            proxy.marker.marker.iconHunt._visible = m_hunt;
            if (m_hunt)
                proxy.marker.marker.iconHunt.gotoAndStop(className);
            else
                proxy.marker.marker.icon.gotoAndStop(className);
        }
    }

    public function getVehicleClass():String
    {
        return m_vehicleClass;
    }

    function setMarkerState(value)
    {
        m_markerState = value;
        proxy.marker.gotoAndPlay(m_markerState);

        if (proxy.isDead && proxy.isSpeaking) // change dynamic to vehicle type marker for dead while speaking
            this.setVehicleClass();
    }

    function updateMarkerLabel()
    {
        var aliasColor = ColorsManager.getMarkerColorAlias(proxy.entityName, proxy.isColorBlindMode);
        if (m_markerLabel == aliasColor)
            return;

        m_markerLabel = aliasColor;
        proxy.setMarkerLabel(m_markerLabel);

        if (m_vehicleClass == null)
            ErrorHandler.setText("INTERNAL ERROR: m_vehicleClass == null");

        if (m_markerState != null)
        {
            if (proxy.isDead)
                m_markerState = "immediate_dead";
            proxy.marker.gotoAndPlay(m_markerState);
        }

        this.setVehicleClass();
    }

    public function updateState(state_cfg:Object)
    {
        var cfg = state_cfg.vehicleIcon;

        var visible = cfg.visible || (proxy.isSpeaking && cfg.showSpeaker);

        if (visible)
            draw(cfg);

        proxy.marker._visible = visible;

    }

    // PRIVATE FUNCTIONS

    private function draw(cfg:Object)
    {
        var x = cfg.scaleX * cfg.maxScale / 100;
        var y = cfg.scaleY * cfg.maxScale / 100;

        // Fix markers centering (TODO)
        proxy.marker.marker._x = -8;
        proxy.marker.marker._y = -16;

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
