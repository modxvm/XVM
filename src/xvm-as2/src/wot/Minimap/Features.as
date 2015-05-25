import com.xvm.*;
import com.xvm.DataTypes.*;
import com.xvm.events.*;
import wot.Minimap.*;
import wot.Minimap.model.externalProxy.*;
import wot.Minimap.model.mapSize.*;
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
    private var square:Square;
    private var lines:Lines;

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
        if (!MapConfig.enabled)
            return;

        markerScaling = new MarkerScaling();

        GlobalEventDispatcher.addEventListener(MinimapEvent.ENTRY_INITED, this, onEntryUpdated);
        GlobalEventDispatcher.addEventListener(MinimapEvent.ENTRY_UPDATED, this, onEntryUpdated);
        GlobalEventDispatcher.addEventListener(MinimapEvent.CAMERA_UPDATED, this, onCameraUpdated);
        GlobalEventDispatcher.addEventListener(MinimapEvent.REFRESH, this, onRefreshEvent);

        GlobalEventDispatcher.addEventListener(Defines.E_STAT_LOADED, this, onRefreshEvent);
        GlobalEventDispatcher.addEventListener(Events.E_BATTLE_STATE_CHANGED, this, onBattleStateChanged);

        LabelsContainer.init();
    }

    private function _init()
    {
        // empty function required for instance creation
    }

    private function onRefreshEvent(e:MinimapEvent)
    {
        applyFeatures();
        _scaleMarkers();

        var entries:Array = IconsProxy.allEntries;
        for (var i in entries)
            entries[i].invalidate();
    }

    private function onBattleStateChanged(e:EBattleStateChanged)
    {
        var pdata:BattleStateData = BattleState.getUserData(e.playerName);
        if (pdata == null)
            return;
        var entry:net.wargaming.ingame.MinimapEntry = IconsProxy.entry(pdata.playerId);
        if (entry == null)
            return;
        entry.invalidate();
    }

    private function applyFeatures():Void
    {
        setBGMapImageAlpha();
        setPlayerIconAlpha();

        initializeZoomFeature();

        // Features dependent on successful map size recognition
        if (MapSizeModel.instance.getCellSide())
        {
            initializeMapSizeFeature();
            initializeSquareFeature();
            initializeCirclesFeature();
            initializeLinesFeature();
        }
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
        MinimapProxy.wrapper.backgrnd._alpha = MapConfig.mapBackgroundImageAlpha;
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
        if (MapConfig.mapSizeLabelEnabled)
        {
            mapSizeLabel = new MapSizeLabel();
        }
    }

    // ENTRY

    private function onEntryUpdated(e:MinimapEvent):Void
    {
        markerScaling.scaleEntry(e.entry);
    }

    /**
     * Setup alpha for camera of player himself.
     * Looks like green highlighted corner.
     */
    private function onCameraUpdated(e:MinimapEvent):Void
    {
        var camera:net.wargaming.ingame.MinimapEntry = IconsProxy.cameraEntry;
        if (MapConfig.hideCameraTriangle)
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
        camera._alpha = MapConfig.cameraAlpha;
    }

    /**
     * Setup alpha for icon of player himself.
     * Looks like white arrow.
     * Does not affect attached shapes.
     */
    private function setPlayerIconAlpha():Void
    {
        var selfIcon:net.wargaming.ingame.MinimapEntry = IconsProxy.selfEntry;
        selfIcon.selfIcon._alpha = MapConfig.selfIconAlpha;
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
        if (MapConfig.circles.enabled)
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
        if (MapConfig.linesEnabled)
        {
            lines = new Lines();
        }
    }

    /**
     * Draw visible range square.
     */
    private function initializeSquareFeature():Void
    {
        if (square != null)
        {
            square.Dispose();
            delete square;
            square = null;
        }
        if (MapConfig.squareEnabled)
        {
            square = new Square();
        }
    }
}
