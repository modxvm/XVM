/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.battle.minimap.entries.personal
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.battle.*;
    import com.xvm.battle.events.*;
    import com.xvm.battle.minimap.*;
    import com.xvm.battle.minimap.entries.*;
    import com.xvm.types.cfg.*;
    import flash.display.*;

    public class UI_ViewRangeCirclesEntry extends ViewRangeCirclesEntry
    {
        public static var destroyedCrew:Object;
        public static var surveyingDeviceDestroyed:Boolean;
        public static var stereoscope_exists:Boolean;
        public static var stereoscope_enabled:Boolean;

        private var _circlesEnabled:Boolean;

        private var _circles:Circles;
        private var _circlesAlt:Circles;

        public function UI_ViewRangeCirclesEntry()
        {
            //Logger.add("UI_ViewRangeCirclesEntry");
            super();

            _circlesEnabled = Config.config.minimap.circlesEnabled;
            if (_circlesEnabled)
            {
                Xfw.addCommandListener(XvmCommands.AS_MOVING_STATE_CHANGED, onMovingStateChanged);
                Xfw.addCommandListener(XvmCommands.AS_MODULE_STATE_CHANGED, onModuleStateChanged);
                Xfw.addCommandListener(XvmCommands.AS_STEREOSCOPE_TOGGLED, onStereoscopeToggled);
                Xvm.addEventListener(PlayerStateEvent.ON_MINIMAP_ALT_MODE_CHANGED, onMinimapAltModeChanged);

                destroyedCrew = {};
                surveyingDeviceDestroyed = false;
                stereoscope_exists = stereoscope_enabled = BattleGlobalData.minimapCirclesData.view_stereoscope == true;

                _circles = new Circles(Config.config.minimap.circles);
                //circles.visible = false;
                addChild(_circles);
                _circlesAlt = new Circles(Config.config.minimapAlt.circles);
                _circlesAlt.visible = false;
                addChild(_circlesAlt);
            }
        }

        override public function dispose():void
        {
            Xfw.removeCommandListener(XvmCommands.AS_MOVING_STATE_CHANGED, onMovingStateChanged);
            Xfw.removeCommandListener(XvmCommands.AS_MODULE_STATE_CHANGED, onModuleStateChanged);
            Xfw.removeCommandListener(XvmCommands.AS_STEREOSCOPE_TOGGLED, onStereoscopeToggled);
            Xvm.removeEventListener(PlayerStateEvent.ON_MINIMAP_ALT_MODE_CHANGED, onMinimapAltModeChanged);

            if (_circles)
            {
                _circles.dispose();
                _circles = null;
            }

            if (_circlesAlt)
            {
                _circlesAlt.dispose();
                _circlesAlt = null;
            }

            super.dispose();
        }

        override public function as_addDrawRange(param1:Number, param2:Number, param3:Number):void
        {
            if (!_circlesEnabled)
            {
                super.as_addDrawRange(param1, param2, param3);
            }
        }

        override public function as_addDynamicViewRange(param1:Number, param2:Number, param3:Number):void
        {
            if (!_circlesEnabled)
            {
                super.as_addDynamicViewRange(param1, param2, param3);
            }
        }

        override public function as_addMaxViewRage(param1:Number, param2:Number, param3:Number):void
        {
            if (!_circlesEnabled)
            {
                super.as_addMaxViewRage(param1, param2, param3);
            }
        }

        // PRIVATE

        private function onMinimapAltModeChanged():void
        {
            var isAltMode:Boolean = UI_Minimap.instance.isAltMode;
            _circles.visible = !isAltMode;
            _circlesAlt.visible = isAltMode;
        }

        private function onMovingStateChanged(isMoving:Boolean):void
        {
            //Logger.add("onMovingStateChanged: " + isMoving);
            var moving_state:int = isMoving ? MinimapEntriesConstants.MOVING_STATE_MOVING : MinimapEntriesConstants.MOVING_STATE_STOPPED;
            _circles.updateCirclesMovingState(moving_state);
            _circlesAlt.updateCirclesMovingState(moving_state);
        }

        private function onModuleStateChanged(deviceName:String, deviceState:String, realState:String):void
        {
            Logger.add("onModuleStateChanged: " + arguments);
            /*switch (event.value)
            {
                case "surveyingDevice":
                    surveyingDeviceDestroyed = true;
                    _circles.update();
                    _circlesAlt.update();
                    break;

                case "commander":
                case "radioman1":
                case "radioman2":
                    destroyedCrew[event.value] = true;
                    _circles.update();
                    _circlesAlt.update();
                    break;
            }
            Logger.addObject(event);
            //Logger.add("onModuleRepaired: " + event.value);

            switch (event.value)
            {
                case "surveyingDevice":
                    surveyingDeviceDestroyed = false;
                    _circles.update();
                    _circlesAlt.update();
                    break;

                case "commander":
                case "radioman1":
                case "radioman2":
                    delete destroyedCrew[event.value];
                    _circles.update();
                    _circlesAlt.update();
                    break;
            }*/
        }

        private function onStereoscopeToggled(isOn:int):void
        {
            //Logger.add("onStereoscopeToggled: " + isOn);

            // workaround for stereoscope
            if (!stereoscope_exists)
                stereoscope_exists = true;

            stereoscope_enabled = isOn != 0;

            _circles.update();
            _circlesAlt.update();
        }
    }
}

import com.xfw.*;
import com.xvm.*;
import com.xvm.battle.*;
import com.xvm.battle.vo.*;
import com.xvm.types.cfg.*;
import com.xvm.battle.minimap.entries.*;
import com.xvm.battle.minimap.entries.personal.*;
import flash.display.*;
import net.wg.infrastructure.interfaces.entity.*;
import net.wg.gui.battle.views.minimap.constants.*;

class Circles extends Sprite implements IDisposable
{
    private var cfg:CMinimapCircles;

    private var _mapSizeCoeff:Number = 0;

    private var _staticCircles:Vector.<CMinimapCircle>;
    private var _dynamicCircles:Vector.<CMinimapCircle>;
    private var _artilleryCircle:Shape = null;
    private var _shellRangeCircle:Shape = null;

    public function Circles(cfg:CMinimapCircles)
    {
        this.cfg = cfg;

        var radius:Number;

        _mapSizeCoeff = MinimapSizeConst.MAP_SIZE[0].width / BattleGlobalData.mapSize;

        _staticCircles = _defineStaticCirclesCfg(cfg);
        var len:int = _staticCircles.length;
        for (var i:int = 0; i < len; ++i)
        {
            var circleCfg:CMinimapCircle = _staticCircles[i];
            radius = circleCfg.distance;
            if (circleCfg.scale)
                radius *= circleCfg.scale;
            circleCfg.$radius = radius;
            circleCfg.$shape = _drawCircle(radius, circleCfg.thickness, circleCfg.color, circleCfg.alpha);
            addChild(circleCfg.$shape);
        }

        //Logger.addObject(cfg, 2);
        //Logger.addObject(ci);

        _dynamicCircles = _defineDynamicCirclesCfg(cfg);

        _artilleryCircle = null;
        if (cfg.artillery.enabled)
        {
            radius = BattleGlobalData.minimapCirclesData.artillery_range;
            //Logger.add("arty: " + radius);
            if (radius > 0)
            {
                _artilleryCircle = _drawCircle(radius, cfg.artillery.thickness, cfg.artillery.color, cfg.artillery.alpha);
                addChild(_artilleryCircle);
            }
        }

        if (cfg.shell.enabled)
        {
            radius = BattleGlobalData.minimapCirclesData.shell_range;
            //Logger.add("shell: " + radius);
            if (radius > 0)
            {
                _shellRangeCircle = _drawCircle(radius, cfg.shell.thickness, cfg.shell.color, cfg.shell.alpha);
                addChild(_shellRangeCircle);
            }
        }

        update();
    }

    public function dispose():void
    {
        removeChildren();
    }

    // http://forum.worldoftanks.ru/index.php?/topic/1047590-/
    public function update():void
    {
        // Calculations
        var minimapCirclesData:VOMinimapCirclesData = BattleGlobalData.minimapCirclesData;

        var view_distance_vehicle:Number = minimapCirclesData.view_distance_vehicle;
        var bia:Number = minimapCirclesData.view_brothers_in_arms ? 5 : 0;
        var vent:Number = minimapCirclesData.view_ventilation ? 5 : 0;
        var cons:Number = minimapCirclesData.view_consumable ? 10 : 0;

        var K:Number = minimapCirclesData.base_commander_skill + bia + vent + cons;
        var Kcom:Number = K / 10.0;
        var Kee:Number = minimapCirclesData.view_commander_eagleEye <= 0 ? 0 : minimapCirclesData.view_commander_eagleEye + bia + vent + cons;
        var Krf:Number = minimapCirclesData.view_radioman_finder <= 0 ? 0 : minimapCirclesData.view_radioman_finder + bia + vent + cons + (minimapCirclesData.base_radioman_skill > 0 ? Kcom : 0);
        //var M:Number = minimapCirclesData.view_camouflage <= 0 ? 0 : minimapCirclesData.view_camouflage + bia + vent + cons;

        if (UI_ViewRangeCirclesEntry.destroyedCrew["commander"])
            K = 0;
        if (UI_ViewRangeCirclesEntry.destroyedCrew["radioman1"])
            Krf = 0;
        // TODO radioman2, gunner1, gunner2

        var Kn1:Number = UI_ViewRangeCirclesEntry.surveyingDeviceDestroyed ? 10 : 1;
        var Kn2:Number = UI_ViewRangeCirclesEntry.surveyingDeviceDestroyed ? 0.5 : 1;

        // Calculate final values
        var view_distance:Number = view_distance_vehicle * (K * 0.0043 + 0.57) * (1 + Kn1 * 0.0002 * Kee) * (1 + 0.0003 * Krf) * Kn2;
        var stereoscope_distance:Number = view_distance * 1.25;
        if (minimapCirclesData.view_coated_optics == true)
            view_distance = view_distance * 1.1

        // Drawing

        // view
        var len:int = _dynamicCircles.length;
        for (var i:int = 0; i < len; ++i)
        {
            var dc:CMinimapCircle = _dynamicCircles[i];
            //Logger.addObject(dc);

            var radius:Number = 0;
            switch (dc.distance)
            {
                case "dynamic":
                    radius = (UI_ViewRangeCirclesEntry.stereoscope_exists && UI_ViewRangeCirclesEntry.stereoscope_enabled) ? stereoscope_distance : view_distance;
                    break;
                case "motion":
                    radius = view_distance;
                    break;
                case "standing":
                    if (UI_ViewRangeCirclesEntry.stereoscope_exists)
                        radius = stereoscope_distance;
                    break;
                case "blindarea":
                    radius = (UI_ViewRangeCirclesEntry.stereoscope_exists && UI_ViewRangeCirclesEntry.stereoscope_enabled) ? stereoscope_distance : view_distance;
                    if (radius < 50) radius = 50; else if (radius > 445) radius = 445;
                    break;
                case "blindarea_motion":
                    radius = view_distance;
                    if (radius < 50) radius = 50; else if (radius > 445) radius = 445;
                    break;
                case "blindarea_standing":
                    if (UI_ViewRangeCirclesEntry.stereoscope_exists)
                    {
                        radius = stereoscope_distance;
                        if (radius < 50) radius = 50; else if (radius > 445) radius = 445;
                    }
                    break;
            }

            if (radius <= 0)
                continue;

            if (dc.scale != null)
                radius *= dc.scale;

            var shape:Shape = dc.$shape;
            if (shape == null || Math.abs(dc.$radius - radius) > 0.1)
            {
                var visible:Boolean = true;
                if (shape != null)
                {
                    visible = shape.visible;
                    removeChild(shape);
                    shape = null;
                }
                dc.$radius = radius;
                dc.$shape = _drawCircle(radius, dc.thickness, dc.color, dc.alpha);
                dc.$shape.visible = visible;
                addChild(dc.$shape);
            }
        }
    }

    public function updateCirclesMovingState(moving_state:int):void
    {
        _updateCirclesMovingState(_staticCircles, moving_state);
        _updateCirclesMovingState(_dynamicCircles, moving_state);
    }

    // PRIVATE

    private function _defineStaticCirclesCfg(cfg:CMinimapCircles):Vector.<CMinimapCircle>
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

    private function _defineDynamicCirclesCfg(cfg:CMinimapCircles):Vector.<CMinimapCircle>
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

    private function _drawCircle(radius:Number, thickness:Number, color:Number, alpha:Number):Shape
    {
        radius *= _mapSizeCoeff;
        var circle:Shape = new Shape();
        var g:Graphics = circle.graphics;
        g.lineStyle(thickness, color, alpha / 100.0);
        g.drawCircle(0, 0, radius);
        g.endFill();
        return circle;
    }

    private function _updateCirclesMovingState(circles:Vector.<CMinimapCircle>, moving_state:int):void
    {
        var len:int = circles.length;
        for (var i:int = 0; i < len; ++i)
        {
            var cfg:CMinimapCircle = circles[i];
            var shape:Shape = cfg.$shape;
            if (shape)
            {
                shape.visible = (int(cfg.state) & moving_state) != 0;
            }
        }
    }
}
