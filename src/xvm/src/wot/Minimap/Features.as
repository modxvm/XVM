import wot.Minimap.*;
import wot.Minimap.model.externalProxy.*;
import wot.Minimap.model.mapSize.MapSizeModel;
import wot.Minimap.shapes.*;
import wot.Minimap.view.*;

class wot.Minimap.Features
{
    private static var _instance:Features;
    
    private static var MAP_BORDER_SIZE_INDEX:Number = 0;
    
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
    
    /**
     * Have to be public.
     * Invoked each time minimap.scaleMarkers is called.
     */
    public function scaleMarkers():Void
    {
        if (!markerScaling)
        {
            markerScaling = new MarkerScaling();
        }
        markerScaling.scale();
    }
    
    /**
     * Have to be public.
     * Invoked each time minimap.correctSizeIndexImpl is called.
     */
    public function disableMapWindowSizeLimitation(sizeIndex:Number):Number
    {
        /** base.correctSizeIndex code is omitted to drop limits */

        /** Do not allow size less than map border */
        if (sizeIndex < MAP_BORDER_SIZE_INDEX)
        {
            sizeIndex = MAP_BORDER_SIZE_INDEX;
        }
        
        return sizeIndex;
    }
    
    /**
     * Setup alpha for camera of player himself.
     * Looks like green highlighted corner.
     * TODO: Detach camera line
     * 
     * Have to be public.
     * Invoked each time minimap.onEntryInited is called.
     */
    public function setCameraAlpha():Void
    {
        if (MapConfig.enabled)
        {
            var camera:MinimapEntry = IconsProxy.cameraEntry;
            camera.wrapper._alpha = MapConfig.cameraAlpha;
        }
    }
    
    public function applyMajorMods():Void
    {
        setBGMapImageAlpha();
        setPlayerIconAlpha();
        
        /** With enable switch */
        zoomFeature();
        /** And dependent on successful map size recognition */
        if (MapSizeModel.instance.getCellSide())
        {
            mapSizeFeature();
            shapesFeatures();
        }
    }
    
    //-- Private
    
    /**
     * Set alpha of background map image.
     * Does not affect markers
     */
    private function setBGMapImageAlpha():Void
    {
        MinimapProxy.wrapper.backgrnd._alpha = MapConfig.mapBackgroundImageAlpha;
    }
    
    /**
     * Setup alpha for icon of player himself.
     * Looks like white arrow.
     * Does not affect attached shapes.
     * TODO: check when swithing in spec mode
     */
    private function setPlayerIconAlpha():Void
    {
        var selfIcon:MinimapEntry = IconsProxy.selfEntry;
        selfIcon.wrapper.selfIcon._alpha = MapConfig.selfIconAlpha;
    }
    
    private function zoomFeature():Void
    {
        if (MapConfig.zoomEnabled)
        {
            zoom = new Zoom();
        }
    }
    
    private function mapSizeFeature():Void
    {
        /** Draw map size at map corner */
        if (MapConfig.mapSizeLabelEnabled)
        {
            mapSizeLabel = new MapSizeLabel();
        }
    }
    
    private function shapesFeatures():Void
    {
        /**
         * Draw customized circles.
         * Outlines distance in meters.
         */
        if (MapConfig.circlesEnabled)
        {
            circles = new Circles(); /** Total map side distance in meters */
        }

        /**
         * Draw customized circles.
         * Outlines distance in meters.
         */
        if (MapConfig.squareEnabled)
        {
            square = new Square(); /** Total map side distance in meters */
        }

        /**
         * Draw customized lines.
         * Outlines vehicle direction, gun horizontal traverse angle
         * and possibly distance in meters.
         */
        if (MapConfig.linesEnabled)
        {
            lines = new Lines(); /** Total map side distance in meters  */
        }
    }
}
