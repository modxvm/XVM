import wot.VehicleMarkersManager.ColorsManager;
import wot.VehicleMarkersManager.ErrorHandler;
import wot.VehicleMarkersManager.components.VehicleTypeProxy;

class wot.VehicleMarkersManager.components.VehicleTypeComponent
{
    // Fix markers centering
    private static var MARKER_CENTER_OFFSET_X = -9.5;
    private static var MARKER_CENTER_OFFSET_Y = {
        $lightTank: -23.5,
        $mediumTank: -24.5,
        $heavyTank: -29.5,
        $AT_SPG: -20.5,
        $SPG: -20.5,
        $dynamic: -22.5
    }

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

    private function getFrameName()
    {
        return (proxy.isSpeaking && !proxy.isDead) ? "dynamic" : m_vehicleClass;
    }
    
    public function setVehicleClass()
    {
        //com.xvm.Logger.add("setVehicleClass: " + m_vehicleClass);

        var frameName = getFrameName();

        var icon = null;
        if (proxy.marker.marker.iconHunt == null)
        {
            icon = proxy.marker.marker.icon;
        }
        else
        {
            proxy.marker.marker.icon._visible = !m_hunt;
            proxy.marker.marker.iconHunt._visible = m_hunt;
            icon = m_hunt ? proxy.marker.marker.iconHunt : proxy.marker.marker.icon;
        }
        icon.gotoAndStop(frameName);
    }

    public function setMarkerState(value)
    {
        //com.xvm.Logger.add("setMarkerState: " + value);
        m_markerState = value;
        proxy.marker.gotoAndPlay(m_markerState);

        if (proxy.isDead && proxy.isSpeaking) // change dynamic to vehicle type marker for dead while speaking
            this.setVehicleClass();
    }

    public function updateMarkerLabel()
    {
        //com.xvm.Logger.add("updateMarkerLabel: " + m_markerLabel + " " + m_markerState);
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
        var x = (cfg.scaleX + MARKER_CENTER_OFFSET_X) * cfg.maxScale / 100;
        var y = (cfg.scaleY + MARKER_CENTER_OFFSET_Y["$" + getFrameName().split("-").join("_")]) * cfg.maxScale / 100;

        // WARNING: do not touch proxy.marker.marker - dead status will be broken
        
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


        proxy.marker._x = cfg.x //* cfg.maxScale / 100;
        proxy.marker._y = cfg.y //* cfg.maxScale / 100;
        proxy.marker._alpha = proxy.formatDynamicAlpha(cfg.alpha);
    }
}
