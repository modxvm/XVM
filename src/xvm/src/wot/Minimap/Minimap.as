import wot.Minimap.Zoom;
import wot.Minimap.MinimapEntry;
import wot.Minimap.shapes.Square;
import wot.Minimap.ExternalDeveloperInterface;
import wot.utils.Utils;
import wot.utils.GlobalEventDispatcher;
import wot.Minimap.MapSizeLabel;
import wot.Minimap.LostMarkers;
import wot.Minimap.MinimapEvent;
import wot.Minimap.shapes.Lines;
import wot.Minimap.shapes.Circles;
import wot.Minimap.model.iconTracker.SyncModel;
import wot.Minimap.model.iconTracker.AutoUpdate;
import wot.Minimap.model.mapSize.MapSizeModel;
import wot.Minimap.model.externalProxy.IconsProxy;
import wot.Minimap.model.externalProxy.MapConfig;

/**
 * @author ilitvinov87@gmail.com
 */

class wot.Minimap.Minimap extends net.wargaming.ingame.Minimap
{
    /**
     * icons Z indexes from Minimap.pyc:
     *  _BACK_ICONS_RANGE = (25, 49)
     *  _DEAD_VEHICLE_RANGE = (50, 99)
     *  _VEHICLE_RANGE = (101, 150)
     *  _FIXED_INDEXES = {'cameraNormal': 100,
     *  'self': 151,
     *  'cameraStrategic': 152,
     *  'cell': 153 }
     */
    public static var MAX_DEAD_ZINDEX:Number = 99;
    public static var LOST_UNITS_INDEX:Number = MAX_DEAD_ZINDEX;
    public static var SQUARE_1KM_INDEX:Number = MAX_DEAD_ZINDEX - 1;
    public static var EXTERNAL_CUSTOM_INDEX:Number = MAX_DEAD_ZINDEX - 1;
    public static var CAMERA_NORMAL_ZINDEX:Number = 100;
    public static var SELF_ZINDEX:Number = 151;
    
    /** Simplified minimap interface for communication with other Python or Flash mods */
    public var externalDeveloperInterface:ExternalDeveloperInterface;
    
    /** Used at MinimapEntry to get testUid */
    public var sync:SyncModel;

    /** Defines lost enemy positions */
    private var autoUpdate:AutoUpdate;
    
    /** Places and removes lost enemy positions on minimap */
    private var lostMarkers:LostMarkers;
    
    /**
     * Defines real map side size in meters.
     * Common values are 1km, 600m
     */
    private var mapSizeModel:MapSizeModel;
    private var mapSizeLabel:MapSizeLabel;
    
    /**
     * Shape to icon attachments.
     * Shows game related distances and direction.
     */
    private var circles:Circles;
    private var square:Square;
    private var lines:Lines;
    
    private var zoom:Zoom;
    
    private var isMinimapReady:Boolean = false;
    private var isPanelReady:Boolean = false;
    private var loadComplete:Boolean = false;
    private var mapExtended:Boolean = false;
    
    function scaleMarkers(percent)
    {
        super.scaleMarkers(percent);
        XvmRescaleBase(percent);
        rescaleAttachments();
    }
    
    private function XvmRescaleBase(percent:Number):Void
    {
        /**
         * Revert capture base icon size.
         */
        for (var i in icons)
        {
            if (icons[i].entryName == "base")
            {
                icons[i]._xscale = icons[i]._yscale = 100;
            }
        }
    }

    // override
    function Minimap()
    {
        Utils.TraceXvmModule("Minimap");
        super();
        
        GlobalEventDispatcher.addEventListener(MinimapEvent.MINIMAP_READY, this, onReady);
        GlobalEventDispatcher.addEventListener(MinimapEvent.PANEL_READY, this, onReady);
        
        checkLoading();
    }
    
    // override
    function onEntryInited()
    {
        super.onEntryInited();
        
        if (sync && MapConfig.enabled)
           sync.updateIconsExtension();
           
        GlobalEventDispatcher.dispatchEvent(new MinimapEvent(MinimapEvent.ON_ENTRY_INITED));
        
        /**
         * Camera object reconstruction occurs sometimes and all its previous props are lost.
         * Check if alpha is set.
         */
        setCameraAlpha();
    }
    
    /** Disables maximum minimap size limitation */
    // override
    function correctSizeIndex(sizeIndex:Number, stageHeight:Number):Number
    {
        /** super.correctSizeIndex code is omitted to drop limits */
        
        /** Do not allow size less than map border */
        if (sizeIndex < 0)
        {
            sizeIndex = 0;
        }
        
        return sizeIndex;
    }
    
    /** Suitable for manual debug tracing by pushing "=" button */
    // override
    function sizeUp()
    {
        super.sizeUp();
        //wot.utils.Logger.addObject(_root.rightPanel.spotStatusModel.seen, "spotStatusModel.seen", 3);
    }
    
    // -- Private
    
    private function rescaleAttachments():Void
    {
        var entries:Array = IconsProxy.getAllEntries();
        for (var i in entries)
        {
            entries[i].rescaleAttachments();
        }
        /** See MinimapEntry.rescaleAttachments() */
    }
    
    private function checkLoading():Void
    {
        icons.onEnterFrame = function()
        {
            if (this.MinimapEntry0)
            {
                delete this.onEnterFrame;
                GlobalEventDispatcher.dispatchEvent(new MinimapEvent(MinimapEvent.MINIMAP_READY));
            }
        }
    }
        
    private function onReady(event:MinimapEvent):Void
    {
        switch (event.type)
        {
            case MinimapEvent.MINIMAP_READY:
                isMinimapReady = true;
                break;
            case MinimapEvent.PANEL_READY:
                isPanelReady = true;
                break;
        }
        
        loadComplete = isMinimapReady && isPanelReady;
        
        if (loadComplete && !mapExtended)
        {
            externalDeveloperInterface = new ExternalDeveloperInterface();
            
            if (MapConfig.enabled)
            {
                startExtendedProcedure();
            }
            
            mapExtended = true;
        }
    }
    
    private function startExtendedProcedure():Void
    {
        /**
         * Setup minimap icon size.
         * Read val from config.
         * Default by WG is 0.5.
         */
        MARKERS_SCALING = MapConfig.iconScale;
        scaleMarkers(MARKERS_SCALING);

        /** Zoom map on key press */
        if (MapConfig.zoomEnabled)
        {
            zoom = new Zoom(this);
            var key:Number = MapConfig.zoomKey;
            
            net.wargaming.managers.BattleInputHandler.instance.addHandler(key, false, zoom, "onZoomKeyClick");
            net.wargaming.managers.BattleInputHandler.instance.addHandler(key, true, zoom, "onZoomKeyClick");
        }

        sync = new SyncModel();
        sync.updateIconsExtension();

        if (MapConfig.lostEnemyEnabled)
        {
            /**
             * Defines lost enemy units and
             * sends event on lost units change.
             */
            autoUpdate = new AutoUpdate();
            lostMarkers = new LostMarkers(icons);
        }
        
        /**
         * Set alpha of background map image.
         * Does not affect markers
         */
        this.backgrnd._alpha = MapConfig.mapBackgroundImageAlpha;
        
        /**
         * Setup alpha for icon of player himself.
         * Looks like white arrow.
         * Does not affect attached shapes.
         */
        var selfIcon:MinimapEntry = IconsProxy.getSelf();
        selfIcon.selfIcon._alpha = MapConfig.selfIconAlpha;
        
        /**
         * Setup alpha for camera of player himself.
         * Looks like green highlighted corner.
         * Does not affect attached shapes.
         */
        setCameraAlpha();

        /**
         * Defines real map size in meters.
         */
        mapSizeModel = new MapSizeModel();
        
        /** Map size dependent */
        if (mapSizeModel.getSide())
        {
            /** Draw map size at map corner */
            if (MapConfig.mapSizeLabelEnabled)
            {
                mapSizeLabel = new MapSizeLabel(this.backgrnd, mapSizeModel.getSide());
            }
            
            /**
             * Draw customized circles.
             * Outlines distance in meters.
             */
            if (MapConfig.circlesEnabled)
            {
                circles = new Circles(mapSizeModel.getSide() * 10); /** Total map side distance in meters */
            }
            
            /**
             * Draw customized circles.
             * Outlines distance in meters.
             */
            if (MapConfig.squareEnabled)
            {
                square = new Square(mapSizeModel.getSide() * 10); /** Total map side distance in meters */
            }
            
            /**
             * Draw customized lines.
             * Outlines vehicle direction, gun horizontal traverse angle
             * and possibly distance in meters.
             */
            if (MapConfig.linesEnabled)
            {
                lines = new Lines(mapSizeModel.getSide() * 10); /** Total map side distance in meters  */
            }
        }
    }

    private function setCameraAlpha():Void
    {
        var camera:MinimapEntry = IconsProxy.getCamera();
        camera._alpha = MapConfig.cameraAlpha;
    }
}
