/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.battle
{
    
    import flash.display.MovieClip;
    import flash.events.Event;
    import flash.text.TextField;
    import flash.text.TextFormat;
    import flash.text.TextFormatAlign;

    import com.greensock.TweenLite;

    import scaleform.clik.utils.WeakReference;

    import net.wg.gui.battle.battleRoyale.BattleRoyalePage;
    import net.wg.gui.battle.comp7.Comp7BattlePage;
    import net.wg.gui.battle.eventBattle.views.EventBattlePage;
    import net.wg.gui.battle.views.BaseBattlePage;
    CLIENT::LESTA {
        import net.wg.gui.battle.historicalBattles.HBBattlePage;
    }
    import net.wg.gui.battle.views.debugPanel.DebugPanel;
    import net.wg.infrastructure.events.LifeCycleEvent;
    import net.wg.infrastructure.helpers.statisticsDataController.BattleStatisticDataController;
    import net.wg.infrastructure.helpers.statisticsDataController.intarfaces.IBattleComponentDataController;
    import net.wg.infrastructure.interfaces.IView;

    import com.xfw.Logger;
    import com.xfw.Xfw;
    import com.xfw.XfwAccess;
    import com.xfw.XfwUtils;
    import com.xfw.events.ObjectEvent;

    import com.xvm.Config;
    import com.xvm.Defines;
    import com.xvm.Xvm;
    import com.xvm.XvmCommands;
    import com.xvm.battle.events.PlayerStateEvent;
    import com.xvm.battle.shared.battleClock.BattleClock;
    import com.xvm.battle.shared.battleLabels.BattleLabels;
    import com.xvm.battle.shared.elements.BattleElements;
    import com.xvm.battle.shared.zoomIndicator.ZoomIndicator;
    import com.xvm.infrastructure.XvmViewBase;
    import com.xvm.types.cfg.CHotkeys;


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

        /* TODO:1.10.0
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

            CLIENT::LESTA {
                // Prevent obsolete warnings about missing battleStatisticDataController
                // in Historical Battles game mode
                if (battlePage is HBBattlePage)
                {
                    return;
                }
            }

            _battleController = new BattleXvmComponentController();

            if (battlePage == null)
            {
                Logger.add("BattleXvmView::ctor() --> battlePage is null");
                return;
            }

            var bsdc:BattleStatisticDataController = XfwAccess.getPrivateField(battlePage, "battleStatisticDataController");
            if (bsdc == null)
            {
                Logger.add("BattleXvmView::ctor() --> failed to get battleStatisticDataController");
                return;
            }

            var cc:Vector.<IBattleComponentDataController> = XfwAccess.getPrivateField(bsdc, "_componentControllers");
            if (cc == null)
            {
                Logger.add("BattleXvmView::ctor() --> failed to get componentControllers");
                return;
            }

            cc.unshift(_battleController);
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

                var isSupportBattleType:Boolean = !(battlePage is BattleRoyalePage || battlePage is Comp7BattlePage || battlePage is EventBattlePage);
                CLIENT::LESTA {
                    isSupportBattleType = isSupportBattleType && !(battlePage is HBBattlePage);
                }

                if (Config.config.battle.elements && isSupportBattleType)
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
    }
}
