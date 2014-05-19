import com.xvm.*;
import com.xvm.DataTypes.*;
import wot.Minimap.dataTypes.*;
import wot.Minimap.model.externalProxy.*;
import wot.Minimap.dataTypes.cfg.*;
import wot.Minimap.shapes.*;
import wot.PlayersPanel.*;

/**
 * Draws circles around player to indicate distances.
 * Distance of sight or artillery range.
 */

class wot.Minimap.shapes.Circles extends ShapeAttach
{
    private var CIRCLE_SIDES:Number = 350; /** Defines circle smoothness/angularity */

    private var mc_view:MovieClip = null;
    private var mc_binocular:MovieClip = null;

    public function Circles()
    {
        super();

        var player:Player = PlayersPanelProxy.self;
        var vdata:VehicleData = VehicleInfo.getByIcon(player.icon);
        var circlesCfg:Array = defineCirclesCfg(vdata.key.split(":").join("-"));

        for (var i in circlesCfg)
        {
            var circleCfg:CircleCfg = circlesCfg[i];

            if (circleCfg.enabled)
            {
                var radius:Number = scaleFactor * circleCfg.distance;
                drawCircle(radius, circleCfg.thickness, circleCfg.color, circleCfg.alpha);
            }
        }

        var cfg = MapConfig.circles;
        //Logger.addObject(cfg, 2);

        if (cfg.artillery.enabled)
        {
            var radius:Number = scaleFactor * cfg._internal.artillery_range;
            if (radius > 0)
                drawCircle(radius, cfg.artillery.thickness, cfg.artillery.color, cfg.artillery.alpha);
        }

        if (cfg.shell.enabled)
        {
            var radius:Number = scaleFactor * cfg._internal.shell_range;
            if (radius > 0)
                drawCircle(radius, cfg.shell.thickness, cfg.shell.color, cfg.shell.alpha);
        }

        if (cfg.view.enabled)
        {
          "limit445m": false, // do not draw view range more than 445m (maximum reveal distance)
          "active":  { "alpha": 50, "color": "0xFFFFFF", "thickness": 1 },
          "passive": { "alpha": 50, "color": "0xFFFFFF", "thickness": 0.5 }
            var radius:Number = scaleFactor * cfg._internal.view_distance;
            if (radius > 0)
                mc_view = drawCircle(radius, cfg.view.thickness, cfg.view.color, cfg.view.alpha);
            radius = scaleFactor * cfg._internal.binocular_distance;
            if (radius > 0)
                mc_binocular = drawCircle(radius, cfg.view.thickness, cfg.view.color, cfg.view.alpha);
            switchBinoculars(false);
        }

        GlobalEventDispatcher.addEventListener(Defines.E_BINOCULAR_TOGGLED, this, onBinocularToggled);
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
        var depth:Number = selfAttachments.getNextHighestDepth();
        var mc:MovieClip = selfAttachments.createEmptyMovieClip("circle" + depth, depth);
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

        return mc;
    }

    private function magicTrigFunctionX(pointRatio):Number
    {
        return Math.cos(pointRatio*2*Math.PI);
    }

    private function magicTrigFunctionY(pointRatio):Number
    {
        return Math.sin(pointRatio*2*Math.PI);
    }

    private function onBinocularToggled(event)
    {
        switchBinoculars(event.value);
    }

    private function switchBinoculars(enable:Boolean)
    {
        if (mc_view)
            mc_view._visible = !enable;
        if (mc_binocular)
            mc_binocular._visible = enable;
    }
}
