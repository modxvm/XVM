/**
 * XVM
 * @author s_sorochich
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.battle.minimap
{
    import com.xfw.*;
    import com.xfw.events.*;
    import com.xvm.*;
    import com.xvm.battle.*;
    import com.xvm.battle.events.*;
    import com.xvm.battle.minimap.entries.personal.*;
    import com.xvm.battle.minimap.entries.vehicle.*;
    import com.xvm.extraFields.*;
    import com.xvm.types.cfg.*;
    import com.xvm.vo.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import net.wg.gui.battle.views.minimap.components.entries.constants.*;
    import net.wg.gui.battle.views.minimap.constants.*;
    import net.wg.gui.battle.views.stats.constants.*;

    UI_ArcadeCameraEntry;
    UI_CellFlashEntry;
    UI_DeadPointEntry;
    UI_StrategicCameraEntry;
    UI_VideoCameraEntry;
    UI_ViewPointEntry;
    UI_ViewRangeCirclesEntry;
    UI_VehicleEntry;

    public /*dynamic*/ class UI_Minimap extends minimapUI implements IExtraFieldGroupHolder
    {
        public static var cfg:CMinimap;

        private var xvm_enabled:Boolean;
        private var _isAltMode:Boolean = false;
        private var _isZoomed:Boolean = false;
        private var _savedSizeIndex:int = -1;

        private var mapSize:TextExtraField;
        private var mapSizeAlt:TextExtraField;

        private var _substrateHolder:Sprite;
        private var _bottomHolder:Sprite;
        private var _normalHolder:Sprite;
        private var _topHolder:Sprite;

        private static var _instance:UI_Minimap = null;
        public static function get instance():UI_Minimap
        {
            return _instance;
        }

        public function UI_Minimap()
        {
            _instance = this;

            super();

            /* TODO: add zoom steps
            if (MinimapSizeConst.MAP_SIZE.length == 6)
            {
                MinimapSizeConst.MAP_SIZE.push(new Rectangle(-100, -100, 728, 728));
                MinimapSizeConst.ENTRY_CONTAINER_POINT.push(new Point(323,323));
                MinimapSizeConst.ENTRY_SCALES.push(0.6);
                MinimapSizeConst.ENTRY_INTERNAL_CONTENT_CONTR_SCALES.push(0.4);
                xfw_foregrounds.push(foreground5);
                Xfw.cmd(BattleCommands.SET_MINIMAP_MAX_SIZE_INDEX, MinimapSizeConst.MAP_SIZE.length - 1);
            }*/

            Xvm.addEventListener(Defines.XVM_EVENT_CONFIG_LOADED, setup);
            Xvm.addEventListener(BattleEvents.MINIMAP_ALT_MODE, setAltMode);
            Xvm.addEventListener(BattleEvents.MINIMAP_ZOOM, setZoom);
            Xvm.addEventListener(XmqpEvent.XMQP_MINIMAP_CLICK, onXmqpMinimapClickEvent);
            Xfw.addCommandListener(XvmCommands.AS_ON_UPDATE_STAGE, onUpdateStage);

            _substrateHolder = entriesContainer.addChildAt(new Sprite(), entriesContainer.getChildIndex(entriesContainer.deadVehicles)) as Sprite;;
            _bottomHolder = entriesContainer.addChildAt(new Sprite(), entriesContainer.getChildIndex(entriesContainer.deadVehicles)) as Sprite;;
            _normalHolder = entriesContainer.addChildAt(new Sprite(), entriesContainer.getChildIndex(entriesContainer.deadVehicles)) as Sprite;;
            _topHolder = entriesContainer.addChildAt(new Sprite(), entriesContainer.getChildIndex(entriesContainer.aliveVehicles) + 1) as Sprite;;

            //XfwUtils.logChilds(entriesContainer);

            setup();
        }

        public function get isAltMode():Boolean
        {
            return _isAltMode;
        }

        override protected function onDispose():void
        {
            Xvm.removeEventListener(Defines.XVM_EVENT_CONFIG_LOADED, setup);
            Xvm.removeEventListener(BattleEvents.MINIMAP_ALT_MODE, setAltMode);
            Xvm.removeEventListener(BattleEvents.MINIMAP_ZOOM, setZoom);
            Xfw.removeCommandListener(XvmCommands.AS_ON_UPDATE_STAGE, onUpdateStage);

            disposeMapSize();

            _substrateHolder = null;
            _bottomHolder = null;
            _normalHolder = null;
            _topHolder = null;

            super.onDispose();
        }

        override public function as_setSize(sizeIndex:int):void
        {
            try
            {
                sizeIndex = Math.max(0, Math.min(MinimapSizeConst.MAP_SIZE.length - 1, sizeIndex));
                super.as_setSize(sizeIndex);

                alignMinimap();
                Xvm.dispatchEvent(new PlayerStateEvent(PlayerStateEvent.ON_MINIMAP_SIZE_CHANGED));
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        override public function getMessageCoordinate():Number
        {
            return (_isZoomed && cfg.zoom.centered) ? 0 : super.getMessageCoordinate();
        }

        // IExtraFieldGroupHolder

        public function get isLeftPanel():Boolean
        {
            return true;
        }

        public function get substrateHolder():Sprite
        {
            return _substrateHolder;
        }

        public function get bottomHolder():Sprite
        {
            return _bottomHolder;
        }

        public function get normalHolder():Sprite
        {
            return _normalHolder;
        }

        public function get topHolder():Sprite
        {
            return _topHolder;
        }

        public function getSchemeNameForVehicle(options:IVOMacrosOptions):String
        {
            return PlayerStatusSchemeName.getSchemeNameForVehicle(
                options.isCurrentPlayer,
                options.isSquadPersonal,
                options.isTeamKiller,
                options.isDead,
                options.isOffline);
        }

        public function getSchemeNameForPlayer(options:IVOMacrosOptions):String
        {
            return PlayerStatusSchemeName.getSchemeNameForPlayer(
                options.isCurrentPlayer,
                options.isSquadPersonal,
                options.isTeamKiller,
                options.isDead,
                options.isOffline);
        }

        // PRIVATE

        private function setup(e:Event = null):Object
        {
            //Xvm.swfProfilerBegin("UI_Minimap.setup()");
            try
            {
                disposeMapSize();

                setCfg();
                xvm_enabled = Config.config.minimap.enabled;

                if (xvm_enabled)
                {
                    setupMapSize();
                    update();
                }
                else
                {
                    background.alpha = 1;
                }
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
            //Xvm.swfProfilerEnd("UI_PlayersPanel.setup()");
            return null;
        }

        private function setCfg():void
        {
            cfg = isAltMode ? Config.config.minimapAlt : Config.config.minimap;
        }

        private function setAltMode(e:ObjectEvent):void
        {
            //Logger.add("setAltMode: isDown:" + e.result.isDown + " isAltMode:" + isAltMode);
            if (xvm_enabled)
            {
                if (Config.config.hotkeys.minimapAltMode.onHold)
                    _isAltMode = e.result.isDown;
                else if (e.result.isDown)
                    _isAltMode = !_isAltMode;
                else
                    return;

                setCfg();
                if (_isZoomed)
                {
                    as_setSize(cfg.zoom.index);
                }
                update();
                Xvm.dispatchEvent(new PlayerStateEvent(PlayerStateEvent.ON_MINIMAP_ALT_MODE_CHANGED));
            }
        }

        private function setZoom(e:ObjectEvent):void
        {
            if (xvm_enabled)
            {
                if (Config.config.hotkeys.minimapZoom.onHold)
                    _isZoomed = e.result.isDown;
                else if (e.result.isDown)
                    _isZoomed = !_isZoomed;
                else
                    return;

                if (_isZoomed)
                {
                    if (_savedSizeIndex == -1)
                    {
                        _savedSizeIndex = currentSizeIndex;
                    }
                    as_setSize(cfg.zoom.index);
                }
                else
                {
                    if (_savedSizeIndex != -1)
                    {
                        as_setSize(_savedSizeIndex);
                    }
                    _savedSizeIndex = -1;
                }
            }
        }

        private function update():void
        {
            setBGMapImageAlpha();
            alignMinimap();
            updateMapSize();
        }

        /**
         * Set alpha of background map image.
         * Does not affect markers
         */
        private function setBGMapImageAlpha():void
        {
            background.alpha = cfg.mapBackgroundImageAlpha / 100.0;
        }

        private function onUpdateStage():void
        {
            alignMinimap();
        }

        private function alignMinimap():void
        {
            if (_isZoomed && cfg.zoom.centered)
            {
                var r:Rectangle = MinimapSizeConst.MAP_SIZE[currentSizeIndex];
                x = (App.appWidth - initedWidth - r.x) / 2;
                y = (App.appHeight - initedHeight - r.y) / 2;
            }
            else
            {
                x = App.appWidth - initedWidth;
                y = App.appHeight - initedHeight;
            }
        }

        private function setupMapSize():void
        {
            mapSize = new TextExtraField(Config.config.minimap.mapSize);
            mapSize.update(null);
            background.addChild(mapSize);
            mapSizeAlt = new TextExtraField(Config.config.minimapAlt.mapSize);
            mapSizeAlt.update(null);
            background.addChild(mapSizeAlt);
        }

        private function disposeMapSize():void
        {
            if (mapSize)
            {
                background.removeChild(mapSize);
                mapSize.dispose();
                mapSize = null;
            }
            if (mapSizeAlt)
            {
                background.removeChild(mapSizeAlt);
                mapSizeAlt.dispose();
                mapSizeAlt = null;
            }
        }

        private function updateMapSize():void
        {
            if (mapSize)
            {
                mapSize.visible = !isAltMode;
                if (mapSize.visible)
                {
                    mapSize.update(null);
                }
            }
            if (mapSizeAlt)
            {
                mapSizeAlt.visible = isAltMode;
                if (mapSizeAlt.visible)
                {
                    mapSizeAlt.update(null);
                }
            }
        }

        // XMQP

        private function onXmqpMinimapClickEvent(e:XmqpEvent):void
        {
            Logger.addObject(e.data, 3, "onXmqpMinimapClickEvent");
            /*var color:Number;
            if (!Config.config.xmqp.minimapClicksColor || Config.config.xmqp.minimapClicksColor == "")
            {
                color = e.data.color;
            }
            else
            {
                color = Number(Macros.FormatByPlayerId(e.value, Config.config.xmqp.minimapClicksColor).split("#").join("0x")) || e.data.color;
            }

            var alpha:Number = 80;

            var depth:Number = wrapper.mapHit.getNextHighestDepth();
            var mc:MovieClip = wrapper.mapHit.createEmptyMovieClip("xmqp_mc_" + depth, depth);
            _global.setTimeout(function() { mc.removeMovieClip() }, Config.config.xmqp.minimapClicksTime * 1000);

            if (e.data.path != undefined)
            {
                var len:Number = e.data.path.length;
                if (len > 0)
                {
                    mc.lineStyle(3, color, alpha);
                    var pos:Array = e.data.path[0];
                    var x:Number = pos[0];
                    var y:Number = pos[1];
                    mc.moveTo(x, y);
                    mc.lineTo(x + 0.1, y + 0.1);

                    mc.lineStyle(1, color, alpha);
                    for (var i:Number = 1; i < len; ++i)
                    {
                        pos = e.data.path[i];
                        mc.lineTo(pos[0], pos[1]);
                    }

                    if (len > 1)
                    {
                        // draw arrow head
                        x = pos[0];
                        y = pos[1];
                        var prevPos:Array = e.data.path[len - 2];
                        var angle:Number = Math.atan2(y - prevPos[1], x - prevPos[0]) * 180 / Math.PI;
                        mc.beginFill(color, alpha);
                        mc.moveTo(x - (5 * Math.cos((angle - 15) * Math.PI / 180)), y - (5 * Math.sin((angle - 15) * Math.PI / 180)));
                        mc.lineTo(x + (1 * Math.cos((angle) * Math.PI / 180)), y + (1 * Math.sin((angle) * Math.PI / 180)));
                        mc.lineTo(x - (5 * Math.cos((angle + 15) * Math.PI / 180)), y - (5 * Math.sin((angle + 15) * Math.PI / 180)));
                        mc.lineTo(x - (5 * Math.cos((angle - 15) * Math.PI / 180)), y - (5 * Math.sin((angle - 15) * Math.PI / 180)));
                        mc.endFill();
                    }
                }
            }*/
        }

        /*

        private var minimap_path:Array;
        private var minimap_path_mc:MovieClip;

        private function onMouseDown(button:Number, target, mouseIdx:Number, x:Number, y:Number, dblClick:Boolean)
        {
            if (target == wrapper.mapHit && !dblClick && button == Mouse.LEFT && _root.g_cursorVisible && Config.networkServicesSettings.xmqp)
            {
                //Logger.addObject(arguments, 1, "onMouseDown");
                x = int(wrapper.mapHit._xmouse);
                y = int(wrapper.mapHit._ymouse);
                minimap_path = [[x, y]];
                if (minimap_path_mc != null)
                    minimap_path_mc.removeMovieClip();
                minimap_path_mc = wrapper.mapHit.createEmptyMovieClip("xmqp_mc_path", wrapper.mapHit.getNextHighestDepth());
                minimap_path_mc.lineStyle(1, Config.networkServicesSettings.x_minimap_clicks_color, 30);
                minimap_path_mc.moveTo(x, y);
                minimap_path_mc.lineTo(x + 0.1, y + 0.1);
            }
        }

        private function onMouseMove(mouseIdx:Number, x:Number, y:Number)
        {
            if (minimap_path != null && minimap_path.length < 20 && y != undefined)
            {
                //Logger.addObject(arguments, 1, "onMouseMove");
                if (wrapper.mapHit.hitTest(_root._xmouse, _root._ymouse))
                {
                    x = int(wrapper.mapHit._xmouse);
                    y = int(wrapper.mapHit._ymouse);

                    var lastpos:Array = minimap_path[minimap_path.length - 1];
                    var distance:Number = Math.sqrt(Math.pow(lastpos[0] - x, 2) + Math.pow(lastpos[1] - y, 2));
                    if (distance > 10)
                    {
                        minimap_path.push([x, y]);
                        minimap_path_mc.lineTo(x, y);
                    }
                }
            }
        }

        private function onMouseUp(button:Number, target, mouseIdx:Number, x:Number, y:Number)
        {
            if (minimap_path != null)
            {
                if (button == Mouse.LEFT)
                {
                    //Logger.addObject(arguments, 1, "onMouseUp");
                    DAAPI.py_xvm_minimapClick(minimap_path);
                    minimap_path = null;
                    minimap_path_mc.removeMovieClip();
                }
            }
        }*/
    }
}
