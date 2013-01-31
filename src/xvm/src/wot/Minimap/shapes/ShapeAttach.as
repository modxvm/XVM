import wot.Minimap.model.externalProxy.IconsProxy;

/**
 * Handles circles and lines scaling aspect.
 * Defines icon to attach to.
 */

class wot.Minimap.shapes.ShapeAttach
{
    private var MAP_SIZE_IN_POINTS:Number = 211; /** Internal MoviecLip minimap size in points without scaling */
    
    private var scaleFactor:Number;
    
    public function ShapeAttach(mapSizeInMeters:Number) 
    {
        var metersPerPoint:Number = MAP_SIZE_IN_POINTS / mapSizeInMeters;
        
        /**
         * Get oneself icon.
         * Used as a center of circles.
         * Will carry attached circles with itself automatically.
         */
        var self = IconsProxy.getSelf();
        
        scaleFactor = metersPerPoint;
    }
    
    // -- Private
    
    /** Shapes container */
    private function get attachments():MovieClip
    {
        var self:MovieClip = IconsProxy.getSelf();
        
        if (!self.attachments)
        {
            self.createEmptyMovieClip("attachments", self.getNextHighestDepth());
        }
        
        return self.attachments;
    }
}
