package com.xvm.battle.shared.minimap.entries.personal
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.battle.*;
    import com.xvm.types.cfg.*;
    import com.xvm.battle.shared.minimap.entries.*;
    import com.xvm.battle.shared.minimap.entries.personal.*;
    import flash.display.*;
    import net.wg.infrastructure.interfaces.entity.*;
    import net.wg.gui.battle.views.minimap.constants.*;

    internal class Circles extends Sprite implements IDisposable
    {
        private var cfg:CMinimapCircles;

        private var _mapSizeCoeff:Number = 0;

        private var _staticCircles:Vector.<MinimapCircleData>;
        private var _dynamicCircles:Vector.<MinimapCircleData>;
        private var _artilleryCircle:MinimapCircleData = null;
        private var _shellRangeCircle:Shape = null;

        private var _disposed:Boolean = false;

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

            if (cfg.artillery.enabled)
            {
                _artilleryCircle = new MinimapCircleData(cfg.artillery);
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
            while (numChildren > 0)
            {
                removeChildAt(0);
            }

            _disposed = true;
        }

        public final function isDisposed(): Boolean
        {
            return _disposed;
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
                    default:
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

        public function updateArtilleryRange(shellCD:int):void
        {
            if (!_artilleryCircle)
            {
                return
            }
            if (_artilleryCircle.cfg.enabled)
            {
                var radius:int = BattleGlobalData.minimapCirclesData.artilleryRange(shellCD);
                if (radius > 0)
                {
                    var shape:Shape = _artilleryCircle.shape;
                    if (shape == null || _artilleryCircle.radius != radius)
                    {
                        var visible:Boolean = true;
                        if (shape != null)
                        {
                            visible = shape.visible;
                            removeChild(shape);
                            shape = null;
                        }
                        _artilleryCircle.radius = radius;
                        _artilleryCircle.shape = _drawCircle(radius, _artilleryCircle.cfg.thickness, _artilleryCircle.cfg.color, _artilleryCircle.cfg.alpha);
                        _artilleryCircle.shape.visible = visible;
                        addChild(_artilleryCircle.shape);
                    }
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
}