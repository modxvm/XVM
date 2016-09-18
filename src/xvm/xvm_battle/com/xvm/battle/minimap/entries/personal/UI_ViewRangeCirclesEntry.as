/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.battle.minimap.entries.personal
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.battle.*;
    import com.xvm.battle.minimap.entries.*;
    import com.xvm.types.cfg.*;
    import flash.display.*;

    public class UI_ViewRangeCirclesEntry extends ViewRangeCirclesEntry
    {
        private var _useStandardCircles:Boolean;

        private var circles:Circles;
        private var circlesAlt:Circles;

        private var destroyedCrew:Object;
        private var surveyingDeviceDestroyed:Boolean;
        private var stereoscope_exists:Boolean;
        private var stereoscope_enabled:Boolean;
        private var moving_state:int;

        public function UI_ViewRangeCirclesEntry()
        {
            //Logger.add("UI_ViewRangeCirclesEntry");
            super();

            _useStandardCircles = Config.config.minimap.useStandardCircles;
            if (!_useStandardCircles)
            {
                Xvm.addEventListener(BattleEvents.MOVING_STATE_CHANGED, onMovingStateChanged);
                Xvm.addEventListener(BattleEvents.MODULE_DESTROYED, onModuleDestroyed);
                Xvm.addEventListener(BattleEvents.MODULE_REPAIRED, onModuleRepaired);
                Xvm.addEventListener(BattleEvents.STEREOSCOPE_TOGGLED, onStereoscopeToggled);

                destroyedCrew = {};
                surveyingDeviceDestroyed = false;
                moving_state = MinimapEntriesConstants.MOVING_STATE_STOPPED;
                stereoscope_exists = stereoscope_enabled = BattleGlobalData.minimapCirclesData.view_stereoscope == true;

                circles = new Circles(Config.config.minimap.circles);
                //circles.visible = false;
                addChild(circles);
                circlesAlt = new Circles(Config.config.minimapAlt.circles);
                circlesAlt.visible = false;
                addChild(circlesAlt);

                onViewRangeChanged();
            }
        }

        override public function as_addDrawRange(param1:Number, param2:Number, param3:Number):void
        {
            if (_useStandardCircles)
            {
                super.as_addDrawRange(param1, param2, param3);
            }
        }

        override public function as_addDynamicViewRange(param1:Number, param2:Number, param3:Number):void
        {
            if (_useStandardCircles)
            {
                super.as_addDynamicViewRange(param1, param2, param3);
            }
        }

        override public function as_addMaxViewRage(param1:Number, param2:Number, param3:Number):void
        {
            if (_useStandardCircles)
            {
                super.as_addMaxViewRage(param1, param2, param3);
            }
        }

        override public function dispose():void
        {
            Xvm.removeEventListener(BattleEvents.MOVING_STATE_CHANGED, onMovingStateChanged);
            Xvm.removeEventListener(BattleEvents.MODULE_DESTROYED, onModuleDestroyed);
            Xvm.removeEventListener(BattleEvents.MODULE_REPAIRED, onModuleRepaired);
            Xvm.removeEventListener(BattleEvents.STEREOSCOPE_TOGGLED, onStereoscopeToggled);

            if (circles)
            {
                circles.dispose();
                circles = null;
            }

            if (circlesAlt)
            {
                circlesAlt.dispose();
                circlesAlt = null;
            }

            super.dispose();
        }

        // PRIVATE

        private function onModuleDestroyed(event):void
        {
            //Logger.add("onModuleDestroyed: " + event.value);
            Logger.addObject(event);

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

        private function onModuleRepaired(event):void
        {
            Logger.addObject(event);
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

        private function onMovingStateChanged(event):void
        {
            Logger.addObject(event);
            //Logger.add("onMovingStateChanged: " + event.value);
            //moving_state = event.value ? MinimapEntriesConstants.MOVING_STATE_MOVING : MinimapEntriesConstants.MOVING_STATE_STOPPED;
            //updateCirclesMovingState(staticCircles);
            //updateCirclesMovingState(dynamicCircles);
        }

        private function onStereoscopeToggled(event):void
        {
            Logger.addObject(event);
            //Logger.add("onStereoscopeToggled: " + event.value);

            // workaround for stereoscope
            //if (stereoscope_exists == false && event.value == true)
                //stereoscope_exists = true;
//
            //stereoscope_enabled = event.value;
            //onViewRangeChanged();
        }

        // http://forum.worldoftanks.ru/index.php?/topic/1047590-/
        private function onViewRangeChanged():void
        {
            //var cfg:Object = Minimap.config.circles;
//
            //// Calculations
            //var ci:Object = Config.minimapCirclesData;
//
            //var view_distance_vehicle:Number = ci.view_distance_vehicle;
            //var bia:Number = ci.view_brothers_in_arms ? 5 : 0;
            //var vent:Number = ci.view_ventilation ? 5 : 0;
            //var cons:Number = ci.view_consumable ? 10 : 0;
//
            //var K:Number = ci.base_commander_skill + bia + vent + cons;
            //var Kcom:Number = K / 10.0;
            //var Kee = ci.view_commander_eagleEye <= 0 ? 0 : ci.view_commander_eagleEye + bia + vent + cons;
            //var Krf = ci.view_radioman_finder <= 0 ? 0 : ci.view_radioman_finder + bia + vent + cons + (ci.base_radioman_skill > 0 ? Kcom : 0);
            ////var M = ci.view_camouflage <= 0 ? 0 : ci.view_camouflage + bia + vent + cons;
//
            //if (destroyedCrew["commander"])
                //K = 0;
            //if (destroyedCrew["radioman1"])
                //Krf = 0;
            //// TODO radioman2, gunner1, gunner2
//
            //var Kn1 = surveyingDeviceDestroyed ? 10 : 1;
            //var Kn2 = surveyingDeviceDestroyed ? 0.5 : 1;
//
            //// Calculate final values
            //var view_distance:Number = view_distance_vehicle * (K * 0.0043 + 0.57) * (1 + Kn1 * 0.0002 * Kee) * (1 + 0.0003 * Krf) * Kn2;
            //var stereoscope_distance:Number = view_distance * 1.25;
            //if (ci.view_coated_optics == true)
                //view_distance = view_distance * 1.1
//
            ////Logger.addObject(Config.minimapCirclesData, 2);
            ////Logger.add("K=" + K + " view_distance=" + view_distance);
//
            //// Drawing
//
            //// view
            //var len:Number = dynamicCircles.length;
            //for (var i:Number = 0; i < len; ++i)
            //{
                //var dc = dynamicCircles[i];
                ////Logger.addObject(dc);
//
                //var radius:Number = 0;
                //switch (dc.distance)
                //{
                    //case "dynamic":
                        //radius = (stereoscope_exists && stereoscope_enabled) ? stereoscope_distance : view_distance;
                        //break;
                    //case "motion":
                        //radius = view_distance;
                        //break;
                    //case "standing":
                        //if (stereoscope_exists)
                            //radius = stereoscope_distance;
                        //break;
                    //case "blindarea":
                        //radius = (stereoscope_exists && stereoscope_enabled) ? stereoscope_distance : view_distance;
                        //if (radius < 50) radius = 50; else if (radius > 445) radius = 445;
                        //break;
                    //case "blindarea_motion":
                        //radius = view_distance;
                        //if (radius < 50) radius = 50; else if (radius > 445) radius = 445;
                        //break;
                    //case "blindarea_standing":
                        //if (stereoscope_exists)
                        //{
                            //radius = stereoscope_distance;
                            //if (radius < 50) radius = 50; else if (radius > 445) radius = 445;
                        //}
                        //break;
                //}
//
                //if (radius <= 0)
                    //continue;
//
                //radius *= scaleFactor;
                //if (dc.scale != null)
                    //radius *= dc.scale;
//
                //var mc:MovieClip = dc.$shape;
                //if (mc == null || Math.abs(dc.$radius - radius) > 0.1)
                //{
                    //var visible:Boolean = true;
                    //if (mc != null)
                    //{
                        //if (!mc._visible)
                            //visible = false;
                        //mc.removeMovieClip();
                    //}
                    //dc.$shape = drawCircle(radius, dc.thickness, dc.color, dc.alpha);
                    //dc.$shape._visible = visible;
                    //dc.$radius = radius;
                //}
            //}
        }

        private function updateCirclesMovingState(circles:Array):void
        {
            //var len:Number = circles.length;
            //for (var i:Number = 0; i < len; ++i)
            //{
                //var c = circles[i];
                //var mc:MovieClip = c.$shape;
                ////Logger.add(c.state + " " + moving_state + " " + (c.state & moving_state));
                //if (mc != null)
                    //mc._visible = (c.state & moving_state != 0);
            //}
        }
    }
}

import com.xfw.*;
import com.xvm.*;
import com.xvm.battle.*;
import com.xvm.battle.vo.*;
import com.xvm.types.cfg.*;
import com.xvm.battle.minimap.entries.*;
import flash.display.*;
import net.wg.infrastructure.interfaces.entity.*;

class Circles extends Sprite implements IDisposable
{
    public var staticCircles:Vector.<CMinimapCircle>;
    public var dynamicCircles:Vector.<CMinimapCircle>;
    public var artilleryCircle:Shape = null;
    public var shellRangeCircle:Shape = null;
    private var _mapSizeCoeff:Number = 0;
    import net.wg.gui.battle.views.minimap.constants.*;

    public function Circles(cfg:CMinimapCircles)
    {
        var radius:Number;

        _mapSizeCoeff = MinimapSizeConst.MAP_SIZE[0].width / BattleGlobalData.mapSize;

        staticCircles = defineStaticCirclesCfg(cfg);
        var len:int = staticCircles.length;
        for (var i:int = 0; i < len; ++i)
        {
            var circleCfg:CMinimapCircle = staticCircles[i];
            radius = circleCfg.distance;
            if (circleCfg.scale)
                radius *= circleCfg.scale;
            circleCfg.$radius = radius;
            circleCfg.$shape = drawCircle(radius, circleCfg.thickness, circleCfg.color, circleCfg.alpha);
            addChild(circleCfg.$shape);
        }

        //Logger.addObject(cfg, 2);
        //Logger.addObject(ci);

        dynamicCircles = defineDynamicCirclesCfg(cfg);

        artilleryCircle = null;
        if (cfg.artillery.enabled)
        {
            radius = BattleGlobalData.minimapCirclesData.artillery_range;
            Logger.add("arty: " + radius);
            if (radius > 0)
            {
                artilleryCircle = drawCircle(radius, cfg.artillery.thickness, cfg.artillery.color, cfg.artillery.alpha);
                addChild(artilleryCircle);
            }
        }

        if (cfg.shell.enabled)
        {
            radius = BattleGlobalData.minimapCirclesData.shell_range;
            Logger.add("shell: " + radius);
            if (radius > 0)
            {
                shellRangeCircle = drawCircle(radius, cfg.shell.thickness, cfg.shell.color, cfg.shell.alpha);
                addChild(shellRangeCircle);
            }
        }
    }

    public function dispose():void
    {
        removeChildren();
    }

    // PRIVATE

    private function defineStaticCirclesCfg(cfg:CMinimapCircles):Vector.<CMinimapCircle>
    {
        var res:Vector.<CMinimapCircle> = new Vector.<CMinimapCircle>();

        var i:int;
        var c:CMinimapCircle;
        var len:int = cfg.view.length;
        for (i = 0; i < len; ++i)
        {
            c = CMinimapCircle.parse(cfg.view[i]);
            if (!c.enabled || isNaN(c.distance))
                continue;
            if (!c.state)
                c.state = MinimapEntriesConstants.MOVING_STATE_ALL;
            res.push(c);
        }

        // Special vehicle key dependent circle configs
        var vehicleKey:String = VehicleInfo.get(BattleGlobalData.playerVehCD).key;
        len = cfg.special.length;
        for (i = 0; i < len; ++i)
        {
            var rule:Object = cfg.special[i];
            if (rule && rule[vehicleKey])
            {
                c = CMinimapCircle.parse(cfg.special[i][vehicleKey]);
                if (!c.enabled)
                    continue;
                if (!c.state)
                    c.state = MinimapEntriesConstants.MOVING_STATE_ALL;
                res.push(c);
            }
        }

        //Logger.addObject(res, 2, "static");
        return res;
    }

    private function defineDynamicCirclesCfg(cfg:CMinimapCircles):Vector.<CMinimapCircle>
    {
        var res:Vector.<CMinimapCircle> = new Vector.<CMinimapCircle>();

        var len:int = cfg.view.length;
        for (var i:int = 0; i < len; ++i)
        {
            var c:CMinimapCircle = CMinimapCircle.parse(cfg.view[i]);
            if (!c.enabled)
                continue;
            if (!c.state)
                c.state = MinimapEntriesConstants.MOVING_STATE_ALL;
            if (isNaN(c.distance))
                res.push(c);
        }

        //Logger.addObject(res, 2, "dynamic");
        return res;
    }

    private function drawCircle(radius:Number, thickness:Number, color:Number, alpha:Number):Shape
    {
        radius *= _mapSizeCoeff;
        var circle:Shape = new Shape();
        var g:Graphics = circle.graphics;
        g.lineStyle(thickness, color, alpha / 100.0);
        g.drawCircle(0, 0, radius);
        g.endFill();
        return circle;
    }
}
