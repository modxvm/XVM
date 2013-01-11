import wot.utils.Logger;
import wot.Minimap.model.MapConfig;
import wot.Minimap.ShapeAttach;
import wot.Minimap.dto.LineCfg;

/**
 * Draws lines of sight and horizontal focusing angles
 */

class wot.Minimap.Lines extends ShapeAttach
{
    
    public function Lines(mapSizeInMeters:Number) 
    {
        super(mapSizeInMeters);
        
        var linesCfg:Array = defineLinesCfg();
        
        Logger.addObject(icon, "icon", 3);
        
        for (var i in linesCfg)
        {
            var lineCfg:LineCfg = linesCfg[i];
            Logger.addObject(lineCfg, "lineCfg", 2);
            if (lineCfg.enabled)
            {
                var from:Number = lineCfg.from;
                var to  :Number = lineCfg.to;
                if (lineCfg.inmeters)
                {
                    from *= metersPerPoint;
                    to   *= metersPerPoint;
                }
                
                drawLine(from, to, lineCfg.thickness, lineCfg.color, lineCfg.alpha);
            }
        }
    }
    
    // -- Private
    
    private function defineLinesCfg():Array
    {
        var cfg:Array = [];
        
        cfg = cfg.concat(MapConfig.linesVehicle);
        
        return cfg;
    }
    
    private function drawLine(from:Number, to:Number, thickness:Number, color:Number, alpha:Number):Void
    {
        var depth:Number = icon.getNextHighestDepth();
        var mc:MovieClip = icon.createEmptyMovieClip("line" + depth, depth);
        mc.lineStyle(thickness, color, alpha);
        
        mc.moveTo(0, -from);
        mc.lineTo(0, -to);
    }
}
