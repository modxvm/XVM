import wot.utils.VehicleInfo;
import wot.Minimap.model.PlayersPanelProxy;
import wot.Minimap.dto.Player;
import wot.utils.Logger;
import wot.Minimap.model.MapConfig;
import wot.Minimap.model.IconsProxy;
import wot.Minimap.MinimapEntry;
import wot.Minimap.dto.CircleCfg;

class wot.Minimap.Circles
{
    private var CIRCLE_SIDES:Number = 350; /** Defines circle smoothness\angularity */
    private var MAP_SIZE:Number = 211; /** Minimap size in points without scaling */
    
    public function Circles(mapSize:Number) 
    {
        var metersPerPoint:Number = MAP_SIZE / mapSize;
        
        /**
         * Get oneself icon.
         * Used as a center of circles.
         * Will carry attached circles with itself automatically.
         */
        var icon:MinimapEntry = IconsProxy.getSelf();
        
        var player:Player = PlayersPanelProxy.getSelf();
        var vehType:String = VehicleInfo.getName2(player.icon);
        var circlesCfg:Array = defineCirclesCfg(vehType);
        
        for (var i in circlesCfg)
        {
            var circleCfg:CircleCfg = circlesCfg[i];
            
            if (circleCfg.enabled)
            {
                var mc:MovieClip = icon.createEmptyMovieClip("circle" + i, icon.getNextHighestDepth());
                var radius:Number =  metersPerPoint * circleCfg.distance;
                drawCircle(mc, radius, circleCfg.thickness, circleCfg.color, circleCfg.alpha);
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
    
    private function drawCircle(mc:MovieClip, radius:Number, thickness:Number, color:Number, alpha:Number)
    {
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
