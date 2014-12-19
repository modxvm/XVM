import com.xvm.*;
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

    public static function get instance():Features
    {
        if (!_instance)
        {
            _instance = new Features();
        }

        return _instance;
    }

    public function Features()
    {
        markerScaling = new MarkerScaling();

        GlobalEventDispatcher.addEventListener(MinimapEvent.ENTRY_INITED, this, onEntryUpdated);
        GlobalEventDispatcher.addEventListener(MinimapEvent.ENTRY_UPDATED, this, onEntryUpdated);
        GlobalEventDispatcher.addEventListener(MinimapEvent.REFRESH, this, onRefreshEvent);

        //GlobalEventDispatcher.addEventListener(Defines.E_STAT_LOADED, this, updateEntries);
        //GlobalEventDispatcher.addEventListener(Defines.E_BATTLE_STATE_CHANGED, this, updateEntries);

        LabelsContainer.init();
    }

    private function onRefreshEvent(e)
    {
        applyFeatures();
        scaleMarkers();

        var entries:Array = IconsProxy.allEntries;
        for (var i in entries)
            entries[i].invalidate();
    }

    //public function updateEntries()
    //{
        //var waitFrame:Boolean = Features.instance.setCameraAlpha();
        /*if (!waitFrame)
            updateEntries2();
        else
        {
            var $this = this;
            IconsProxy.cameraEntry.wrapper.onEnterFrame = function():Void
            {
                delete this.onEnterFrame;
                $this.updateEntries2();
            }
        }*/
    //}

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

    /**
     * Have to be public.
     * Invoked each time minimap.scaleMarkers is called.
     */
    public function scaleMarkers():Void
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
        markerScaling.scaleEntry(e.entry.wrapper);

        if (e.entry == IconsProxy.cameraEntry)
            Features.instance.setCameraAlpha();
    }

    /**
     * Setup alpha for camera of player himself.
     * Looks like green highlighted corner.
     *
     * Have to be public.
     * Invoked each time minimap.onEntryInited is called.
     */
    private function setCameraAlpha():Boolean
    {
        var waitFrame:Boolean = false;

        if (MapConfig.enabled)
        {
            var camera:net.wargaming.ingame.MinimapEntry = IconsProxy.cameraEntry.wrapper;
            if (MapConfig.hideCameraTriangle)
            {
                if (camera._currentframe != 2)
                {
                    waitFrame = true;
                    camera.gotoAndStop(2); // "ally"
                    camera.player._visible = false;
                }
            }
            else
            {
                if (camera._currentframe != 4)
                {
                    waitFrame = true;
                    camera.gotoAndStop(4); // "cameraNormal"
                }
            }

            camera.vehicleNameTextFieldClassic._visible = false;
            camera.vehicleNameTextFieldAlt._visible = false;
            camera._alpha = MapConfig.cameraAlpha;
        }

        return waitFrame;
    }

    /**
     * Setup alpha for icon of player himself.
     * Looks like white arrow.
     * Does not affect attached shapes.
     */
    private function setPlayerIconAlpha():Void
    {
        var selfIcon:MinimapEntry = IconsProxy.selfEntry;
        selfIcon.wrapper.selfIcon._alpha = MapConfig.selfIconAlpha;
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
