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

    private var binoculars_exists:Boolean = false;

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
            onViewRangeChanged(false);
            GlobalEventDispatcher.addEventListener(Defines.E_BINOCULAR_TOGGLED, this, onBinocularToggled);
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
        // workaround for binoculars
        if (binoculars_exists == false && event.value == true)
            binoculars_exists = true;

        onViewRangeChanged(event.value);
    }

    // http://forum.worldoftanks.ru/index.php?/topic/1047590-/page__pid__25639867#entry25639867
    private function onViewRangeChanged(binoculars_enabled:Boolean)
    {
        var cfg = MapConfig.circles;
        if (!cfg.view.enabled)
            return;

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

        /*
         * TODO
         * Если любой член экипажа контужен, то уровень его эффективного умения = 0. На примере командира, переменная К = 0%.
         * дополнительные (второстепенные) умения (например, Маскировка, Орлиный глаз и т. п.) продолжают работать,
         * переменные ОГб, РПб и Мб остаются неизменны. (*необходимо уточнить*)
         **/

        var broken = false; // TODO

        var Kn1 = broken ? 10 : 1; // приборы наблюдения
        var Kn2 = broken ? 0.5 : 1; // приборы наблюдения

        var view_distance:Number = view_distance_vehicle * (K * 0.0043 + 0.57) *
            (1 + Kn1 * 0.0002 * Kee) * (1 + 0.0003 * Krf) * Kn2;

        var binocular_distance:Number = view_distance * 1.25;

        if (ci.view_coated_optics == true)
            view_distance = view_distance * 1.1

        if (cfg.limit445m)
        {
            if (view_distance > 445)
                view_distance = 445;
            if (binocular_distance > 445)
                binocular_distance = 445;
        }

        Logger.addObject(cfg._internal, 2);
        Logger.add("K=" + K + " view_distance=" + view_distance);

        // view
        var radius:Number = scaleFactor * view_distance;
        if (radius > 0 && (mc_view == null || mc_view["$raduis"] != radius || mc_view["$active"] != !binoculars_enabled))
        {
            var c = binoculars_enabled ? cfg.view.passive : cfg.view.active;
            if (mc_view != null)
                mc_view.removeMovieClip();
            mc_view = drawCircle(radius, c.thickness, c.color, c.alpha);
        }

        // binocular
        radius = binoculars_exists ? scaleFactor * binocular_distance : 0;
        if (radius > 0 && (mc_binocular == null || mc_binocular["$raduis"] != radius || mc_binocular["$active"] != binoculars_enabled))
        {
            var c = binoculars_enabled ? cfg.view.active : cfg.view.passive;
            if (mc_binocular != null)
                mc_binocular.removeMovieClip();
            mc_binocular = drawCircle(radius, c.thickness, c.color, c.alpha);
        }
    }
}
