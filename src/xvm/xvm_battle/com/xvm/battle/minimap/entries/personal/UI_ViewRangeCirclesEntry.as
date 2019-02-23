/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.battle.minimap.entries.personal
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.battle.*;
    import com.xvm.battle.events.*;
    import com.xvm.battle.minimap.*;
    import com.xvm.battle.minimap.entries.*;
    import com.xvm.battle.vo.*;

    public class UI_ViewRangeCirclesEntry extends ViewRangeCirclesEntry
    {
        static private var _visionRadius:Number;
        static private var _stereoscope_exists:Boolean;
        static private var _stereoscope_enabled:Boolean;

        private var _entryDeleted:Boolean = false;

        private var _circlesEnabled:Boolean;

        private var _circles:Circles;
        private var _circlesAlt:Circles;

        static public function get visionRadius():Number
        {
            return _visionRadius;
        }

        static public function get stereoscope_exists():Boolean
        {
            return _stereoscope_exists;
        }

        static public function get stereoscope_enabled():Boolean
        {
            return _stereoscope_enabled;
        }

        public function UI_ViewRangeCirclesEntry()
        {
            //Logger.add("UI_ViewRangeCirclesEntry");
            super();
            // https://ci.modxvm.com/sonarqube/coding_rules?open=flex%3AS1447&rule_key=flex%3AS1447
            _init();
        }

        private function _init():void
        {
            _circlesEnabled = Config.config.minimap.circlesEnabled;
            if (_circlesEnabled)
            {
                Xfw.addCommandListener(XvmCommands.AS_MOVING_STATE_CHANGED, onMovingStateChanged);
                Xfw.addCommandListener(XvmCommands.AS_STEREOSCOPE_TOGGLED, onStereoscopeToggled);
                Xvm.addEventListener(PlayerStateEvent.CURRENT_VEHICLE_DESTROYED, updateCirclesVisibility);
                Xvm.addEventListener(PlayerStateEvent.ON_MINIMAP_ALT_MODE_CHANGED, updateCirclesVisibility);

                UI_ViewRangeCirclesEntry._stereoscope_exists = UI_ViewRangeCirclesEntry._stereoscope_enabled = BattleGlobalData.minimapCirclesData.view_stereoscope == true;

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
            if (!_entryDeleted)
            {
                xvm_delEntry();
            }

            super.dispose();
        }

        override public function as_addDrawRange(param1:Number, param2:Number, param3:Number):void
        {
            if (_entryDeleted)
            {
                Logger.add("WARNING: as_addDrawRange() on deleted VehicleEntry");
                return;
            }

            if (!_circlesEnabled)
            {
                super.as_addDrawRange(param1, param2, param3);
            }
        }

        override public function as_addDynamicViewRange(color:Number, alpha:Number, visionRadius:Number):void
        {
            if (_entryDeleted)
            {
                Logger.add("WARNING: as_addDynamicViewRange() on deleted VehicleEntry");
                return;
            }

            //Logger.add("as_addDynamicViewRange: " + visionRadius);
            if (!_circlesEnabled)
            {
                super.as_addDynamicViewRange(color, alpha, visionRadius);
            }
            else
            {
                UI_ViewRangeCirclesEntry._visionRadius = visionRadius;
                _circles.update();
                _circlesAlt.update();
            }
        }

        override public function as_addMaxViewRage(param1:Number, param2:Number, param3:Number):void
        {
            if (_entryDeleted)
            {
                Logger.add("WARNING: as_addMaxViewRage() on deleted VehicleEntry");
                return;
            }

            if (!_circlesEnabled)
            {
                super.as_addMaxViewRage(param1, param2, param3);
            }
        }

        override public function as_updateDynRange(visionRadius:Number):void
        {
            if (_entryDeleted)
            {
                Logger.add("WARNING: as_updateDynRange() on deleted VehicleEntry");
                return;
            }

            //Logger.add("as_updateDynRange: " + visionRadius);
            if (!_circlesEnabled)
            {
                super.as_updateDynRange(visionRadius);
            }
            else
            {
                try
                {
                    UI_ViewRangeCirclesEntry._visionRadius = visionRadius;
                    _circles.update();
                    _circlesAlt.update();
                }
                catch (ex:Error)
                {
                    Logger.err(ex);
                }
            }
        }

        // DAAPI

        public function xvm_delEntry():void
        {
            _entryDeleted = true;

            Xfw.removeCommandListener(XvmCommands.AS_MOVING_STATE_CHANGED, onMovingStateChanged);
            Xfw.removeCommandListener(XvmCommands.AS_STEREOSCOPE_TOGGLED, onStereoscopeToggled);
            Xvm.removeEventListener(PlayerStateEvent.CURRENT_VEHICLE_DESTROYED, updateCirclesVisibility);
            Xvm.removeEventListener(PlayerStateEvent.ON_MINIMAP_ALT_MODE_CHANGED, updateCirclesVisibility);

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
        }

        // PRIVATE

        private function updateCirclesVisibility():void
        {
            var playerState:VOPlayerState = BattleState.get(BattleGlobalData.playerVehicleID);
            if (playerState.isDead)
            {
                _circles.visible = false;
                _circlesAlt.visible = false;
            }
            else
            {
                var isAltMode:Boolean = UI_Minimap.instance.isAltMode;
                _circles.visible = !isAltMode;
                _circlesAlt.visible = isAltMode;
            }
        }

        private function onMovingStateChanged(isMoving:Boolean):void
        {
            //Logger.add("onMovingStateChanged: " + isMoving);
            var moving_state:int = isMoving ? MinimapEntriesConstants.MOVING_STATE_MOVING : MinimapEntriesConstants.MOVING_STATE_STOPPED;
            _circles.updateCirclesMovingState(moving_state);
            _circlesAlt.updateCirclesMovingState(moving_state);
        }

        private function onStereoscopeToggled(isOn:int):void
        {
            //Logger.add("onStereoscopeToggled: " + isOn);
            try
            {
                // workaround for stereoscope
                if (!UI_ViewRangeCirclesEntry._stereoscope_exists)
                    UI_ViewRangeCirclesEntry._stereoscope_exists = true;

                UI_ViewRangeCirclesEntry._stereoscope_enabled = isOn != 0;

                _circles.update();
                _circlesAlt.update();
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }
    }
}

import com.xfw.*;
import com.xvm.*;
import com.xvm.battle.*;
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

    private var _staticCircles:Vector.<MinimapCircleData>;
    private var _dynamicCircles:Vector.<MinimapCircleData>;
    private var _artilleryCircle:Shape = null;
    private var _shellRangeCircle:Shape = null;

    public function Circles(cfg:CMinimapCircles)
    {
        // https://ci.modxvm.com/sonarqube/coding_rules?open=flex%3AS1447&rule_key=flex%3AS1447
        _init(cfg);
    }

    private function _init(cfg:CMinimapCircles):void
    {
        this.cfg = cfg;

        var radius:Number;

        _mapSizeCoeff = MinimapSizeConst.MAP_SIZE[0].width / BattleGlobalData.mapSize;

        _staticCircles = _defineStaticCircles(cfg);
        var len:int = _staticCircles.length;
        for (var i:int = 0; i < len; ++i)
        {
            var data:MinimapCircleData = _staticCircles[i];
            radius = data.cfg.distance;
            if (data.cfg.scale)
                radius *= data.cfg.scale;
            data.radius = radius;
            data.shape = _drawCircle(radius, data.cfg.thickness, data.cfg.color, data.cfg.alpha);
            addChild(data.shape);
        }

        //Logger.addObject(cfg, 2);
        //Logger.addObject(ci);

        _dynamicCircles = _defineDynamicCircles(cfg);

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
        var circularVisionRadius:int;
        var stereoscopeVisionRadius:int;
        if (UI_ViewRangeCirclesEntry.stereoscope_enabled)
        {
            stereoscopeVisionRadius = UI_ViewRangeCirclesEntry.visionRadius;
            circularVisionRadius = stereoscopeVisionRadius / 1.25;
            if (BattleGlobalData.minimapCirclesData.view_coated_optics)
                circularVisionRadius *= 1.1;
        }
        else
        {
            circularVisionRadius = UI_ViewRangeCirclesEntry.visionRadius;
            stereoscopeVisionRadius = circularVisionRadius;
            if (BattleGlobalData.minimapCirclesData.view_coated_optics)
                stereoscopeVisionRadius /= 1.1;
            stereoscopeVisionRadius *= 1.25;
        }

        //Logger.add("stereoscope_enabled = " + UI_ViewRangeCirclesEntry.stereoscope_enabled);
        //Logger.add("stereoscopeVisionRadius = " + stereoscopeVisionRadius);
        //Logger.add("circularVisionRadius = " + circularVisionRadius);

        var len:int = _dynamicCircles.length;
        for (var i:int = 0; i < len; ++i)
        {
            var data:MinimapCircleData = _dynamicCircles[i];
            //Logger.addObject(dc);

            var radius:int = 0;
            switch (data.cfg.distance)
            {
                case "dynamic":
                    radius = UI_ViewRangeCirclesEntry.stereoscope_enabled ? stereoscopeVisionRadius : circularVisionRadius;
                    break;
                case "motion":
                    radius = circularVisionRadius;
                    break;
                case "standing":
                    if (UI_ViewRangeCirclesEntry.stereoscope_exists)
                        radius = stereoscopeVisionRadius;
                    break;
                case "blindarea":
                    radius = UI_ViewRangeCirclesEntry.stereoscope_enabled ? stereoscopeVisionRadius : circularVisionRadius;
                    if (radius < 50) radius = 50; else if (radius > 445) radius = 445;
                    break;
                case "blindarea_motion":
                    radius = circularVisionRadius;
                    if (radius < 50) radius = 50; else if (radius > 445) radius = 445;
                    break;
                case "blindarea_standing":
                    if (UI_ViewRangeCirclesEntry.stereoscope_exists)
                    {
                        radius = stereoscopeVisionRadius;
                        if (radius < 50) radius = 50; else if (radius > 445) radius = 445;
                    }
                    break;
            }

            //Logger.add("distance=" + dc.distance + " radius=" + radius);

            if (radius <= 0)
                continue;

            if (data.cfg.scale != null)
                radius *= data.cfg.scale;

            var shape:Shape = data.shape;
            if (shape == null || data.radius != radius)
            {
                var visible:Boolean = true;
                if (shape != null)
                {
                    visible = shape.visible;
                    removeChild(shape);
                    shape = null;
                }
                data.radius = radius;
                data.shape = _drawCircle(radius, data.cfg.thickness, data.cfg.color, data.cfg.alpha);
                data.shape.visible = visible;
                addChild(data.shape);
            }
        }
    }

    public function updateCirclesMovingState(moving_state:int):void
    {
        _updateCirclesMovingState(_staticCircles, moving_state);
        _updateCirclesMovingState(_dynamicCircles, moving_state);
    }

    // PRIVATE

    private function _defineStaticCircles(cfg:CMinimapCircles):Vector.<MinimapCircleData>
    {
        var res:Vector.<MinimapCircleData> = new Vector.<MinimapCircleData>();

        var i:int;
        var c:CMinimapCircle;
        var data:MinimapCircleData;
        var len:int = cfg.parsedView.length;
        for (i = 0; i < len; ++i)
        {
            c = cfg.parsedView[i];
            if (!c.enabled || isNaN(c.distance))
                continue;
            res.push(new MinimapCircleData(c));
        }

        // Special vehicle key dependent circle configs
        var vehicleKey:String = VehicleInfo.get(BattleGlobalData.playerVehCD).key.replace(":", "-");
        len = cfg.special.length;
        for (i = 0; i < len; ++i)
        {
            var rule:Object = cfg.special[i];
            if (rule)
            {
                if (rule[vehicleKey])
                {
                    c = CMinimapCircle(cfg.special[i][vehicleKey]);
                    if (!c.enabled)
                        continue;
                    res.push(new MinimapCircleData(c));
                }
            }
        }

        //Logger.addObject(res, 2, "static");
        return res;
    }

    private function _defineDynamicCircles(cfg:CMinimapCircles):Vector.<MinimapCircleData>
    {
        var res:Vector.<MinimapCircleData> = new Vector.<MinimapCircleData>();

        var len:int = cfg.parsedView.length;
        for (var i:int = 0; i < len; ++i)
        {
            var c:CMinimapCircle = cfg.parsedView[i];
            if (c.enabled)
            {
                if (isNaN(c.distance))
                {
                    res.push(new MinimapCircleData(c));
                }
            }
        }

        //Logger.addObject(res, 2, "dynamic");
        return res;
    }

    private function _drawCircle(radius:Number, thickness:Number, color:Number, alpha:Number):Shape
    {
        //Logger.add("_drawCircle: " + arguments);
        radius *= _mapSizeCoeff;
        var circle:Shape = new Shape();
        var g:Graphics = circle.graphics;
        g.lineStyle(thickness, color, alpha / 100.0);
        g.drawCircle(0, 0, radius);
        g.endFill();
        return circle;
    }

    private function _updateCirclesMovingState(circles:Vector.<MinimapCircleData>, moving_state:int):void
    {
        var len:int = circles.length;
        for (var i:int = 0; i < len; ++i)
        {
            var data:MinimapCircleData = circles[i];
            var shape:Shape = data.shape;
            if (shape)
            {
                shape.visible = (data.state & moving_state) != 0;
            }
        }
    }
}

class MinimapCircleData
{
    public var cfg:CMinimapCircle;
    public var radius:Number;
    public var shape:Shape;
    public var state:int;

    public function MinimapCircleData(cfg:CMinimapCircle):void
    {
        this.cfg = cfg;
        this.state = MinimapEntriesConstants.MOVING_STATE_ALL;
    }
}
