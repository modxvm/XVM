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
    import flash.geom.*;
    import flash.events.*;
    import net.wg.gui.battle.views.minimap.constants.*;

    UI_ArcadeCameraEntry;
    UI_CellFlashEntry;
    UI_DeadPointEntry;
    UI_StrategicCameraEntry;
    UI_VideoCameraEntry;
    UI_ViewPointEntry;
    UI_ViewRangeCirclesEntry;
    UI_VehicleEntry;

    public dynamic class UI_Minimap extends minimapUI
    {
        public static var cfg:CMinimap;

        private var xvm_enabled:Boolean;
        private var isAltMode:Boolean = false;
        private var isZoomed:Boolean = false;
        private var currentSizeIndex:int = 0;
        private var savedSizeIndex:int = -1;

        private var mapSize:TextExtraField;
        private var mapSizeAlt:TextExtraField;

        public function UI_Minimap()
        {
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
            setup();
        }

        override protected function onDispose():void
        {
            Xvm.removeEventListener(Defines.XVM_EVENT_CONFIG_LOADED, setup);
            Xvm.removeEventListener(BattleEvents.MINIMAP_ALT_MODE, setAltMode);
            Xvm.removeEventListener(BattleEvents.MINIMAP_ZOOM, setZoom);
            Xfw.removeCommandListener(XvmCommands.AS_ON_UPDATE_STAGE, onUpdateStage);
            disposeMapSize();
            super.onDispose();
        }

        override public function as_setSize(sizeIndex:int):void
        {
            try
            {
                sizeIndex = Math.max(0, Math.min(MinimapSizeConst.MAP_SIZE.length - 1, sizeIndex));
                super.as_setSize(sizeIndex);
                currentSizeIndex = sizeIndex;

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
                    isAltMode = e.result.isDown;
                else if (e.result.isDown)
                    isAltMode = !isAltMode;
                else
                    return;

                setCfg();
                if (isZoomed)
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
                    isZoomed = e.result.isDown;
                else if (e.result.isDown)
                    isZoomed = !isZoomed;
                else
                    return;

                if (isZoomed)
                {
                    if (savedSizeIndex == -1)
                    {
                        savedSizeIndex = currentSizeIndex;
                    }
                    as_setSize(Macros.FormatNumberGlobal(cfg.zoom.index));
                }
                else
                {
                    if (savedSizeIndex != -1)
                    {
                        as_setSize(savedSizeIndex);
                    }
                    savedSizeIndex = -1;
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
            if (isZoomed && cfg.zoom.centered)
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
