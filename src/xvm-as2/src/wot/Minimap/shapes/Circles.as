import com.xvm.*;
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

    private var staticCircles:Array = [];
    private var dynamicCircles:Array = [];

    private var destroyedCrew:Object = {};
    private var surveyingDeviceDestroyed:Boolean = false;
    private var stereoscope_exists:Boolean = false;
    private var stereoscope_enabled:Boolean = false;
    private var moving_state:Number;

    private var artilleryMc:MovieClip = null;
    private var shellMc:MovieClip = null;

    public function Circles()
    {
        super();

        moving_state = Defines.MOVING_STATE_STOPPED;

        var player:Player = PlayersPanelProxy.self;
        var vdata:VehicleData = VehicleInfo.getByIcon(player.icon);

        var vehicleType:String = vdata.key.split(":").join("-");
        staticCircles = defineStaticCirclesCfg(vehicleType);
        dynamicCircles = defineDynamicCirclesCfg(vehicleType);
        var len:Number = staticCircles.length;
        for (var i:Number = 0; i < len; ++i)
        {
            var circleCfg:CircleCfg = staticCircles[i];
            var radius:Number = scaleFactor * circleCfg.distance;
            if (circleCfg.scale != null)
                radius *= circleCfg.scale;
            circleCfg.$mc = drawCircle(radius, circleCfg.thickness, circleCfg.color, circleCfg.alpha);
            circleCfg.$radius = radius;
        }

        var cfg = MapConfig.circles;
        var ci = Config.config.minimap.circles._internal;
        //Logger.addObject(cfg, 2);

        GlobalEventDispatcher.addEventListener(Defines.E_MOVING_STATE_CHANGED, this, onMovingStateChanged);

        stereoscope_exists = stereoscope_enabled = ci.view_stereoscope == true;

        if (dynamicCircles.length > 0)
        {
            onViewRangeChanged();
            GlobalEventDispatcher.addEventListener(Defines.E_MODULE_DESTROYED, this, onModuleDestroyed);
            GlobalEventDispatcher.addEventListener(Defines.E_MODULE_REPAIRED, this, onModuleRepaired);
            GlobalEventDispatcher.addEventListener(Defines.E_STEREOSCOPE_TOGGLED, this, onStereoscopeToggled);
        }

        if (cfg.artillery.enabled)
        {
            var radius:Number = scaleFactor * ci.artillery_range;
            if (radius > 0)
                artilleryMc = drawCircle(radius, cfg.artillery.thickness, cfg.artillery.color, cfg.artillery.alpha);
        }

        if (cfg.shell.enabled)
        {
            var radius:Number = scaleFactor * ci.shell_range;
            //Logger.add(radius.toString());
            if (radius > 0)
                shellMc = drawCircle(radius, cfg.shell.thickness, cfg.shell.color, cfg.shell.alpha);
        }
    }

    public function Dispose():Void
    {
        GlobalEventDispatcher.removeEventListener(Defines.E_MOVING_STATE_CHANGED, this, onMovingStateChanged);
        GlobalEventDispatcher.removeEventListener(Defines.E_MODULE_DESTROYED, this, onModuleDestroyed);
        GlobalEventDispatcher.removeEventListener(Defines.E_MODULE_REPAIRED, this, onModuleRepaired);
        GlobalEventDispatcher.removeEventListener(Defines.E_STEREOSCOPE_TOGGLED, this, onStereoscopeToggled);

        var len:Number = staticCircles.length;
        for (var i:Number = 0; i < len; ++i)
        {
            var mc:MovieClip = staticCircles[i].$mc;
            if (mc != null)
            {
                mc.removeMovieClip();
                delete mc;
            }
        }
        staticCircles = [];

        len = dynamicCircles.length;
        for (var i:Number = 0; i < len; ++i)
        {
            var mc:MovieClip = dynamicCircles[i].$mc;
            if (mc != null)
            {
                mc.removeMovieClip();
                delete mc;
            }
        }
        dynamicCircles = [];

        if (artilleryMc != null)
        {
            artilleryMc.removeMovieClip();
            delete artilleryMc;
        }

        if (shellMc != null)
        {
            shellMc.removeMovieClip();
            delete shellMc;
        }

        super.Dispose();
    }

    /** Private */

    private function defineStaticCirclesCfg(vehicleType:String):Array
    {
        var cfg:Array = [];

        var view:Array = MapConfig.circles.view;
        var len:Number = view.length;
        for (var i:Number = 0; i < len; ++i)
        {
            var c = view[i];
            if (!c.enabled)
                continue;
            if (c.state == null)
                c.state = Defines.MOVING_STATE_ALL;
            if (isFinite(c.distance))
            {
                if (isNaN(c.distance))
                    c.distance = parseFloat(c.distance);
                cfg.push(JSONx.parse(JSONx.stringify(c)));
            }
        }

        /** Special vehicle type dependent circle configs */
        var spec:Array = MapConfig.circles.special;
        len = spec.length;
        for (var i:Number = 0; i < len; ++i)
        {
            var rule:Object = spec[i];
            if (rule[vehicleType])
            {
                var c = spec[i][vehicleType];
                if (!c.enabled)
                    continue;
                if (c.state == null)
                    c.state = Defines.MOVING_STATE_ALL;
                cfg.push(JSONx.parse(JSONx.stringify(c)));
            }
        }

        //Logger.addObject(cfg, 2, "static");
        return cfg;
    }

    private function defineDynamicCirclesCfg(vehicleType:String):Array
    {
        var cfg:Array = [];

        var view:Array = MapConfig.circles.view;
        var len:Number = view.length;
        for (var i:Number = 0; i < len; ++i)
        {
            var c = view[i];
            if (!c.enabled)
                continue;
            if (c.state == null)
                c.state = Defines.MOVING_STATE_ALL;
            if (!isFinite(c.distance))
                cfg.push(JSONx.parse(JSONx.stringify(c)));
        }

        //Logger.addObject(cfg, 2, "dynamic");
        return cfg;
    }

    function drawCircle(radius:Number, thickness:Number, color:Number, alpha:Number):MovieClip
    {
        var depth:Number = selfAttachments.getNextHighestDepth();
        var mc:MovieClip = selfAttachments.createEmptyMovieClip(depth.toString(), depth);

        with (mc)
        {
            lineStyle(thickness, color, alpha);
            var c1 = radius * (Math.SQRT2 - 1);
            var c2 = radius * Math.SQRT2 / 2;
            moveTo(radius, 0);
            curveTo(radius, c1, c2, c2);
            curveTo(c1, radius, 0, radius);
            curveTo(-c1, radius, -c2, c2);
            curveTo(-radius, c1, -radius, 0);
            curveTo(-radius, -c1, -c2, -c2);
            curveTo(-c1, -radius, 0, -radius);
            curveTo(c1, -radius, c2, -c2);
            curveTo(radius,-c1, radius, 0);
        }

        return mc;
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
        moving_state = event.value ? Defines.MOVING_STATE_MOVING : Defines.MOVING_STATE_STOPPED;
        updateCirclesMovingState(staticCircles);
        updateCirclesMovingState(dynamicCircles);
    }

    private function onStereoscopeToggled(event)
    {
        //Logger.add("onStereoscopeToggled: " + event.value);

        // workaround for stereoscope
        if (stereoscope_exists == false && event.value == true)
            stereoscope_exists = true;

        stereoscope_enabled = event.value;
        onViewRangeChanged();
    }

    // http://forum.worldoftanks.ru/index.php?/topic/1047590-/
    private function onViewRangeChanged()
    {
        var cfg = MapConfig.circles;

        // Calculations
        var ci = Config.config.minimap.circles._internal;

        var view_distance_vehicle:Number = ci.view_distance_vehicle;
        var bia:Number = ci.view_brothers_in_arms ? 5 : 0;
        var vent:Number = ci.view_ventilation ? 5 : 0;
        var cons:Number = ci.view_consumable ? 10 : 0;

        var K:Number = ci.base_commander_skill + bia + vent + cons;
        var Kcom:Number = K / 10.0;
        var Kee = ci.view_commander_eagleEye <= 0 ? 0 : ci.view_commander_eagleEye + bia + vent + cons;
        var Krf = ci.view_radioman_finder <= 0 ? 0 : ci.view_radioman_finder + bia + vent + cons + (ci.base_radioman_skill > 0 ? Kcom : 0);
        //var M = ci.view_camouflage <= 0 ? 0 : ci.view_camouflage + bia + vent + cons;

        if (destroyedCrew["commander"])
            K = 0;
        if (destroyedCrew["radioman1"])
            Krf = 0;
        // TODO radioman2, gunner1, gunner2

        var Kn1 = surveyingDeviceDestroyed ? 10 : 1;
        var Kn2 = surveyingDeviceDestroyed ? 0.5 : 1;

        // Calculate final values
        var view_distance:Number = view_distance_vehicle * (K * 0.0043 + 0.57) * (1 + Kn1 * 0.0002 * Kee) * (1 + 0.0003 * Krf) * Kn2;
        var stereoscope_distance:Number = view_distance * 1.25;
        if (ci.view_coated_optics == true)
            view_distance = view_distance * 1.1

        //Logger.addObject(Config.config.minimap.circles._internal, 2);
        //Logger.add("K=" + K + " view_distance=" + view_distance);

        // Drawing

        // view
        var len:Number = dynamicCircles.length;
        for (var i:Number = 0; i < len; ++i)
        {
            var dc = dynamicCircles[i];
            //Logger.addObject(dc);

            var radius:Number = 0;
            switch (dc.distance)
            {
                case "dynamic":
                    radius = (stereoscope_exists && stereoscope_enabled) ? stereoscope_distance : view_distance;
                    break;
                case "motion":
                    radius = view_distance;
                    break;
                case "standing":
                    if (stereoscope_exists)
                        radius = stereoscope_distance;
                    break;
                case "blindarea":
                    radius = (stereoscope_exists && stereoscope_enabled) ? stereoscope_distance : view_distance;
                    if (radius < 50) radius = 50; else if (radius > 445) radius = 445;
                    break;
                case "blindarea_motion":
                    radius = view_distance;
                    if (radius < 50) radius = 50; else if (radius > 445) radius = 445;
                    break;
                case "blindarea_standing":
                    if (stereoscope_exists)
                    {
                        radius = stereoscope_distance;
                        if (radius < 50) radius = 50; else if (radius > 445) radius = 445;
                    }
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
                var visible:Boolean = true;
                if (mc != null)
                {
                    if (!mc._visible)
                        visible = false;
                    mc.removeMovieClip();
                }
                dc.$mc = drawCircle(radius, dc.thickness, dc.color, dc.alpha);
                dc.$mc._visible = visible;
                dc.$radius = radius;
            }
        }
    }

    private function updateCirclesMovingState(circles:Array)
    {
        var len:Number = circles.length;
        for (var i:Number = 0; i < len; ++i)
        {
            var c = circles[i];
            var mc:MovieClip = c.$mc;
            //Logger.add(c.state + " " + moving_state + " " + (c.state & moving_state));
            if (mc != null)
                mc._visible = (c.state & moving_state != 0);
        }
    }
}
