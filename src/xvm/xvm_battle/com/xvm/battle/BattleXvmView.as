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
    import com.xvm.types.cfg.*;
    import flash.events.*;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.interfaces.*;
    import net.wg.data.constants.generated.*;
    import net.wg.gui.battle.random.views.*;

    public class BattleXvmView extends XvmViewBase
    {
        private static const XVM_BATTLE_COMMAND_BATTLE_CTRL_SET_VEHICLE_DATA:String = "xvm_battle.battleCtrlSetVehicleData";

        public function BattleXvmView(view:IView)
        {
            super(view);
        }

        public function get page():BattlePage
        {
            return super.view as BattlePage;
        }

        public override function onAfterPopulate(e:LifeCycleEvent):void
        {
            //Logger.add("onAfterPopulate: " + view.as_alias);
            super.onAfterPopulate(e);

            Xvm.addEventListener(Defines.XVM_EVENT_CONFIG_LOADED, onConfigLoaded);
            Xfw.addCommandListener(XvmCommands.AS_ON_KEY_EVENT, onKeyEvent);

            Stat.instance.addEventListener(Stat.COMPLETE_BATTLE, onStatLoaded);

            onConfigLoaded(null);
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
                Xfw.cmd(XVM_BATTLE_COMMAND_BATTLE_CTRL_SET_VEHICLE_DATA);
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
            // TODO
            //if ((BattleLabels.BoX.IsHotKeyedTextFieldsFlag) && (cfg.battleLabelsHotKeys))
            //    Xvm.dispatchEvent(new ObjectEvent(BattleEvents.BATTLE_LABEL_KEY_MODE, { isDown: isDown }));

            return null;
        }
    }
}
