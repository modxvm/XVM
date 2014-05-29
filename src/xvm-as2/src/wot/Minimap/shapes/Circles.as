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

    private var dynamicCircles:Array = [];

    private var destroyedCrew:Object = {};
    private var surveyingDeviceDestroyed:Boolean = false;
    private var binoculars_exists:Boolean = false;
    private var binoculars_enabled:Boolean = false;

    public function Circles()
    {
        super();

        var player:Player = PlayersPanelProxy.self;
        var vdata:VehicleData = VehicleInfo.getByIcon(player.icon);
        var circlesCfg:Array = defineCirclesCfg(vdata.key.split(":").join("-"));

        for (var i in circlesCfg)
        {
            var circleCfg:CircleCfg = circlesCfg[i];
            var radius:Number = scaleFactor * circleCfg.distance;
            if (circleCfg.scale != null)
                radius *= circleCfg.scale;
            drawCircle(radius, circleCfg.thickness, circleCfg.color, circleCfg.alpha);
        }

        var cfg = MapConfig.circles;
        //Logger.addObject(cfg, 2);

        if (dynamicCircles.length > 0)
        {
            onViewRangeChanged();
            GlobalEventDispatcher.addEventListener(Defines.E_MODULE_DESTROYED, this, onModuleDestroyed);
            GlobalEventDispatcher.addEventListener(Defines.E_MODULE_REPAIRED, this, onModuleRepaired);
            GlobalEventDispatcher.addEventListener(Defines.E_BINOCULAR_TOGGLED, this, onBinocularToggled);
            GlobalEventDispatcher.addEventListener(Defines.E_MOVING_STATE_CHANGED, this, onMovingStateChanged);
        }

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
    }

    /** Private */

    private function defineCirclesCfg(vehicleType:String):Array
    {
        var cfg:Array = [];

        /** Special vehicle type dependent circle configs */
        var spec:Array = MapConfig.circles.special;
        var len:Number = spec.length;
        for (var i:Number = 0; i < len; ++i)
        {
            var rule:Object = spec[i];
            if (rule[vehicleType])
            {
                var c = spec[i][vehicleType];
                if (c.enabled)
                    cfg.push(c);
            }
        }

        dynamicCircles = [];
        var view:Array = MapConfig.circles.view;
        len = view.length;
        for (var i:Number = 0; i < len; ++i)
        {
            var c = view[i];
            if (!c.enabled)
                continue;
            if (isFinite(c.distance))
            {
                if (isNaN(c.distance))
                    c.distance = parseFloat(c.distance);
                cfg.push(c);
            }
            else
            {
                dynamicCircles.push(c);
            }
        }

        //Logger.addObject(cfg, 2);
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
        return Math.cos(pointRatio * 2 * Math.PI);
    }

    private function magicTrigFunctionY(pointRatio):Number
    {
        return Math.sin(pointRatio * 2 * Math.PI);
    }

    private function onModuleDestroyed(event)
    {
        //Logger.add("onModuleDestroyed: " + event.value);

        switch (event.value)
        {
            case "surveyingDevice":
                surveyingDeviceDestroyed = true;
                onViewRangeChanged();
                break;

            case "commander":
            case "radioman1":
            case "radioman2":
                destroyedCrew[event.value] = true;
                onViewRangeChanged();
                break;
        }
    }

    private function onModuleRepaired(event)
    {
        //Logger.add("onModuleRepaired: " + event.value);

        switch (event.value)
        {
            case "surveyingDevice":
                surveyingDeviceDestroyed = false;
                onViewRangeChanged();
                break;

            case "commander":
            case "radioman1":
            case "radioman2":
                delete destroyedCrew[event.value];
                onViewRangeChanged();
                break;
        }
    }

    private function onMovingStateChanged(event)
    {
        //Logger.add("onMovingStateChanged: " + event.value);
        //onViewRangeChanged();
    }

    private function onBinocularToggled(event)
    {
        // workaround for binoculars
        if (binoculars_exists == false && event.value == true)
            binoculars_exists = true;

        binoculars_enabled = event.value;
        onViewRangeChanged();
    }

    // http://forum.worldoftanks.ru/index.php?/topic/1047590-/
    private function onViewRangeChanged()
    {
        var cfg = MapConfig.circles;

        // Calculations
        var ci = cfg._internal;
        var view_distance_vehicle:Number = ci.view_distance_vehicle;
        var bia:Number = ci.view_brothers_in_arms ? 5 : 0;
        var vent:Number = ci.view_ventilation ? 5 : 0;
        var cons:Number = ci.view_consumable ? 10 : 0;

        var K:Number = ci.view_base_commander_skill + bia + vent + cons;
        var Kcom:Number = K / 10.0;
        var Kee = ci.view_commander_eagleEye <= 0 ? 0 : ci.view_commander_eagleEye + bia + vent + cons;
        var Krf = ci.view_radioman_finder <= 0 ? 0 : ci.view_radioman_finder + bia + vent + cons + (ci.view_is_commander_radioman == true ? 0 : Kcom);
        //var M = ci.view_camouflage <= 0 ? 0 : ci.view_camouflage + bia + vent + cons + (ci.view_is_commander_camouflage == true ? 0 : Kcom);

        if (destroyedCrew["commander"])
            K = 0;
            break;
        if (destroyedCrew["radioman1"])
            Krf = 0;
        // TODO radioman2, gunner1, gunner2

        var Kn1 = surveyingDeviceDestroyed ? 10 : 1;
        var Kn2 = surveyingDeviceDestroyed ? 0.5 : 1;

        // Calculate final values
        var view_distance:Number = view_distance_vehicle * (K * 0.0043 + 0.57) * (1 + Kn1 * 0.0002 * Kee) * (1 + 0.0003 * Krf) * Kn2;
        var binocular_distance:Number = view_distance * 1.25;
        if (ci.view_coated_optics == true)
            view_distance = view_distance * 1.1

        //Logger.addObject(cfg._internal, 2);
        //Logger.add("K=" + K + " view_distance=" + view_distance);

        // Drawing

        // view
        var len:Number = dynamicCircles.length;
        for (var i:Number = 0; i < len; ++i)
        {
            var dc = dynamicCircles[i];

            var radius:Number = 0;
            switch (dc.distance)
            {
                case "blindarea":
                    radius = binoculars_exists && binoculars_enabled ? binocular_distance : view_distance;
                    if (radius < 50)
                        radius = 50;
                    if (radius > 445)
                        radius = 445;
                    break;
                case "dynamic":
                    radius = binoculars_exists && binoculars_enabled ? binocular_distance : view_distance;
                    break;
                case "motion":
                    radius = view_distance;
                    break;
                case "standing":
                    radius = binocular_distance;
                    break;
            }

            if (radius <= 0)
                continue;

            radius *= scaleFactor;
            if (dc.scale != null)
                radius *= dc.scale;

            var mc:MovieClip = dc.$mc;
            if (mc == null || Math.abs(dc.$radius - radius) > 0.1)
            {
                if (mc != null)
                    mc.removeMovieClip();
                dc.$mc = drawCircle(radius, dc.thickness, dc.color, dc.alpha);
                dc.$radius = radius;
            }
        }
    }
}
