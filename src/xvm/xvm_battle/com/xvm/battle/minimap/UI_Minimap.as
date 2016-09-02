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
        private var _currentSizeIndex:int = 0;
        private var _savedSizeIndex:int = -1;

        private var mapSize:TextExtraField;
        private var mapSizeAlt:TextExtraField;

        private var _substrateHolder:MovieClip;
        private var _bottomHolder:MovieClip;
        private var _normalHolder:MovieClip;
        private var _topHolder:MovieClip;

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
            Xfw.addCommandListener(XvmCommands.AS_ON_UPDATE_STAGE, onUpdateStage);

            _substrateHolder = entriesContainer.addChildAt(new MovieClip(), 0) as MovieClip;
            _bottomHolder = entriesContainer.addChildAt(new MovieClip(), 1) as MovieClip;
            _normalHolder = entriesContainer.addChildAt(new MovieClip(), entriesContainer.getChildIndex(entriesContainer.deadVehicles)) as MovieClip;;
            _topHolder = entriesContainer.addChildAt(new MovieClip(), entriesContainer.getChildIndex(entriesContainer.aliveVehicles) + 1) as MovieClip;;

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
                _currentSizeIndex = sizeIndex;

                /* TODO: add zoom steps
                if (param1 == 5)
                {
                    foreground5.scaleX = foreground5.scaleY = 1;
                }
                else if (param1 > 5)
                {
                    foreground5.scaleX = foreground5.scaleY = 1.1;
                }*/

                alignMinimap();
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        // IExtraFieldGroupHolder

        public function get isLeftPanel():Boolean
        {
            return true;
        }

        public function get substrateHolder():MovieClip
        {
            return _substrateHolder;
        }

        public function get bottomHolder():MovieClip
        {
            return _bottomHolder;
        }

        public function get normalHolder():MovieClip
        {
            return _normalHolder;
        }

        public function get topHolder():MovieClip
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
                xvm_enabled = Macros.FormatBooleanGlobal(Config.config.minimap.enabled, true);

                if (xvm_enabled)
                {
                    mapHit.visible = true;
                    setupMapSize();
                    update();
                }
                else
                {
                    mapHit.visible = false;
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
                    as_setSize(Macros.FormatNumberGlobal(cfg.zoom.index));
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
                        _savedSizeIndex = _currentSizeIndex;
                    }
                    as_setSize(Macros.FormatNumberGlobal(cfg.zoom.index));
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
            background.alpha = Macros.FormatNumberGlobal(cfg.mapBackgroundImageAlpha) / 100.0;
        }

        private function onUpdateStage():void
        {
            alignMinimap();
        }

        private function alignMinimap():void
        {
            if (_isZoomed && cfg.zoom.centered)
            {
                x = (App.appWidth - initedWidth) / 2;
                y = (App.appHeight - initedHeight) / 2;
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
            mapHit.addChild(mapSize);
            mapSizeAlt = new TextExtraField(Config.config.minimapAlt.mapSize);
            mapHit.addChild(mapSizeAlt);
        }

        private function disposeMapSize():void
        {
            if (mapSize)
            {
                mapHit.removeChild(mapSize);
                mapSize.dispose();
                mapSize = null;
            }
            if (mapSizeAlt)
            {
                mapHit.removeChild(mapSizeAlt);
                mapSizeAlt.dispose();
                mapSizeAlt = null;
            }
        }

        private function updateMapSize():void
        {
            if (mapSize)
            {
                mapSize.visible = !isAltMode;
                mapSize.update(null);
            }
            if (mapSizeAlt)
            {
                mapSizeAlt.visible = isAltMode;
                mapSizeAlt.update(null);
            }
        }
    }
}
