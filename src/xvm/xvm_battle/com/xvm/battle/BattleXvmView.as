/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.battle
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xfw.events.*;
    import com.xvm.infrastructure.*;
    import com.xvm.battle.battleClock.BattleClock;
    import com.xvm.battle.battleLabels.BattleLabels;
    import com.xvm.battle.elements.BattleElements;
    import com.xvm.battle.zoomIndicator.ZoomIndicator;
    import com.xvm.types.cfg.*;
    import flash.events.*;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.interfaces.*;
    import net.wg.data.constants.generated.*;
    import net.wg.gui.battle.random.views.*;
    import scaleform.clik.utils.*;

    public class BattleXvmView extends XvmViewBase
    {
        private static var _battlePageRef:WeakReference;
        private var hotkeys_cfg:CHotkeys;

        public static function get battlePage():BattlePage
        {
            return _battlePageRef.value as BattlePage;
        }

        private var _battleController:BattleXvmComponentController = null;
        private var _battleLabels:BattleLabels = null;
        private var _zoomIndicator:ZoomIndicator = null;
        private var _battleClock:BattleClock = null;
        private var _battleElements:BattleElements = null;

        public function BattleXvmView(view:IView)
        {
            super(view);
            _battlePageRef = new WeakReference(super.view);

            _battleController = new BattleXvmComponentController();
            battlePage.xfw_battleStatisticDataController.componentControllers.unshift(_battleController);
        }

        public override function onAfterPopulate(e:LifeCycleEvent):void
        {
            //Logger.add("onAfterPopulate: " + view.as_alias);
            //Xvm.swfProfilerBegin("BattleXvmView.onAfterPopulate()");
            super.onAfterPopulate(e);
            try
            {
                Xvm.addEventListener(Defines.XVM_EVENT_CONFIG_LOADED, onConfigLoaded);
                Xfw.addCommandListener(XvmCommands.AS_ON_KEY_EVENT, onKeyEvent);

                onConfigLoaded(null);

                var behindMinimapIndex:int = battlePage.getChildIndex(battlePage.minimap) - 1;

                _battleLabels = new BattleLabels();
                battlePage.addChildAt(_battleLabels, behindMinimapIndex);

                _zoomIndicator = new ZoomIndicator();
                battlePage.addChildAt(_zoomIndicator, behindMinimapIndex);

                if (Config.config.battle.clockFormat)
                {
                    _battleClock = new BattleClock();
                    battlePage.debugPanel.addChild(_battleClock);
                }

                if (Config.config.battle.elements && Config.config.battle.elements.length)
                {
                    _battleElements = new BattleElements();
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
            //Xvm.swfProfilerBegin("BattleXvmView.onBeforeDispose()");
            try
            {
                Xvm.removeEventListener(Defines.XVM_EVENT_CONFIG_LOADED, onConfigLoaded);
                Xfw.removeCommandListener(XvmCommands.AS_ON_KEY_EVENT, onKeyEvent);
                if (_battleController)
                {
                    _battleController.dispose();
                    _battleController = null;
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
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
            super.onBeforeDispose(e);
            //Xvm.swfProfilerEnd("BattleXvmView.onBeforeDispose()");
        }

        public override function onConfigLoaded(e:Event):void
        {
            //Logger.add("BattleXvmView.onConfigLoaded()");
            Xvm.swfProfilerBegin("BattleXvmView.onConfigLoaded()");
            try
            {
                super.onConfigLoaded(e);
                hotkeys_cfg = Config.config.hotkeys;
                Xfw.cmd(BattleCommands.BATTLE_CTRL_SET_VEHICLE_DATA);
                battlePage.updateStage(App.appWidth, App.appHeight);
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
            Xvm.swfProfilerEnd("BattleXvmView.onConfigLoaded()");
        }

        // PRIVATE

        private function onKeyEvent(key:Number, isDown:Boolean):void
        {
            if (hotkeys_cfg.minimapZoom.enabled && hotkeys_cfg.minimapZoom.keyCode == key)
                Xvm.dispatchEvent(new ObjectEvent(BattleEvents.MINIMAP_ZOOM, { isDown: isDown }));
            if (hotkeys_cfg.minimapAltMode.enabled && hotkeys_cfg.minimapAltMode.keyCode == key)
                Xvm.dispatchEvent(new ObjectEvent(BattleEvents.MINIMAP_ALT_MODE, { isDown: isDown } ));
            if (hotkeys_cfg.playersPanelAltMode.enabled && hotkeys_cfg.playersPanelAltMode.keyCode == key)
                Xvm.dispatchEvent(new ObjectEvent(BattleEvents.PLAYERS_PANEL_ALT_MODE, { isDown: isDown } ));
        }
    }
}
