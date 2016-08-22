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
    import com.xvm.battle.events.PlayerStateEvent;
    import com.xvm.battle.minimap.entries.*;
    import com.xvm.types.cfg.*;
    import flash.events.*;

    UI_VehicleEntry;
    UI_StrategicCameraEntry;

    public dynamic class UI_Minimap extends minimapUI
    {
        public static var cfg:CMinimap;

        private var xvm_enabled:Boolean;
        private var isAltMode:Boolean = false;

        public function UI_Minimap()
        {
            super();
            Xvm.addEventListener(Defines.XVM_EVENT_CONFIG_LOADED, setup);
            Xvm.addEventListener(BattleEvents.MINIMAP_ALT_MODE, setAltMode);
            setup();
        }

        override protected function onDispose():void
        {
            Xvm.removeEventListener(Defines.XVM_EVENT_CONFIG_LOADED, setup);
            Xvm.removeEventListener(BattleEvents.MINIMAP_ALT_MODE, setAltMode);
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
                update();
                Xvm.dispatchEvent(new PlayerStateEvent(PlayerStateEvent.ON_MINIMAP_ALT_MODE_CHANGED));
            }
        }

        private function update():void
        {
            setBGMapImageAlpha();
        }

        /**
         * Set alpha of background map image.
         * Does not affect markers
         */
        private function setBGMapImageAlpha():void
        {
            background.alpha = Macros.FormatNumberGlobal(cfg.mapBackgroundImageAlpha) / 100.0;
        }
    }
}
