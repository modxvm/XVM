import com.xvm.*;
import com.xvm.events.*;
import wot.Minimap.*;
import wot.Minimap.model.externalProxy.*;
import wot.Minimap.shapes.*;
import wot.Minimap.view.*;

class wot.Minimap.Features
{
    private static var _instance:Features;

    /**
     * Global minimap features
     */
    private var markerScaling:MarkerScaling;
    private var zoom:Zoom;
    private var mapSizeLabel:MapSizeLabel

    /**
     * Shape to icon attachments.
     * Shows game related distances and direction.
     */
    private var circles:Circles;
    private var lines:Lines;
    private var strategicAimMarker:StrategicAimMarker;

    /**
     * Invoked when config loaded
     */
    public static function init():Void
    {
        instance._init();
    }

    /**
     * Invoked each time minimap.scaleMarkers is called.
     */
    public static function scaleMarkers():Void
    {
        instance._scaleMarkers();
    }

    private static function get instance():Features
    {
        if (!_instance)
            _instance = new Features();

        return _instance;
    }

    public function Features()
    {
        if (!Minimap.config.enabled)
            return;

        markerScaling = new MarkerScaling();

        GlobalEventDispatcher.addEventListener(Events.MM_ENTRY_INITED, this, onEntryUpdated);
        GlobalEventDispatcher.addEventListener(Events.MM_ENTRY_UPDATED, this, onEntryUpdated);
        GlobalEventDispatcher.addEventListener(Events.MM_CAMERA_UPDATED, this, onCameraUpdated);
        GlobalEventDispatcher.addEventListener(Events.MM_RESPAWNED, this, onRespawn);
        GlobalEventDispatcher.addEventListener(Events.MM_REFRESH, this, onRefreshEvent);

        GlobalEventDispatcher.addEventListener(Events.E_STAT_LOADED, this, onRefreshEvent);
        GlobalEventDispatcher.addEventListener(Events.E_BATTLE_STATE_CHANGED, this, onBattleStateChanged);

        GlobalEventDispatcher.addEventListener(Events.MM_SET_STRATEGIC_POS, this, onSetStrategicPos);

        LabelsContainer.init();
    }

    private function _init()
    {
        // empty function required for instance creation
    }

    private function onRefreshEvent(e:EMinimapEvent)
    {
        applyFeatures();
        _scaleMarkers();

        var entries:Array = IconsProxy.allEntries;
        for (var i in entries)
            entries[i].invalidate();
    }

    private function onBattleStateChanged(e:EBattleStateChanged)
    {
        var entry:net.wargaming.ingame.MinimapEntry = IconsProxy.entry(e.playerId);
        if (entry == null)
            return;
        entry.invalidate();
    }

    private function onSetStrategicPos(e:EMinimapEvent)
    {
        if (strategicAimMarker == null)
        {
            if (e.entry == null)
                return;
            strategicAimMarker = new StrategicAimMarker(e.entry);
        }
        strategicAimMarker.updatePosition(e.entry);
    }

    private function applyFeatures():Void
    {
        setBGMapImageAlpha();
        initializeZoomFeature();
        initializeMapSizeFeature();
        initializeCirclesFeature();
        initializeLinesFeature();
    }

    // GLOBAL

    private function _scaleMarkers():Void
    {
        markerScaling.scale();
    }

    /**
     * Set alpha of background map image.
     * Does not affect markers
     */
    private function setBGMapImageAlpha():Void
    {
        MinimapProxy.wrapper.backgrnd._alpha = Minimap.config.mapBackgroundImageAlpha;
    }

    /**
     * Zoom minimap on key press
     */
    private function initializeZoomFeature():Void
    {
        if (zoom != null)
        {
            zoom.Dispose();
            delete zoom;
            zoom = null;
        }

        if (Config.config.hotkeys.minimapZoom.enabled)
        {
            zoom = new Zoom();
        }
    }

    /**
     * Draw map size at map corner
     */
    private function initializeMapSizeFeature():Void
    {
        if (mapSizeLabel != null)
        {
            mapSizeLabel.Dispose();
            delete mapSizeLabel;
            mapSizeLabel = null;
        }

        if (Minimap.config.mapSize.enabled)
        {
            mapSizeLabel = new MapSizeLabel();
        }
    }

    // ENTRY

    private function onRespawn(e:EMinimapEvent):Void
    {
        //Logger.add("onRespawn");
        applyFeatures();
    }

    private function onEntryUpdated(e:EMinimapEvent):Void
    {
        markerScaling.scaleEntry(e.entry);
    }

    /**
     * Setup alpha for camera of player himself.
     * Looks like green highlighted corner.
     */
    private function onCameraUpdated(e:EMinimapEvent):Void
    {
        var camera:net.wargaming.ingame.MinimapEntry = IconsProxy.cameraEntry;
        if (Minimap.config.hideCameraTriangle && !Config.config.minimap.useStandardLines)
        {
            if (camera._currentframe != 2)
            {
                camera.gotoAndStop(2); // "ally"
                camera.player._visible = false;
            }
        }
        else
        {
            if (camera._currentframe != 4)
            {
                camera.gotoAndStop(4); // "cameraNormal"
            }
        }

        camera.vehicleNameTextFieldClassic._visible = false;
        camera.vehicleNameTextFieldAlt._visible = false;
        camera._alpha = Minimap.config.cameraAlpha;
    }

    /**
     * Draw customized circles.
     * Outlines distance in meters.
     */
    private function initializeCirclesFeature():Void
    {
        if (circles != null)
        {
            circles.Dispose();
            delete circles;
            circles = null;
        }

        if (Minimap.config.circles.enabled && !Config.config.minimap.useStandardCircles)
        {
            circles = new Circles();
        }
    }

    /**
     * Draw customized lines.
     * Outlines vehicle direction, gun horizontal traverse angle
     * and possibly distance in meters.
     */
    private function initializeLinesFeature():Void
    {
        if (lines != null)
        {
            lines.Dispose();
            delete lines;
            lines = null;
        }

        if (Minimap.config.lines.enabled && !Config.config.minimap.useStandardLines)
        {
            lines = new Lines();
        }
    }
}
