/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.battle.shared.zoomIndicator
{
    import com.xfw.*;
    import com.xfw.events.*;
    import com.xvm.*;
    import com.xvm.battle.*;
    import com.xvm.extraFields.*;
    import com.xvm.types.cfg.*;
    import flash.events.*;
    import net.wg.data.constants.*;
    import scaleform.clik.core.*;

    public class ZoomIndicator extends UIComponent
    {
        private var cfg:CExtraField = null;
        private var indicator:TextExtraField;

        private var _camera_enabled:Boolean;
        private var _enable:Boolean;
        private var _offsetX:Number;
        private var _offsetY:Number;

        public function ZoomIndicator()
        {
            visible = false;
            mouseEnabled = false;

            Xvm.addEventListener(Defines.XVM_EVENT_CONFIG_LOADED, onConfigLoaded);
            Xvm.addEventListener(BattleEvents.TEAM_BASES_PANEL_VISIBLE, onBattleComponentsVisible);
            Xfw.addCommandListener(BattleCommands.AS_SNIPER_CAMERA, onSniperCamera);
            Xfw.addCommandListener(BattleCommands.AS_AIM_OFFSET_UPDATE, onAimOffsetUpdate);
            Xfw.addCommandListener(XvmCommands.AS_ON_UPDATE_STAGE, onUpdateStage);
            setup();
        }

        override protected function onDispose():void
        {
            Xvm.removeEventListener(Defines.XVM_EVENT_CONFIG_LOADED, onConfigLoaded);
            Xvm.removeEventListener(BattleEvents.TEAM_BASES_PANEL_VISIBLE, onBattleComponentsVisible);
            Xfw.removeCommandListener(BattleCommands.AS_SNIPER_CAMERA, onSniperCamera);
            Xfw.removeCommandListener(BattleCommands.AS_AIM_OFFSET_UPDATE, onAimOffsetUpdate);
            Xfw.removeCommandListener(XvmCommands.AS_ON_UPDATE_STAGE, onUpdateStage);
            cfg = null;
            indicator = null;
            super.onDispose();
        }

        // event handlers

        private function onConfigLoaded(e:Event):void
        {
            setup();
        }

        private function onBattleComponentsVisible(e:BooleanEvent):void
        {
            visible = e.value && _enable;
        }

        private function onUpdateStage():void
        {
            if (cfg)
            {
                if (cfg.enabled)
                {
                    invalidate(InvalidationType.POSITION);
                }
            }
        }

        private function setup():void
        {
            //Xvm.swfProfilerBegin("ZoomIndicator.setup()");
            try
            {
                visible = false;
                _camera_enabled = Macros.FormatBooleanGlobal(Config.config.battle.camera.enabled, true);
                if (_camera_enabled)
                {
                    cfg = Config.config.battle.camera.sniper.zoomIndicator.clone();
                    cfg.enabled = Macros.FormatBooleanGlobal(cfg.enabled, true);
                    if (cfg.enabled)
                    {
                        if (indicator)
                            removeChild(indicator);
                        indicator = new TextExtraField(cfg);
                        addChild(indicator);
                        invalidate(InvalidationType.STATE);
                    }
                }
                else
                {
                    cfg = null;
                }
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
            //Xvm.swfProfilerEnd("ZoomIndicator.setup()");
        }

        private function onSniperCamera(enable:Boolean, zoom:Number):void
        {
            if (_enable != enable || BattleState.currentAimZoom != zoom)
            {
                _enable = enable;
                BattleState.currentAimZoom = zoom;
                if (cfg)
                {
                    if (cfg.enabled)
                    {
                        invalidate(InvalidationType.STATE);
                    }
                }
            }
        }

        public function onAimOffsetUpdate(offsetX:Number, offsetY:Number):void
        {
            if (_offsetX != offsetX || _offsetY != offsetY)
            {
                _offsetX = offsetX;
                _offsetY = offsetY;
                if (cfg)
                {
                    if (cfg.enabled)
                    {
                        invalidate(InvalidationType.POSITION);
                    }
                }
            }
        }

        // UIComponent

        override protected function draw():void
        {
            if (!cfg || !cfg.enabled)
                return;
            if (isInvalid(InvalidationType.STATE))
            {
                visible = _enable;
                if (_enable)
                {
                    updateState();
                }
            }
            if (isInvalid(InvalidationType.POSITION))
            {
                if (_enable)
                {
                    updatePositions();
                }
            }
        }

        // PRIVATE

        public function updateState():void
        {
            indicator.update(null);
        }

        private function updatePositions():void
        {
            if (x != _offsetX)
            {
                x = _offsetX;
            }
            if (y != _offsetY)
            {
                y = _offsetY;
            }
        }
    }
}
