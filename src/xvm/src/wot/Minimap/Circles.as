import wot.utils.VehicleInfo;
import wot.Minimap.model.PlayersPanelProxy;
import wot.Minimap.dto.Player;
import wot.Minimap.model.MapConfig;
import wot.Minimap.dto.CircleCfg;
import wot.Minimap.ShapeAttach;

/**
 * Draws circles around player to indicate distances.
 * Distance of sight or artillery range.
 */

class wot.Minimap.Circles extends ShapeAttach
{
    private var CIRCLE_SIDES:Number = 350; /** Defines circle smoothness\angularity */
    
    public function Circles(mapSizeInMeters:Number) 
    {
        super(mapSizeInMeters);
        
        var player:Player = PlayersPanelProxy.getSelf();
        var vehType:String = VehicleInfo.getName2(player.icon);
        var circlesCfg:Array = defineCirclesCfg(vehType);
        
        for (var i in circlesCfg)
        {
            var circleCfg:CircleCfg = circlesCfg[i];
            
            if (circleCfg.enabled)
            {
                var radius:Number =  metersPerPoint * circleCfg.distance;
                drawCircle(radius, circleCfg.thickness, circleCfg.color, circleCfg.alpha);
            }
        }
    }
    
    /** Private */ 
    
    private function defineCirclesCfg(vehicleType:String):Array
    {
        var cfg:Array = [];
        
        /** Special vehicle type dependent circle configs */
        var spec:Array = MapConfig.circlesSpecial;
        for (var i in spec)
        {
            var rule:Object = spec[i];
            if (rule[vehicleType])
            {
                cfg.push(spec[i][vehicleType]);
            }
        }
        
        /** Major circle configs */
        cfg = cfg.concat(MapConfig.circlesMajor);
        
        return cfg;
    }
    
    private function drawCircle(radius:Number, thickness:Number, color:Number, alpha:Number)
    {
        var depth:Number = icon.getNextHighestDepth();
        var mc:MovieClip = icon.createEmptyMovieClip("circle" + depth, depth);
        mc.lineStyle(thickness, color, alpha);
        
        var centerX:Number = 0;
        var centerY:Number = 0;

        mc.moveTo(centerX + radius,  centerY);
        for (var i = 0; i <= CIRCLE_SIDES; i++)
        {
            var pointRatio:Number = i / CIRCLE_SIDES;
            var xSteps:Number = magicTrigFunctionX(pointRatio);
            var ySteps:Number = magicTrigFunctionY(pointRatio);
            var pointX:Number = centerX + xSteps * radius;
            var pointY:Number = centerY + ySteps * radius;
            mc.lineTo(pointX, pointY);
        }
    }
    
    private function magicTrigFunctionX(pointRatio):Number
    {
        return Math.cos(pointRatio*2*Math.PI);
    }
    
    private function magicTrigFunctionY(pointRatio):Number
    {
        return Math.sin(pointRatio*2*Math.PI);
    }
}
