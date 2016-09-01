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
        private var currentSizeIndex:int = -1;
        private var savedSizeIndex:int = -1;

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

        override protected function onDispose():void
        {
            Xvm.removeEventListener(Defines.XVM_EVENT_CONFIG_LOADED, setup);
            Xvm.removeEventListener(BattleEvents.MINIMAP_ALT_MODE, setAltMode);
            Xvm.removeEventListener(BattleEvents.MINIMAP_ZOOM, setZoom);
            Xfw.removeCommandListener(XvmCommands.AS_ON_UPDATE_STAGE, onUpdateStage);
            super.onDispose();
        }

        // PRIVATE

        private function setup(e:Event = null):Object
        {
            //Xvm.swfProfilerBegin("UI_Minimap.setup()");
            try
            {
                setCfg();
                xvm_enabled = Macros.FormatBooleanGlobal(Config.config.minimap.enabled, true);

                if (xvm_enabled)
                {
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
    }
}
