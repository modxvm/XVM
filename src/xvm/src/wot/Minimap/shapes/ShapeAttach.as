import wot.Minimap.model.externalProxy.IconsProxy;

/**
 * Handles circles and lines scaling aspect.
 * Defines icon to attach to.
 */

class wot.Minimap.shapes.ShapeAttach
{
    private var MAP_SIZE_IN_POINTS:Number = 211; /** Minimap size in points without scaling */
    
    private var metersPerPoint:Number;
    private var icon:Object; // :MinimapEntry
        
    public function ShapeAttach(mapSizeInMeters:Number) 
    {
        /**
         * Get oneself icon.
         * Used as a center of circles.
         * Will carry attached circles with itself automatically.
         */
        icon = IconsProxy.getSelf();
        
        metersPerPoint = (MAP_SIZE_IN_POINTS / mapSizeInMeters) / icon._xscale * 100;
    }
}
