import wot.Minimap.shapes.ShapeAttach;
import wot.Minimap.model.externalProxy.MapConfig;

class wot.Minimap.shapes.Square extends ShapeAttach
{
    /**
     * Draw 1km x 1km box.
     * Represents maximun draw distance.
     * Game engine limitation.
     */
    
    private static var SQUARE_SIDE_IN_METERS:Number = 1000;
    
    public function Square(mapSizeInMeters:Number)
    {
        super(mapSizeInMeters);
        
        var mc:MovieClip = createSquareClip();
        defineStyle(mc);
        drawLines(mc);
        cancelRotation(mc);
    }
    
    //--Private
    
    private function createSquareClip():MovieClip
    {
        return selfAttachments.createEmptyMovieClip("square", selfAttachments.getNextHighestDepth());
    }
    
    private function defineStyle(mc:MovieClip):Void
    {
        var config:Object = MapConfig.squareConfig;
        
        mc.lineStyle(config.thickness, parseInt(config.color, 16), config.alpha, null, null, "none");
    }
        
    private function drawLines(mc:MovieClip):Void
    {
        var offset:Number = scaleFactor * SQUARE_SIDE_IN_METERS / 2;
        
        /** Top line */
        mc.moveTo(-offset, -offset);
        mc.lineTo( offset, -offset);
        
        /** Right line */
        mc.moveTo( offset, -offset);
        mc.lineTo( offset,  offset);
        
        /** Bottom line */
        mc.moveTo( offset,  offset);
        mc.lineTo(-offset,  offset);
        
        /** Uper line */
        mc.moveTo(-offset,  offset);
        mc.lineTo( -offset, -offset);
    }
    
    private function cancelRotation(mc:MovieClip):Void
    {
        mc.onEnterFrame = function()
        {
            this._rotation = -this._parent._parent._rotation;
        }
    }
}
