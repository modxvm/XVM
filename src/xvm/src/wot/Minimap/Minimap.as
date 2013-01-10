import wot.Minimap.Lines;
import wot.Minimap.Circles;
import wot.Minimap.LostMarkers;
import wot.Minimap.MinimapEvent;
import wot.utils.GlobalEventDispatcher;
import wot.Minimap.model.SyncModel;
import wot.utils.Utils;
import wot.Minimap.model.MapConfig;
import wot.Minimap.model.AutoUpdate;
import wot.Minimap.model.MapSizeModel;
import wot.Minimap.MapSizeLabel;

/**
 * Original Minimap manages all kinds size, border, drawing and clicking.
 * 
 * Minimap extends MinimapEntity.
 * 
 * Extra functionality implemented at M:
 * ) Level\type\nick\etc at icon on Minimap.
 *    Achieved exploiting WG highlighting feature.
 *    Original light behaviour was Ctrl + mouseOver at PlayersPanel -> icon highlight at Minimap.
 *    Feature is modded to allow PlayersPanel <-> Minimap syncronization.
 *    Any individual user linked data is now available at Minimap.
 * ) Free marker scaling adjusts tank and base icon size.
 * 
 * @author ilitvinov87@gmail.com
 */

class wot.Minimap.Minimap extends net.wargaming.ingame.Minimap
{
    /** Used at MinimapEntry to get testUid */
    public var sync:SyncModel;

    /** Defines lost enemy positions */
    private var autoUpdate:AutoUpdate;
    
    /** Places and removes lost enemy positions on minimap */
    private var lostMarkers:LostMarkers;
    
    /**
     * Defines real map size in meters.
     * Common values are 1km^2, 600m^2
     */
    private var mapSizeModel:MapSizeModel;
    private var mapSizeLabel:MapSizeLabel;
    
    /**
     * Shape to icon attachments.
     * Shows game related distances and direction.
     */
    private var circles:Circles;
    private var lines:Lines;
    
    private var isMinimapReady:Boolean = false;
    private var isAllyPlayersPanelReady:Boolean = false;
    private var isEnemyPlayersPanelReady:Boolean = false;
    private var loadComplete:Boolean = false;
    
   
    // override
    function Minimap()
    {
        Utils.TraceXvmModule("Minimap");
        super();
        
        GlobalEventDispatcher.addEventListener(MinimapEvent.MINIMAP_READY, this, onReady);
        GlobalEventDispatcher.addEventListener(MinimapEvent.ALLY_PLAYERS_PANEL_READY, this, onReady);
        GlobalEventDispatcher.addEventListener(MinimapEvent.ENEMY_PLAYERS_PANEL_READY, this, onReady);
        
        checkLoading();
    }
    
    // override
    function onEntryInited()
    {
        super.onEntryInited();
        
        if (sync && MapConfig.enabled)
           sync.updateIconsExtension();
    }
    
    // override
    
    function correctSizeIndex(sizeIndex:Number, stageHeight:Number):Number
    {
        return sizeIndex;
    }
    
    // -- Private
    
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
            case MinimapEvent.ALLY_PLAYERS_PANEL_READY:
                isAllyPlayersPanelReady = true;
                break;
            case MinimapEvent.ENEMY_PLAYERS_PANEL_READY:
                isEnemyPlayersPanelReady = true;
                break;
        }
        
        loadComplete = isMinimapReady && isAllyPlayersPanelReady && isEnemyPlayersPanelReady;
        
        if (loadComplete && MapConfig.enabled)
            startExtendedProcedure();
    }
    
    private function startExtendedProcedure():Void
    {
        /**
         * Setup minimap icon size.
         * Read val from config.
         * Default by WG is 0.5.
         * 
         * TODO:
         * Default at XVM config is 0.5.
         */
        MARKERS_SCALING = MapConfig.markerScale;
        scaleMarkers(MARKERS_SCALING);
        
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
            
            /** Draw customized circles */
            if (MapConfig.circlesEnabled)
            {
                circles = new Circles(mapSizeModel.getSide() * 10); /** Total map square distance in meters */
            }
            
            /** Draw customized lines */
            if (MapConfig.linesEnabled)
            {
                lines = new Lines(mapSizeModel.getSide() * 10); /** Total map square distance in meters  */
            }
        }
    }
}
