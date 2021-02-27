/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.battle
{
    import com.greensock.TweenLite;
    import com.xfw.*;
    import com.xfw.events.*;
    import com.xvm.*;
    import com.xvm.infrastructure.*;
    import com.xvm.battle.events.*;
    import com.xvm.battle.shared.battleClock.BattleClock;
    import com.xvm.battle.shared.battleLabels.BattleLabels;
    import com.xvm.battle.shared.elements.BattleElements;
    import com.xvm.battle.shared.zoomIndicator.ZoomIndicator;
    import com.xvm.types.cfg.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import net.wg.gui.battle.views.*;
    import net.wg.gui.battle.views.debugPanel.*;
    // TODO:1.10.0
    //import net.wg.gui.battle.views.ticker.*;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.interfaces.*;
    import scaleform.clik.utils.*;
    import scaleform.gfx.*;

    public class BattleXvmView extends XvmViewBase
    {
        private static var _battlePageRef:WeakReference;

        public static function get battlePage():BaseBattlePage
        {
            return _battlePageRef.value as BaseBattlePage;
        }

        public static function get battlePageDebugPanel():DebugPanel
        {
            try
            {
                return battlePage["debugPanel"];
            }
            catch (ex:Error)
            {
            }
            return null;
        }
        /* TODO:1.10
        public static function get battlePageBattleTicker():BattleTicker
        {
            try
            {
                return battlePage["battleTicker"];
            }
            catch (ex:Error)
            {
            }
            return null;
        }
        */
        private var _battleController:BattleXvmComponentController = null;
        private var _battleClock:BattleClock = null;
        private var _battleElements:BattleElements = null;
        private var _battleLabels:BattleLabels = null;
        private var _zoomIndicator:ZoomIndicator = null;
        private var _watermark:MovieClip = null;
        private var hotkeys_cfg:CHotkeys;

        public function BattleXvmView(view:IView)
        {
            super(view);
            _battlePageRef = new WeakReference(super.view);

            _battleController = new BattleXvmComponentController();
            XfwUtils.getPrivateField(XfwUtils.getPrivateField(battlePage, "xfw_battleStatisticDataController"), "xfw_componentControllers").unshift(_battleController);
        }

        public override function onAfterPopulate(e:LifeCycleEvent):void
        {
            //Logger.add("onAfterPopulate: " + view.as_alias);
            super.onAfterPopulate(e);

            //Xvm.swfProfilerBegin("BattleXvmView.onAfterPopulate()");
            try
            {
                logBriefConfigurationInfo();

                Xvm.addEventListener(Defines.XVM_EVENT_CONFIG_LOADED, onConfigLoaded);
                Xfw.addCommandListener(XvmCommands.AS_ON_KEY_EVENT, onKeyEvent);
                Xfw.addCommandListener(XvmCommands.AS_ON_TARGET_CHANGED, onTargetChanged);

                onConfigLoaded(null);

                var behindMinimapIndex:int = battlePage.getChildIndex(battlePage.minimap) - 1;

                if (battlePageDebugPanel != null)
                {
                    if (Config.config.battle.clockFormat)
                    {
                        _battleClock = new BattleClock();
                        battlePageDebugPanel.addChild(_battleClock);
                    }
                }

                if (Config.config.battle.elements)
                {
                    if (Config.config.battle.elements.length)
                    {
                        _battleElements = new BattleElements();
                    }
                }

                _zoomIndicator = new ZoomIndicator();
                _zoomIndicator.visible = battlePageDebugPanel != null && battlePageDebugPanel.visible;
                battlePage.addChildAt(_zoomIndicator, behindMinimapIndex);

                _battleLabels = new BattleLabels(battlePage);
                _battleLabels.visible = battlePageDebugPanel != null && battlePageDebugPanel.visible;
                battlePage.addChildAt(_battleLabels, behindMinimapIndex);

                if (XfwUtils.endsWith(Config.config.__xvmVersion, "-dev"))
                {
                    createWatermark();
                }
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
            //Xvm.swfProfilerEnd("BattleXvmView.onAfterPopulate()");
        }

        override public function onBeforeDispose(e:LifeCycleEvent):void
        {
            super.onBeforeDispose(e);
            //Xvm.swfProfilerBegin("BattleXvmView.onBeforeDispose()");
            try
            {
                Xvm.removeEventListener(Defines.XVM_EVENT_CONFIG_LOADED, onConfigLoaded);
                Xfw.removeCommandListener(XvmCommands.AS_ON_KEY_EVENT, onKeyEvent);
                Xfw.removeCommandListener(XvmCommands.AS_ON_TARGET_CHANGED, onTargetChanged);
                if (_battleController)
                {
                    _battleController.dispose();
                    _battleController = null;
                }
                if (_battleClock)
                {
                    _battleClock.dispose();
                    _battleClock = null;
                }
                if (_battleElements)
                {
                    _battleElements.dispose();
                    _battleElements = null;
                }
                if (_battleLabels)
                {
                    _battleLabels.dispose();
                    _battleLabels = null;
                }
                if (_zoomIndicator)
                {
                    _zoomIndicator.dispose();
                    _zoomIndicator = null;
                }
                if (_watermark)
                {
                    _watermark = null;
                }
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
            //Xvm.swfProfilerEnd("BattleXvmView.onBeforeDispose()");
        }

        public override function onConfigLoaded(e:Event):void
        {
            //Logger.add("BattleXvmView.onConfigLoaded()");
            //Xvm.swfProfilerBegin(XfwUtils.stack());
            try
            {
                super.onConfigLoaded(e);
                hotkeys_cfg = Config.config.hotkeys;
                Xfw.cmd(BattleCommands.BATTLE_CTRL_SET_VEHICLE_DATA);
                Xfw.cmd(BattleCommands.XMQP_INIT);
                battlePage.updateStage(App.appWidth, App.appHeight);
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
            //Xvm.swfProfilerEnd(XfwUtils.stack());
        }

        // PRIVATE

        private function logBriefConfigurationInfo():void
        {
            Logger.add(
                "[XVM INFO]\n" +
                "                               XVM_VERSION=" + Config.config.__xvmVersion + " #" + Config.config.__xvmRevision + " for WoT " + Config.config.__wotVersion + "\n" +
                "                               gameRegion=" + Config.config.region + "\n" +
                "                               configVersion=" + Config.config.configVersion + "\n" +
                "                               autoReloadConfig=" + Config.config.autoReloadConfig + "\n" +
                "                               markers.enabled=" + Config.config.markers.enabled + "\n" +
                "                               servicesActive=" + Config.networkServicesSettings.servicesActive + "\n" +
                "                               xmqp=" + Config.networkServicesSettings.xmqp + "\n" +
                "                               statBattle=" + Config.networkServicesSettings.statBattle);
        }

        private function onKeyEvent(key:Number, isDown:Boolean):void
        {
            if (hotkeys_cfg.minimapZoom.enabled)
            {
                if (hotkeys_cfg.minimapZoom.keyCode == key)
                {
                    Xvm.dispatchEvent(new ObjectEvent(BattleEvents.MINIMAP_ZOOM, { isDown: isDown }));
                }
            }
            if (hotkeys_cfg.minimapAltMode.enabled)
            {
                if (hotkeys_cfg.minimapAltMode.keyCode == key)
                {
                    Xvm.dispatchEvent(new ObjectEvent(BattleEvents.MINIMAP_ALT_MODE, { isDown: isDown } ));
                }
            }
            if (hotkeys_cfg.playersPanelAltMode.enabled)
            {
                if (hotkeys_cfg.playersPanelAltMode.keyCode == key)
                {
                    Xvm.dispatchEvent(new ObjectEvent(BattleEvents.PLAYERS_PANEL_ALT_MODE, { isDown: isDown } ));
                }
            }
        }

        private function onTargetChanged(vehicleID:Number):void
        {
            if (vehicleID)
            {
                Xvm.dispatchEvent(new PlayerStateEvent(PlayerStateEvent.ON_TARGET_IN, vehicleID));
            }
            else
            {
                Xvm.dispatchEvent(new PlayerStateEvent(PlayerStateEvent.ON_TARGET_OUT));
            }
        }

        private function createWatermark():void
        {
            _watermark = new MovieClip();
            var textField:TextField = new TextField();
            textField.width = 200;
            textField.height = 50;
            textField.mouseEnabled = false;
            textField.selectable = false;
            textField.multiline = true;
            textField.wordWrap = false;
            textField.defaultTextFormat = new TextFormat("$FieldFont", 12, 0xFFFFFF, null, null, null, null, null, TextFormatAlign.CENTER, null, null, null, -2);
            textField.htmlText = "XVM Nightly Build <b>#" + Config.config.__xvmRevision + "</b>\nget stable version on https://modxvm.com";
            _watermark.addChild(textField);
            _watermark.x = -100;
            _watermark.y = 50;
            _watermark.alpha = 0;
            MovieClip(battlePage.prebattleTimer).win.addChildAt(_watermark, 0);
            App.utils.scheduler.scheduleTask(function():void { TweenLite.to(_watermark, 5, {alpha: 0.4}); }, 7000);
        }
    }
}
