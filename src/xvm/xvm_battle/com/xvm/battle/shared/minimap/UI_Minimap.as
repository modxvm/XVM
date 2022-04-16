    /**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 * @author s_sorochich
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.battle.shared.minimap
{
    import com.xfw.*;
    import com.xfw.events.*;
    import com.xvm.*;
    import com.xvm.battle.*;
    import com.xvm.battle.events.*;
    import com.xvm.battle.shared.minimap.entries.personal.*;
    import com.xvm.battle.shared.minimap.entries.vehicle.*;
    import com.xvm.battle.vo.*;
    import com.xvm.extraFields.*;
    import com.xvm.types.cfg.*;
    import com.xvm.vo.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import net.wg.gui.battle.views.minimap.constants.*;
    import net.wg.gui.battle.views.stats.constants.*;
    import net.wg.infrastructure.events.*;
    import scaleform.gfx.*;

    UI_ArcadeCameraEntry;
    UI_CellFlashEntry;
    UI_DeadPointEntry;
    UI_StrategicCameraEntry;
    UI_VideoCameraEntry;
    UI_ViewPointEntry;
    UI_ViewRangeCirclesEntry;
    UI_VehicleEntry;

    public class UI_Minimap extends minimapUI implements IExtraFieldGroupHolder
    {
        static private const _MAX_MINIMAP_PATH_LENGTH:int = 20;
        static private var _cfg:CMinimap;

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

        static private var _instance:UI_Minimap = null;

        static public function get instance():UI_Minimap
        {
            return _instance;
        }

        static public function get cfg():CMinimap
        {
            return _cfg;
        }

        public function UI_Minimap()
        {
            _instance = this;

            super();

            Xvm.addEventListener(Defines.XVM_EVENT_CONFIG_LOADED, setup);
            Xvm.addEventListener(BattleEvents.MINIMAP_ALT_MODE, setAltMode);
            Xvm.addEventListener(BattleEvents.MINIMAP_ZOOM, setZoom);
            Xvm.addEventListener(XmqpEvent.XMQP_MINIMAP_CLICK, onXmqpMinimapClickEvent);
            Xfw.addCommandListener(XvmCommands.AS_ON_UPDATE_STAGE, onUpdateStage);

            _substrateHolder = entriesContainer.addChildAt(new Sprite(), entriesContainer.getChildIndex(entriesContainer.deadVehicles)) as Sprite;
            _substrateHolder.mouseEnabled = false;
            _substrateHolder.mouseChildren = false;
            
            _bottomHolder = entriesContainer.addChildAt(new Sprite(), entriesContainer.getChildIndex(entriesContainer.deadVehicles)) as Sprite;
            _bottomHolder.mouseEnabled = false;
            _bottomHolder.mouseChildren = false;
            
            _normalHolder = entriesContainer.addChildAt(new Sprite(), entriesContainer.getChildIndex(entriesContainer.deadVehicles)) as Sprite;
            _normalHolder.mouseEnabled = false;
            _normalHolder.mouseChildren = false;
            
            _topHolder = entriesContainer.addChildAt(new Sprite(), entriesContainer.getChildIndex(entriesContainer.aliveVehicles) + 1) as Sprite;
            _topHolder.mouseEnabled = false;
            _topHolder.mouseChildren = false;
            
            //XfwUtils.logChilds(entriesContainer);

            setup();
        }

        override protected function configUI():void
        {
            super.configUI();

            this.mapHit.visible = true; // to show minimap clicks and paths
            this.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown, false, 0, true);
            stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove, false, 0, true);
            stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp, false, 0, true);
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
                dispatchEvent(new LifeCycleEvent(LifeCycleEvent.ON_GRAPHICS_RECTANGLES_UPDATE));
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
            _cfg = isAltMode ? Config.config.minimapAlt : Config.config.minimap;
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
            if (Macros.FormatBooleanGlobal(Config.config.minimap.mapSize.enabled, true))
            {
                mapSize = new TextExtraField(Config.config.minimap.mapSize);
                mapSize.update(null);
                background.addChild(mapSize);
            }
            if (Macros.FormatBooleanGlobal(Config.config.minimapAlt.mapSize.enabled, true))
            {
                mapSizeAlt = new TextExtraField(Config.config.minimapAlt.mapSize);
                mapSizeAlt.update(null);
                background.addChild(mapSizeAlt);
            }
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

        private var minimap_path:Array = null;
        private var minimap_path_mc:Sprite = null;

        private function onMouseDown(e:MouseEventEx):void
        {
            try
            {
                var target:Sprite = e.target as Sprite;
                if (target != null)
                {
                    if (target.hitArea == mapHit)
                    {
                        if (e.buttonIdx == MouseEventEx.LEFT_BUTTON)
                        {
                            if (Config.networkServicesSettings.xmqp)
                            {
                                //Logger.addObject(e);
                                var minimap_mouse_x:int = int(mapHit.mouseX);
                                var minimap_mouse_y:int = int(mapHit.mouseY);
                                minimap_path = [[minimap_mouse_x, minimap_mouse_y]];
                                if (!minimap_path_mc)
                                {
                                    minimap_path_mc = new Sprite();
                                }
                                else
                                {
                                    minimap_path_mc.graphics.clear();
                                }
                                minimap_path_mc.graphics.lineStyle(1, Config.networkServicesSettings.x_minimap_clicks_color, 0.3);
                                minimap_path_mc.graphics.moveTo(minimap_mouse_x, minimap_mouse_y);
                                minimap_path_mc.graphics.lineTo(minimap_mouse_x + 0.1, minimap_mouse_y + 0.1);
                                mapHit.addChild(minimap_path_mc);
                            }
                        }
                    }
                }
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        private function onMouseMove(e:MouseEventEx):void
        {
            if (minimap_path != null)
            {
                if (minimap_path.length < _MAX_MINIMAP_PATH_LENGTH)
                {
                    var target:Sprite = e.target as Sprite;
                    if (target != null)
                    {
                        if (target.hitArea == mapHit)
                        {
                            //Logger.addObject(e);
                            var minimap_mouse_x:int = int(mapHit.mouseX);
                            var minimap_mouse_y:int = int(mapHit.mouseY);

                            var lastpos:Array = minimap_path[minimap_path.length - 1];
                            var distance:Number = Math.sqrt(Math.pow(lastpos[0] - minimap_mouse_x, 2) + Math.pow(lastpos[1] - minimap_mouse_y, 2));
                            if (distance > 10)
                            {
                                minimap_path.push([minimap_mouse_x, minimap_mouse_y]);
                                minimap_path_mc.graphics.lineTo(minimap_mouse_x, minimap_mouse_y);
                            }
                        }
                    }
                }
            }
        }

        private function onMouseUp(e:MouseEventEx):void
        {
            if (minimap_path != null)
            {
                if (e.buttonIdx == MouseEventEx.LEFT_BUTTON)
                {
                    //Logger.addObject(e);
                    Xfw.cmd(BattleCommands.MINIMAP_CLICK, minimap_path);
                    minimap_path = null;
                    mapHit.removeChild(minimap_path_mc);
                }
            }
        }

        private function onXmqpMinimapClickEvent(e:XmqpEvent):void
        {
            try
            {
                //Logger.addObject(e.data, 2, "onXmqpMinimapClickEvent");

                var playerState:VOPlayerState = BattleState.get(BattleState.getVehicleIDByAccountDBID(e.accountDBID));

                if (playerState.isIgnored || playerState.isMuted)
                {
                    return;
                }

                var color:Number;
                if (!Config.config.xmqp.minimapDrawColor)
                {
                    color = e.data.color;
                }
                else
                {
                    color = Macros.FormatNumber(Config.config.xmqp.minimapDrawColor, playerState, e.data.color);
                }

                var thickness:Number = Macros.FormatNumber(Config.config.xmqp.minimapDrawLineThickness, playerState, 1);
                var alpha:Number = Macros.FormatNumber(Config.config.xmqp.minimapDrawAlpha, playerState, 100) / 100.0;
                var minimapDrawTime:Number = Macros.FormatNumber(Config.config.xmqp.minimapDrawTime, playerState, 5);

                if (e.data.path != undefined)
                {
                    var mc:Sprite = new Sprite();
                    mapHit.addChild(mc);
                    App.utils.scheduler.scheduleTask(function():void
                    {
                        mapHit.removeChild(mc);
                    }, minimapDrawTime * 1000);

                    var len:int = e.data.path.length;
                    if (len > 0)
                    {
                        // draw dot
                        mc.graphics.lineStyle(thickness * 3, color, alpha);
                        var pos:Array = e.data.path[0];
                        var x:Number = pos[0];
                        var y:Number = pos[1];
                        mc.graphics.moveTo(x, y);
                        mc.graphics.lineTo(x + 0.1, y + 0.1);

                        if (len > 1)
                        {
                            // draw lines
                            mc.graphics.lineStyle(thickness, color, alpha);
                            var commands:Vector.<int> = new <int>[];
                            var data:Vector.<Number> = new <Number>[];

                            for (var i:Number = 1; i < len; ++i)
                            {
                                pos = e.data.path[i];
                                commands.push(GraphicsPathCommand.LINE_TO);
                                data.push(pos[0], pos[1]);
                            }
                            mc.graphics.drawPath(commands, data);

                            // draw arrow head
                            x = pos[0];
                            y = pos[1];
                            var prevPos:Array = e.data.path[len - 2];
                            var angle:Number = Math.atan2(y - prevPos[1], x - prevPos[0]) * 180 / Math.PI;
                            mc.graphics.beginFill(color, alpha);
                            commands = new <int>[GraphicsPathCommand.MOVE_TO, GraphicsPathCommand.LINE_TO, GraphicsPathCommand.LINE_TO, GraphicsPathCommand.LINE_TO];
                            data = new <Number>[
                                x - (5 * thickness * Math.cos((angle - 15) * Math.PI / 180)), y - (5 * thickness * Math.sin((angle - 15) * Math.PI / 180)),
                                x + (1 * thickness * Math.cos((angle) * Math.PI / 180)),      y + (1 * thickness * Math.sin((angle) * Math.PI / 180)),
                                x - (5 * thickness * Math.cos((angle + 15) * Math.PI / 180)), y - (5 * thickness * Math.sin((angle + 15) * Math.PI / 180)),
                                x - (5 * thickness * Math.cos((angle - 15) * Math.PI / 180)), y - (5 * thickness * Math.sin((angle - 15) * Math.PI / 180))];
                            mc.graphics.drawPath(commands, data, GraphicsPathWinding.NON_ZERO);
                            mc.graphics.endFill();
                        }
                    }
                }
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }
    }
}
