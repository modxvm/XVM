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

        public static function get battlePage():BattlePage
        {
            return _battlePageRef.value as BattlePage;
        }

        private var _battleLabels:BattleLabels;
        private var _zoomIndicator:ZoomIndicator;
        private var _battleClock:BattleClock;
        //private var _sixthSenseIndicator:SixthSenseIndicator;

        public function BattleXvmView(view:IView)
        {
            super(view);
            _battlePageRef = new WeakReference(page);
        }

        public function get page():BattlePage
        {
            return super.view as BattlePage;
        }

        public override function onAfterPopulate(e:LifeCycleEvent):void
        {
            //Logger.add("onAfterPopulate: " + view.as_alias);
            super.onAfterPopulate(e);
            try
            {
                Xvm.addEventListener(Defines.XVM_EVENT_CONFIG_LOADED, onConfigLoaded);
                Xfw.addCommandListener(XvmCommands.AS_ON_KEY_EVENT, onKeyEvent);

                Stat.instance.addEventListener(Stat.COMPLETE_BATTLE, onStatLoaded);

                onConfigLoaded(null);

                var behindMinimapIndex:int = battlePage.getChildIndex(battlePage.minimap) - 1;

                _battleLabels = new BattleLabels();
                battlePage.addChildAt(_battleLabels, behindMinimapIndex);

                _zoomIndicator = new ZoomIndicator();
                battlePage.addChildAt(_zoomIndicator, behindMinimapIndex);

                if (Config.config.battle.clockFormat && Config.config.battle.clockFormat != "")
                    _battleClock = new BattleClock();
                battlePage.debugPanel.addChild(_battleClock);
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        override public function onBeforeDispose(e:LifeCycleEvent):void
        {
            try
            {
                Xvm.removeEventListener(Defines.XVM_EVENT_CONFIG_LOADED, onConfigLoaded);
                Xfw.removeCommandListener(XvmCommands.AS_ON_KEY_EVENT, onKeyEvent);
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
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
            super.onBeforeDispose(e);
        }

        private function onStatLoaded(e:ObjectEvent):void
        {
            //Logger.add("onStatLoaded");
            onConfigLoaded(null);
        }

        public override function onConfigLoaded(e:Event):void
        {
            //Logger.add("BattleXvmView.onConfigLoaded()");
            try
            {
                Xfw.cmd(BattleCommands.BATTLE_CTRL_SET_VEHICLE_DATA);
                page.updateStage(App.appWidth, App.appHeight);
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        // PRIVATE

        private function onKeyEvent(key:Number, isDown:Boolean):Object
        {
            var cfg:CHotkeys = Config.config.hotkeys;
            if (cfg.minimapZoom.enabled && cfg.minimapZoom.keyCode == key)
                Xvm.dispatchEvent(new ObjectEvent(BattleEvents.MINIMAP_ZOOM, { isDown: isDown }));
            if (cfg.minimapAltMode.enabled && cfg.minimapAltMode.keyCode == key)
                Xvm.dispatchEvent(new ObjectEvent(BattleEvents.MINIMAP_ALT_MODE, { isDown: isDown } ));
            if (cfg.playersPanelAltMode.enabled && cfg.playersPanelAltMode.keyCode == key)
                Xvm.dispatchEvent(new ObjectEvent(BattleEvents.PLAYERS_PANEL_ALT_MODE, { isDown: isDown } ));
            return null;
        }
    }
}
